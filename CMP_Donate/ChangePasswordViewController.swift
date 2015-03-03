//
//  ChangePasswordViewController.swift
//  CMP_Donate
//
//  Created by Vik Denic on 3/2/15.
//  Copyright (c) 2015 mobilemakers. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var saveBarButtonItem: UIBarButtonItem!

    let kTFOneTag = 99
    let kTFTwoTag = 98
    let kTFThreeTag = 97

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        saveBarButtonItem.enabled = false
    }

    override func viewDidAppear(animated: Bool) {
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as PasswordEntryTableViewCell!
        cell.entryTextField.becomeFirstResponder()
    }

    @IBAction func onSaveTapped(sender: UIBarButtonItem) {

    }

    func textFieldDidEndEditing(textField: UITextField) {

        if textField.tag == kTFOneTag
        {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as PasswordEntryTableViewCell!
            if textField.text != kStandardDefaults.valueForKey(kDefaultsPword) as String!
            {
                cell.imageView!.image = UIImage(named: "lockIconRed")
            }
            else
            {
                cell.imageView!.image = UIImage(named: "lockIcon")
            }
        }

        if textField.tag == kTFOneTag
        {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as PasswordEntryTableViewCell!
            if textField.text != kStandardDefaults.valueForKey(kDefaultsPword) as String!
            {
                cell.imageView!.image = UIImage(named: "lockIconRed")
            }
            else
            {
                cell.imageView!.image = UIImage(named: "lockIcon")
            }
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kPasswordEntryCell) as PasswordEntryTableViewCell
        cell.imageView!.image = UIImage(named: "lockIcon")
        cell.entryTextField.delegate = self

        if indexPath.section == 0
        {
            cell.entryTextField.placeholder = "Current Password"
            cell.entryTextField.tag = kTFOneTag
        }
        else
        {
            if indexPath.row == 0
            {
                cell.entryTextField.placeholder = "New Password"
                cell.entryTextField.tag = kTFTwoTag
            }
            else
            {
                cell.entryTextField.placeholder = "New Password, again"
                cell.entryTextField.tag = kTFThreeTag
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
