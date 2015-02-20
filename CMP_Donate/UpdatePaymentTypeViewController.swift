//
//  UpdatePaymentTypeViewController.swift
//  CMP_Donate
//
//  Created by Vik Denic on 2/19/15.
//  Copyright (c) 2015 mobilemakers. All rights reserved.
//

import UIKit

class UpdatePaymentTypeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet var picker: UIPickerView!
    let pickData = ["Credit Card", "PayPal"]
    @IBOutlet var updateButton: UIButton!
    @IBOutlet var preferredStatusLabel: UILabel!
    var selectedStatus : String!
    @IBOutlet var saveButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateButton.layer.borderColor = UIColor.customRedColor().CGColor
        updateButton.layer.borderWidth = 1.0
        updateButton.layer.cornerRadius = updateButton.frame.height / 2
        if let somePreference = kStandardDefaults.valueForKey(kDefaultsPreferredPaymentType) as String!
        {
            selectedStatus = somePreference
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

    //Picker
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickData[row]
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            if row == 0
            {
                self.updateButton.alpha = 1
                self.selectedStatus = "CreditCard"
            }
            else if row == 1
            {
                self.updateButton.alpha = 0
                self.selectedStatus = "PayPal"
            }
        })
    }
}
