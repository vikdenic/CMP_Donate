//
//  UpdatePaymentTypeViewController.swift
//  CMP_Donate
//
//  Created by Vik Denic on 2/19/15.
//  Copyright (c) 2015 mobilemakers. All rights reserved.
//

import UIKit

class UpdatePaymentTypeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    let pickData = ["Credit Card", "PayPal"]
    @IBOutlet var updateButton: UIButton!
    @IBOutlet var preferredStatusLabel: UILabel!
    var selectedStatus : String!
    @IBOutlet var saveButton: UIBarButtonItem!

    var prev = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateButton.layer.borderColor = UIColor.customRedColor().CGColor
        updateButton.layer.borderWidth = 1.0
        updateButton.layer.cornerRadius = updateButton.frame.height / 2
        if let somePreference = kStandardDefaults.valueForKey(kDefaultsPreferredPaymentType) as String!
        {
            selectedStatus = somePreference
            println(somePreference)
        }
    }

    override func viewWillAppear(animated: Bool) {
        if let someStatus = selectedStatus
        {
            if selectedStatus == "PayPal"
            {
                preferredStatusLabel.text = "Currently prefer PayPal"
                preferredStatusLabel.backgroundColor = UIColor.customDarkGreenColor()
            }
            else if selectedStatus == "CreditCard"
            {
                preferredStatusLabel.text = "Currently prefer card ending in \(kStandardDefaults.valueForKey(kDefaultsStripeCardLast4)!)"
                preferredStatusLabel.backgroundColor = UIColor.customDarkGreenColor()
            }
        }
        else
        {
            preferredStatusLabel.text = "No preferred method currently set"
            preferredStatusLabel.backgroundColor = UIColor.darkGrayColor()
        }
    }

    override func viewDidAppear(animated: Bool) {
        if let somePreference = kStandardDefaults.valueForKey(kDefaultsPreferredPaymentType) as String!
        {
            if somePreference == "CreditCard"
            {
                prev = 0
                let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as UITableViewCell!
                cell.accessoryType = .Checkmark
                updateButton.alpha = 1
            }
            else if somePreference == "PayPal"
            {
                prev = 1
                let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1)) as UITableViewCell!
                cell.accessoryType = .Checkmark
                updateButton.alpha = 0
            }
        }
    }

    //UITableView
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kPreferredPaymentCell) as UITableViewCell

        if indexPath.section == 0
        {
            cell.textLabel?.text = pickData[0]
        }
        else
        {
            cell.textLabel?.text = pickData[1]
        }

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }


    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!
        let otherCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: prev)) as UITableViewCell!

        if cell.accessoryType == .None
        {
            cell.accessoryType = .Checkmark
            otherCell.accessoryType = .None
            prev = indexPath.section
        }
        else
        {
            cell.accessoryType = .None
        }

        if indexPath.section == 0
        {
            selectedStatus = "CreditCard"

            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.updateButton.alpha = 1
            })
        }
        else
        {
            selectedStatus = "PayPal"
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.updateButton.alpha = 0
            })
        }
    }
}
