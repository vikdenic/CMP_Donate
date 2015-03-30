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
    @IBOutlet var loginButton: UIButton!

    @IBOutlet var spinner: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        passwordTextField.addBottomBorder()
        emailTextField.addBottomBorder()

        loginButton.layer.cornerRadius = 5
        loginButton.clipsToBounds = true

        view.backgroundColor = UIColor.clearColor()
    }

    @IBAction func onLoginButtonTapped(sender: UIButton)
    {
        self.spinner.startAnimating()
        User.logInWithUsernameInBackground(emailTextField.text, password: passwordTextField.text) { (user, error) -> Void in
            
            if error == nil
            {
                Profile.queryForCurrentUserProfile({ (profile, error) -> Void in
                    UniversalProfile.sharedInstance.profile = profile
                    kStandardDefaults.setValue(self.passwordTextField.text, forKey: kDefaultsPword)
                    self.dismissViewControllerAnimated(true, completion: nil)
                    self.spinner.stopAnimating()
                })
            }
            else
            {
                showAlertWithError(error, self)
                self.spinner.stopAnimating()
            }
        }
    }
}
