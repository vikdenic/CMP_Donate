//
//  LoginViewController.swift
//  CMP_Donate
//
//  Created by Vik Denic on 1/24/15.
//  Copyright (c) 2015 Chicago Media Project. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    @IBAction func onLoginButtonTapped(sender: UIButton)
    {
        User.logInWithUsernameInBackground(emailTextField.text, password: passwordTextField.text) { (user, error) -> Void in
            
            if error == nil
            {
                self.dismissViewControllerAnimated(true, completion: { () -> Void in
                    Profile.queryForCurrentUserProfile({ (profile, error) -> Void in
                        UniversalProfile.sharedInstance.profile = profile
                    })
                })
            }
            else
            {

            }
        }
    }
}
