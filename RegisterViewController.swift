//
//  RegisterViewController.swift
//  CMP_Donate
//
//  Created by Vik Denic on 1/24/15.
//  Copyright (c) 2015 mobilemakers. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    @IBAction func onRegisterButtonTapped(sender: UIButton)
    {
        User.registerNewUser(emailTextField.text, password: passwordTextField.text) { (result, error) -> Void in
            println("registered new user")
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                //code
            })
        }
    }
}
