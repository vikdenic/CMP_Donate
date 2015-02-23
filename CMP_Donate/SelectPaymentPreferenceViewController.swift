//
//  SelectPaymentPreferenceViewController.swift
//  CMP_Donate
//
//  Created by Vik Denic on 2/22/15.
//  Copyright (c) 2015 mobilemakers. All rights reserved.
//

import UIKit

class SelectPaymentPreferenceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onCancelTapped(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onCreditCardTapped(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: { () -> Void in
            kStandardDefaults.setValue(kDefaultsCreditCard, forKey: kDefaultsPreferredPaymentType)
        })
    }

    @IBAction func OnPayPalTapped(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: { () -> Void in
            kStandardDefaults.setValue(kDefaultsPayPal, forKey: kDefaultsPreferredPaymentType)
        })
    }
}
