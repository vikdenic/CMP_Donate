//
//  EditProfileViewController.swift
//  CMP_Donate
//
//  Created by Vik Denic on 2/7/15.
//  Copyright (c) 2015 mobilemakers. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //UITableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0
        {
            return "Account"
        }
        else
        {
            return "Payment"
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0
        {
            return 2
        }
        else
        {
            return 1
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(kEditProfileCell) as UITableViewCell

        if indexPath.section == 0
        {
            if indexPath.row == 0
            {
                cell.textLabel?.text = "Edit Profile"
            }
            else
            {
                cell.textLabel?.text = "Change Password"
            }
        }
        else
        {
            cell.textLabel?.text = "Update Credit Card"
        }

        return cell
    }
}
