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
                    let newProfile = Profile()
                    newProfile.user = PFUser.currentUser()
                    newProfile.user.username = self.emailTextField.text
                    newProfile.imageFile = PFFile.file(UIImage(named: kCrewMemberImage))
                    newProfile.fundedFilms = [Film]()
                    newProfile.starredFilms = [Film]()
                    UniversalProfile.sharedInstance.profile = newProfile
                    kStandardDefaults.setValue(self.passwordTextField.text, forKey: kDefaultsPword)

                    newProfile.saveInBackgroundWithBlock({ (succeeded, error) -> Void in

                        let editVC = self.storyboard?.instantiateViewControllerWithIdentifier(kStoryboardIdEditGeneralInfo) as EditGeneralInfoViewController
                        editVC.fromRegister = true
                        self.navigationController?.pushViewController(editVC, animated: true)
                    })
                }
            }
        }
    }
}
