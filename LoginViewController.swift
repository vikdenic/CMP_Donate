//
//  LoginViewController.swift
//  CMP_Donate
//
//  Created by Vik Denic on 1/24/15.
//  Copyright (c) 2015 mobilemakers. All rights reserved.
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
                })
            }
            else
            {

            }
        }
    }
}
