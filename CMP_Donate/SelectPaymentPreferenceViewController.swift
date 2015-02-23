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

        // Do any additional setup after loading the view.
    }

    @IBAction func onCreditCardTapped(sender: UIButton) {
        kStandardDefaults.setValue(kDefaultsCreditCard, forKey: kDefaultsPreferredPaymentType)
    }

    @IBAction func OnPayPalTapped(sender: UIButton) {
        kStandardDefaults.setValue(kDefaultsPayPal, forKey: kDefaultsPreferredPaymentType)
    }
}
