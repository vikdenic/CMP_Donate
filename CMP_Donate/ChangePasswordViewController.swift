//
//  ChangePasswordViewController.swift
//  CMP_Donate
//
//  Created by Vik Denic on 3/2/15.
//  Copyright (c) 2015 mobilemakers. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kPasswordEntryCell) as PasswordEntryTableViewCell
        cell.imageView!.image = UIImage(named: "lockIcon")

        if indexPath.section == 0
        {
            cell.entryTextField.placeholder = "Current Password"
        }
        else
        {
            if indexPath.row == 0
            {
                cell.entryTextField.placeholder = "New Password"

            }
            else
            {
                cell.entryTextField.placeholder = "New Password, again"
            }
        }

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return 1
        }
        else
        {
            return 2
        }
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
}
