//
//  IndividualFilmViewController.swift
//  CMP_Donate
//
//  Created by Vik Denic on 1/25/15.
//  Copyright (c) 2015 Chicago Media Project. All rights reserved.
//

import UIKit

class IndividualFilmViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, DonateTableViewCellDelegate, UIScrollViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate {

    var film = Film(className: "Film")

    @IBOutlet var tableView: UITableView!
    @IBOutlet var filmImageView: PFImageView!
//    var visualEffectView = UIVisualEffectView()
    let textFieldAlert = SCLAlertView()

    var headerView: UIView!
    var theIndexPath = NSIndexPath()
    var synopsisHeight : CGFloat = 147

    let kTableHeaderHeight: CGFloat = 120.0

    //MARK: PayPal Properties
    var accessDictionary : NSDictionary!
    var accessToken : String!
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

    //MARK: init
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)

        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! CrewTableViewCell!
        cell.pageDots.center.x = cell.pageDots.superview!.center.x
        cell.pageDots.numberOfPages = film.productionTeam.count

        if film.productionTeam.count <= 1
        {
            cell.pageDots.alpha = 0
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
        }
        //If user scrolling up
        else
        {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
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
            return 62
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
