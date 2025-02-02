//
//  IndividualFilmViewController.swift
//  CMP_Donate
//
//  Created by Vik Denic on 1/25/15.
//  Copyright (c) 2015 Chicago Media Project. All rights reserved.
//

import UIKit
import Alamofire

class IndividualFilmViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, DonateTableViewCellDelegate, UIScrollViewDelegate, PayPalPaymentDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate {

    var film = Film(className: "Film")

    @IBOutlet var tableView: UITableView!
    @IBOutlet var filmImageView: PFImageView!
//    var visualEffectView = UIVisualEffectView()
    let textFieldAlert = SCLAlertView()

    var headerView: UIView!
    var theIndexPath = NSIndexPath()
    var synopsisHeight : CGFloat = 28

    let kTableHeaderHeight: CGFloat = 120.0

    //MARK: PayPal Properties
    var payPalConfiguration = PayPalConfiguration()
    var accessDictionary : NSDictionary!
    var accessToken : String!
    var theCompletedPayment : PayPalPayment!
    var thePaymentId : String!
    var theVerifiedPaymentDict : NSDictionary!
    let kAccessToken = "access_token"
    let kResponse = "response"
    let kId = "id"

    //MARK: ActivityViewController Properties
    var shareImage = UIImage()
    ///To be set via Parse Config when the view loads
    var shareLink = String()

    //MARK: Currency Conversion Properties
    /// For jsonrates API
    let rateKey = "jr-850d1e0bc3c23bed30132ee78f4e16c2" as String!

    //MARK: General Payment Properties
    /// To select between PayPal or Credit Card if first time contributing
    let selectPaymentVC = SelectPaymentPreferenceViewController()

    /// The most recent payment type the user has preferred to use for contributions
    var preferredPaymentType = kStandardDefaults.valueForKey(kDefaultsPreferredPaymentType) as! String?

    //MARK: Currency Conversion Properties
    var convertedCurrencyStringOne : String!
    var convertedCurrencyStringTwo : String!
    var convertedCurrencyStringThree : String!

    //MARK: init
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        // See PayPalConfiguration.h for details and default values.
        // Should you wish to change any of the values, you can do so here.
        // For example, if you wish to accept PayPal but not payment card payments, then add:
        payPalConfiguration.acceptCreditCards = false
        // Or if you wish to have the user choose a Shipping Address from those already
        // associated with the user's PayPal account, then add:
        payPalConfiguration.payPalShippingAddressOption = PayPalShippingAddressOption.PayPal
    }

    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        title = film.title

        filmImageView.file = film.imageFile
        filmImageView.loadInBackground(nil)

        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)

        hideNavBar()

        //makes the scroll view content area larger without changing the size of the subview or the size of the view’s content
        tableView.contentInset = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0)
        //always the current location of the top-left corner of the scroll bounds, whether scrolling is in progress or not.
        tableView.contentOffset = CGPoint(x: 0, y: -kTableHeaderHeight)

        updateHeaderView()

        addLeftEdgeGesture()

        PPDataManager.httpRequestAccessToken(kPayPalClientIdProduction, secretId: kPayPalSecretIdProduction) { (data, error) -> Void in
            if let someData : AnyObject = data
            {
                self.accessDictionary = data as! NSDictionary
                self.accessToken = self.accessDictionary.valueForKey(self.kAccessToken) as! String!
            }
        }

        film.imageFile.getDataInBackgroundWithBlock { (data, error) -> Void in
            if error != nil
            {
                
            }
            else
            {
                self.shareImage = UIImage(data: data)!
            }
        }

        PFConfig.getConfigInBackgroundWithBlock { (config, error) -> Void in
            if error != nil
            {
                self.shareLink = "http://www.chicagomediaproject.org"
            }
            else
            {
                self.shareLink = config["shareLink"] as! String
            }
        }

//        //Add blur effect view, also as a subview of the tableView
//        visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark)) as UIVisualEffectView
//        visualEffectView.alpha = 0
//        tableView.addSubview(visualEffectView)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        PayPalMobile.preconnectWithEnvironment(PayPalEnvironmentProduction)

        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! CrewTableViewCell!
        cell.pageDots.center.x = cell.pageDots.superview!.center.x
        cell.pageDots.numberOfPages = film.productionTeam.count

        if film.productionTeam.count <= 1
        {
            cell.pageDots.alpha = 0
        }

        VZCurrency.obtainConversationRateForCurrentLocale { (rate) -> Void in
            if rate != 1.0
            {
                let convertedAmountOne = (self.film.suggestedAmountOne.floatValue * rate) as! NSNumber
                let convertedAmountTwo = (self.film.suggestedAmountTwo.floatValue * rate) as! NSNumber
                let convertedAmountThree = (self.film.suggestedAmountThree.floatValue * rate) as! NSNumber

                self.convertedCurrencyStringOne = convertedAmountOne.formatCurrencyWithSymbol()
                self.convertedCurrencyStringTwo = convertedAmountTwo.formatCurrencyWithSymbol()
                self.convertedCurrencyStringThree = convertedAmountThree.formatCurrencyWithSymbol()
            }
            self.tableView.reloadData()
        }
    }

    //MARK: View Helpers
    func updateHeaderView() {
        var headerRect = CGRect(x: 0, y: -kTableHeaderHeight, width: tableView.bounds.width, height: kTableHeaderHeight)

        //If user pulling down
        if tableView.contentOffset.y < -kTableHeaderHeight
        {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
            //            var blurAdjustment = -tableView.contentOffset.y / 180 - 0.8
            //            visualEffectView.alpha = blurAdjustment
        }
            //If user scrolling up
        else
        {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
        //give both the blur effect and image (which is the tableHeaderView) this adjusted frame
        //        visualEffectView.frame = headerRect
        headerView.frame = headerRect
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        view.endEditing(true)
    }

    //MARK: Navigation Helpers
    override func prefersStatusBarHidden() -> Bool {
        return true
    }


    func hideNavBar()
    {
        navigationController?.navigationBarHidden = true

        let backButton = UIButton(frame: CGRectMake(8, 31, 60, 60))
        backButton.setImage(UIImage(named: "backImage"), forState: .Normal)
        backButton.imageView?.contentMode = .ScaleAspectFit
        backButton.imageEdgeInsets = UIEdgeInsetsMake(-38, -46, 0, 0)
        backButton.addTarget(self, action: "onBackTapped", forControlEvents: .TouchUpInside)
        view.addSubview(backButton)
    }

    func onBackTapped()
    {
        navigationController?.popViewControllerAnimated(true)
    }

    func addLeftEdgeGesture()
    {
        let leftEdgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "handleLeftEdgeGesture")
        leftEdgeGesture.edges = .Left
        leftEdgeGesture.delegate = self
        view.addGestureRecognizer(leftEdgeGesture)
    }

    func handleLeftEdgeGesture()
    {
        navigationController?.popViewControllerAnimated(true)
    }

    //MARK: UITableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if indexPath.row == 0
        {
            let cell = tableView.dequeueReusableCellWithIdentifier(kCrewTVCell) as! CrewTableViewCell
            return cell
        }
        else if indexPath.row == 1
        {
            let cell = tableView.dequeueReusableCellWithIdentifier(kSynopsisCell) as! SynopsisTableViewCell
            cell.synopsisTextView.text = film.synopsis
            theIndexPath = indexPath
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier(kDonateCell) as! DonateTableViewCell
            cell.delegate = self
            let suggestedAmountOne = film.suggestedAmountOne ?? 100
            let suggestedAmountTwo = film.suggestedAmountTwo ?? 500
            let suggestedAmountThree = film.suggestedAmountThree ?? 1000

            cell.bubbleButtonOne.setTitle("$" + suggestedAmountOne.stringValue, forState: .Normal)
            cell.bubbleButtonTwo.setTitle("$" + suggestedAmountTwo.stringValue, forState: .Normal)
            cell.bubbleButtonThree.setTitle("$" + suggestedAmountThree.stringValue, forState: .Normal)

            if let someConvertedAmountOne = self.convertedCurrencyStringOne
            {
                cell.bubbleButtonOne.setTitle(someConvertedAmountOne, forState: .Normal)
            }

            if let someConvertedAmountTwo = self.convertedCurrencyStringTwo
            {
                cell.bubbleButtonTwo.setTitle(someConvertedAmountTwo, forState: .Normal)
            }

            if let someConvertedAmountThree = self.convertedCurrencyStringThree
            {
                cell.bubbleButtonThree.setTitle(someConvertedAmountThree, forState: .Normal)
            }

            return cell
        }
    }

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if indexPath.row == 0
        {
            let customCell = cell as! CrewTableViewCell
            customCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, index: indexPath.row)
        }
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if indexPath.row == 1
        {
            return synopsisHeight
        }
        else if indexPath.row == 0
        {
            return 130
        }
        else
        {
            return 165
        }
    }

    //MARK: UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
    }

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView.tag == kCrewScrollViewTag
        {
            let pageNumber = Int(scrollView.contentOffset.x / (scrollView.frame.size.width))

            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! CrewTableViewCell!
            cell.pageDots.currentPage = pageNumber
        }
    }

    //Actions
    @IBAction func onSynopsisTapped(sender: UITapGestureRecognizer)
    {
        if editing == false
        {
            synopsisHeight = 147
            tableView.beginUpdates()
            tableView.endUpdates()
            editing = true
        }
        else
        {
            synopsisHeight = 28
            tableView.beginUpdates()
            tableView.endUpdates()
            editing = false
        }
        updateHeaderView()
    }

    @IBAction func onShareTapped(sender: UIButton)
    {

        let activityProvider = CustomActivityItemProvider(text: film.title, link: shareLink)

        let postItems = [activityProvider]

        let activityVC = UIActivityViewController(activityItems: postItems, applicationActivities: nil)

        presentViewController(activityVC, animated: true, completion: nil)
    }

    //MARK: SCLAlertView
    func showCustomAlertView(amount : NSNumber)
    {
        let alert = SCLAlertView()

        alert.addButton("Confirm", action: { () -> Void in
            self.chargeCustomer(amount)
        })

        alert.showCustomAlert("Contribute?", image: UIImage(named: "CMPLogo")!, color: UIColor.customRedColor(), subTitle: "Donate $\(amount) to \(film.title)?", closeButtonTitle: "Cancel", duration: 0)
    }

    //MARK: Stripe
    func pay(amount : NSNumber)
    {
        // Create a PayPalPayment
        let payment = PayPalPayment()

        // Amount, currency, and description
        payment.amount = NSDecimalNumber(string: amount.stringValue)
        payment.currencyCode = "USD"
        payment.shortDescription = film.title

        // Use the intent property to indicate that this is a "sale" payment,
        // meaning combined Authorization + Capture.
        // To perform Authorization only, and defer Capture to your server,
        // use PayPalPaymentIntentAuthorize.
        // To place an Order, and defer both Authorization and Capture to
        // your server, use PayPalPaymentIntentOrder.
        // (PayPalPaymentIntentOrder is valid only for PayPal payments, not credit card payments.)
        payment.intent = .Sale

        // If your app collects Shipping Address information from the customer,
        // or already stores that information on your server, you may provide it here.
        //payment.shippingAddress = address /// a previously-created PayPalShippingAddress object

        // Several other optional fields that you can set here are documented in PayPalPayment.h,
        // including paymentDetails, items, invoiceNumber, custom, softDescriptor, etc.

        // Check whether payment is processable.
        if (!payment.processable) {
            // If, for example, the amount was negative or the shortDescription was empty, then
            // this payment would not be processable. You would want to handle that here.
        }

        // Create a PayPalPaymentViewController.
        let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfiguration, delegate: self)

        // Present the PayPalPaymentViewController.
        presentViewController(paymentViewController, animated: true, completion: nil)
    }

    func chargeCustomer(amount : NSNumber)
    {
        let alert = SCLAlertView()

        let amountToCharge = (amount as Double * 100.0)

        if let customerId = kStandardDefaults.valueForKey(kDefaultsStripeCustomerID) as! String!
        {
            PFCloud.callFunctionInBackground("createCharge", withParameters: ["amount": amountToCharge, "customer": customerId, "description": film.title,"receipt_email": PFUser.currentUser().username]) { (chargeId, error) -> Void in
                if error != nil
                {
                    alert.showError("Uh oh", subTitle: "Payment unsuccessful", closeButtonTitle: "Okay", duration: 0)
                    println(error.localizedDescription)
                }
                else
                {
                    println("Charge successful")
                    alert.showSuccess("Thank You!", subTitle: "Your contribution was approved. You will receive a receipt via email shortly.", closeButtonTitle: "Done", duration: 0)

                    let transaction = Transaction(contributor: kProfile!, film: self.film, amount: amount)
                    transaction.saveInBackgroundWithBlock(nil)
                }
            }
        }

        else
        {
            alert.showNotice("Payment Info Needed", subTitle: "Please update your Profile with your payment information.", closeButtonTitle: "Okay", duration: 0)
        }
    }

    //MARK: PayPal
    func payPalPaymentDidCancel(paymentViewController: PayPalPaymentViewController!) {
        // The payment was canceled; dismiss the PayPalPaymentViewController.
        dismissViewControllerAnimated(true, completion: nil)
    }

    func verifyComlpetedPayment(completedPayment : PayPalPayment)
    {
        // Send the entire confirmation dictionary
        let confirmation = NSJSONSerialization.dataWithJSONObject(completedPayment.confirmation, options: nil, error: nil)

        // Send confirmation to your server; your server should verify the proof of payment
        // and give the user their goods or services. If the server is not reachable, save
        // the confirmation and try again later.
    }

    func payPalPaymentViewController(paymentViewController: PayPalPaymentViewController!, didCompletePayment completedPayment: PayPalPayment!) {
        // Payment was processed successfully; send to server for verification and fulfillment.
        theCompletedPayment = completedPayment
        verifyComlpetedPayment(theCompletedPayment)

        //This is where we extract the paymentId from the approved payment object
        let completedConfirmation = completedPayment.confirmation as NSDictionary!
        let response = completedConfirmation.valueForKey(kResponse) as! NSDictionary!
        thePaymentId = response.valueForKey(kId) as! String!

        let transaction = Transaction(contributor: kProfile!, film: self.film, amount: completedPayment.amount)
        transaction.saveInBackgroundWithBlock(nil)

        //This is where we verify the payment
        //        PPDataManager.httpVerifyPayment(accessToken, paymentId: thePaymentId) { (data, error) -> Void in
        //            println(data)
        //        }
//        PPDataManager.httpVerifyPayment(accessToken, paymentId: thePaymentId, viewController: self) { (data, error) -> Void in
//            self.theVerifiedPaymentDict = data as NSDictionary!
//
//            //Compare SDK completed payement with the server's verified payment
//            if self.theVerifiedPaymentDict.valueForKey("payer")!.valueForKey("status")!.isEqualToString("VERIFIED") && (self.theVerifiedPaymentDict.valueForKey("id")! as NSString).isEqualToString(self.thePaymentId)
//            {
//                println("it's verified and the id matches")
//                let transaction = Transaction(contributor: kProfile!, film: self.film, amount: completedPayment.amount)
//                transaction.saveInBackgroundWithBlock(nil)
//            }
//            else
//            {
//                println("cannot verify payment at this time")
//            }
//        }

        // Dismiss the PayPalPaymentViewController.
        dismissViewControllerAnimated(true, completion: nil)
    }

    //MARK: Payment Helpers
    func presentPreferredPaymentMethod(amount: NSNumber)
    {
        if let somePreference = kStandardDefaults.valueForKey(kDefaultsPreferredPaymentType) as! String!
        {
            if somePreference == "CreditCard"
            {
                showCustomAlertView(amount)
            }
            else if somePreference == "PayPal"
            {
                pay(amount)
            }
        }
        else
        {
            performSegueWithIdentifier(kIndividualFilmToSelectPreferenceSegue, sender: nil)
        }
    }

    func presentCustomAmountEntry()
    {
        let alert = UIAlertController(title: "Contribute Custom Amount (in $USD)", message: nil, preferredStyle: .Alert)

        var theTextField = UITextField()
        alert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Amount here"
            textField.keyboardType = UIKeyboardType.DecimalPad
            theTextField = textField
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)

        let action = UIAlertAction(title: "Next", style: .Default) { (action) -> Void in
            let theAmount = (theTextField.text as NSString).floatValue
            self.presentPreferredPaymentMethod(theAmount)
        }

        alert.addAction(cancelAction)
        alert.addAction(action)

        presentViewController(alert, animated: true, completion: nil)
    }

    //MARK: DonateTableViewCellDelegate
    func didTapBubbleOne(amount: NSNumber) {
        presentPreferredPaymentMethod(amount)
    }

    func didTapBubbleTwo(amount: NSNumber) {
        presentPreferredPaymentMethod(amount)
    }

    func didTapBubbleThree(amount: NSNumber) {
        presentPreferredPaymentMethod(amount)
    }

    func didTapOtherAmount() {
        presentCustomAmountEntry()
    }

    //MARK: UICollectionView
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return film.productionTeam.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCrewCVCell, forIndexPath: indexPath) as! CrewCollectionViewCell
        let crewMember = film.productionTeam[indexPath.row] as CrewMember
        cell.crewLabel.text = crewMember.role + ": " + crewMember.name
        cell.crewImageView.file = crewMember.imageFile
        cell.crewImageView.loadInBackground(nil)
        return cell
    }
}
