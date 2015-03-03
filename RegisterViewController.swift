//
//  RegisterViewController.swift
//  CMP_Donate
//
//  Created by Vik Denic on 1/24/15.
//  Copyright (c) 2015 Chicago Media Project. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    @IBAction func onRegisterButtonTapped(sender: UIButton)
    {
        if emailTextField.text.isValidEmail() != true
        {
            showAlert("Please enter a valid email address", nil, self)
        }
        else if (passwordTextField.text as NSString).length < 6
        {
            showAlert("Password must be at least 6 characters", nil, self)
        }
        else
        {
            User.registerNewUser(emailTextField.text, password: passwordTextField.text) { (result, error) -> Void in
                if error != nil
                {
                    showAlertWithError(error, self)
                }
                else
                {
                    self.dismissViewControllerAnimated(true, completion: { () -> Void in
                        UniversalProfile.sharedInstance.profile = Profile()
                        kStandardDefaults.setValue(self.passwordTextField.text, forKey: kDefaultsPword)
                    })
                }
            }
        }
    }
}
