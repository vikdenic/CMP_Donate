//
//  IndividualFilmViewController.swift
//  CMP_Donate
//
//  Created by Vik Denic on 1/25/15.
//  Copyright (c) 2015 Chicago Media Project. All rights reserved.
//

import UIKit

class IndividualFilmViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, DonateTableViewCellDelegate {

    var film = Film()
    @IBOutlet var tableView: UITableView!
    var theIndexPath = NSIndexPath()
    var synopsisHeight : CGFloat = 28

    //View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = film.title
    }

    //UITableView
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 180))
        let filmImageView = PFImageView(frame: CGRectMake(0, 0, headerView.frame.size.width, headerView.frame.size.height))
        filmImageView.contentMode = .ScaleAspectFill
        filmImageView.clipsToBounds = true
        filmImageView.file = film.imageFile
        filmImageView.loadInBackground(nil)
        headerView.addSubview(filmImageView)
        return headerView
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 180
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if indexPath.row == 0
        {
            let cell = tableView.dequeueReusableCellWithIdentifier(kCrewTVCell) as CrewTableViewCell
            return cell
        }
        else if indexPath.row == 1
        {
            let cell = tableView.dequeueReusableCellWithIdentifier(kSynopsisCell) as SynopsisTableViewCell
            cell.synopsisTextView.text = film.synopsis
            theIndexPath = indexPath
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier(kDonateCell) as DonateTableViewCell
            cell.delegate = self
            let suggestedAmountOne = film.suggestedAmountOne ?? 100
            let suggestedAmountTwo = film.suggestedAmountTwo ?? 500
            let suggestedAmountThree = film.suggestedAmountTwo ?? 1000

            cell.bubbleButtonOne.setTitle("$" + suggestedAmountOne.stringValue, forState: .Normal)
            cell.bubbleButtonTwo.setTitle("$" + suggestedAmountTwo.stringValue, forState: .Normal)
            cell.bubbleButtonThree.setTitle("$" + suggestedAmountThree.stringValue, forState: .Normal)

            return cell
        }
    }

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if indexPath.row == 0
        {
            let customCell = cell as CrewTableViewCell
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
            return 128
        }
        else
        {
            return 165
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
    }

    func showCustomAlertView(amount : NSNumber)
    {
        let alert = SCLAlertView()

        alert.addButton("Confirm", action: { () -> Void in
            self.chargeCustomer(amount)
        })

        alert.showCustomAlert("Contribute?", image: UIImage(named: "CMPLogo")!, color: UIColor.customRedColor(), subTitle: "Donate $\(amount) to \(film.title)?", closeButtonTitle: "Cancel", duration: 0)
    }

    //Helpers
    func chargeCustomer(amount : NSNumber)
    {
        let alert = SCLAlertView()

        let amountToCharge = (amount as Double * 100.0)
        if let customerId = kStandardDefaults.valueForKey(kDefaultsCustomerID) as String!
        {
            PFCloud.callFunctionInBackground("createCharge", withParameters: ["amount": amountToCharge, "customer": customerId]) { (chargeId, error) -> Void in
                if error != nil
                {
                    println(error.localizedDescription)
                }
                else
                {
                    println("Charge successful")
                    alert.showSuccess("Thank You!", subTitle: "Your contribution was approved. You will receive a receipt via email shortly.", closeButtonTitle: "Done", duration: 0)
                }
            }
        }

        else
        {
            alert.showNotice("Payment Info Needed", subTitle: "Please update your Profile with your payment information.", closeButtonTitle: "Okay", duration: 0)
        }
    }

    //DonateTableViewCell
    func didTapBubbleOne(amount: NSNumber) {
        showCustomAlertView(amount)
    }

    func didTapBubbleTwo(amount: NSNumber) {
        println(amount)
    }

    func didTapBubbleThree(amount: NSNumber) {
        println(amount)
    }

    func didTapOtherAmount() {
        println("other")
    }

    //UICollectionView
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return film.productionTeam.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCrewCVCell, forIndexPath: indexPath) as CrewCollectionViewCell
        let crewMember = film.productionTeam[indexPath.row] as CrewMember
        cell.crewLabel.text = crewMember.role + ": " + crewMember.name
        cell.crewImageView.file = crewMember.imageFile
        cell.crewImageView.loadInBackground(nil)
        return cell
    }
}
