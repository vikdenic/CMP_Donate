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

        raiseViewsFor4S()
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }


    func raiseViewsFor4S()
    {
        for aView in self.view.subviews as! [UIView]
        {
            aView.center.y -= 65
        }
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

    func textFieldDidBeginEditing(textField: UITextField)
    {
        if editing == false
        {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.view.center.y -= 40
            })
        }
        editing = true
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        view.endEditing(true)

        if editing == true
        {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.view.center.y += 40
            })
        }
        editing = false
    }
}
