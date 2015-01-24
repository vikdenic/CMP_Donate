//
//  FeedViewController.swift
//  CMP_Donate
//
//  Created by Vik Denic on 1/24/15.
//  Copyright (c) 2015 mobilemakers. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if PFUser.currentUser() == nil
        {
            performSegueWithIdentifier(kFeedToRegisterSegue, sender: self)
        }
    }
}
