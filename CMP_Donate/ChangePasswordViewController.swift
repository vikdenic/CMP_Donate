//
//  ChangePasswordViewController.swift
//  CMP_Donate
//
//  Created by Vik Denic on 3/2/15.
//  Copyright (c) 2015 Chicago Media Project. All rights reserved.
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
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! PasswordEntryTableViewCell!
        cell.entryTextField.becomeFirstResponder()
    }

    @IBAction func onSaveTapped(sender: UIBarButtonItem) {
        let cellOne = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! PasswordEntryTableViewCell!
        let cellTwo = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1)) as! PasswordEntryTableViewCell!
        let cellThree = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 1)) as! PasswordEntryTableViewCell!

        if cellOne.entryTextField.text == kStandardDefaults.valueForKey(kDefaultsPword) as! String! && (cellTwo.entryTextField.text as NSString).length > 5 && cellTwo.entryTextField.text == cellThree.entryTextField.text
        {
            kProfile?.user.password = cellTwo.entryTextField.text.lowercaseString
            kProfile?.saveInBackgroundWithBlock({ (succeeded, error) -> Void in
                if error != nil
                {
                    showAlertWithError(error, self)
                }
                else
                {
                    self.navigationController?.popViewControllerAnimated(true)
                }
            })
        }
        else
        {
            showAlert("Current Password must be correct, and new password fields must match.", nil, self)
        }
    }

    func textFieldDidEndEditing(textField: UITextField) {

        if textField.tag == kTFOneTag
        {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! PasswordEntryTableViewCell!
            if textField.text != kStandardDefaults.valueForKey(kDefaultsPword) as! String!
            {
                cell.imageView!.image = UIImage(named: "lockIconRed")
            }
            else
            {
                cell.imageView!.image = UIImage(named: "lockIcon")
            }

            let otherCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1)) as! PasswordEntryTableViewCell!
            if (otherCell.entryTextField.text as NSString).length < 6
            {

            }
            else
            {
                saveBarButtonItem.enabled = true
            }
        }

        if textField.tag == kTFTwoTag
        {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1)) as! PasswordEntryTableViewCell!
            if (textField.text as NSString).length < 6
            {
                cell.imageView!.image = UIImage(named: "lockIconRed")
            }
            else
            {
                cell.imageView!.image = UIImage(named: "lockIcon")

            }

            let otherCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! PasswordEntryTableViewCell!
            if otherCell.entryTextField.text != kStandardDefaults.valueForKey(kDefaultsPword) as! String!
            {
            }
            else
            {
                saveBarButtonItem.enabled = true
            }
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kPasswordEntryCell) as! PasswordEntryTableViewCell
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
