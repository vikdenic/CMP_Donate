//
//  RegisterViewController.swift
//  CMP_Donate
//
//  Created by Vik Denic on 1/24/15.
//  Copyright (c) 2015 Chicago Media Project. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var backgroundImageView: UIImageView!

    @IBOutlet var registerButton: UIButton!
    @IBOutlet var loginButton: UIButton!

    @IBOutlet var spinner: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController!.setNavBarToClear()
        view.backgroundColor = UIColor.clearColor()

        let url : NSURL = NSBundle.mainBundle().URLForResource("overheadGif", withExtension: "gif")!
//        self.backgroundImageView.image = UIImage.animatedImageWithAnimatedGIFURL(url)

        let anImageView = UIImageView(frame: view.frame)
        anImageView.image = UIImage.animatedImageWithAnimatedGIFURL(url)

        navigationController!.view.insertSubview(anImageView, atIndex: 0)

        passwordTextField.addBottomBorder()
        emailTextField.addBottomBorder()

        registerButton.layer.cornerRadius = 5
        registerButton.clipsToBounds = true

        loginButton.layer.cornerRadius = 5
        loginButton.clipsToBounds = true

        raiseViewsFor4S()
    }

    override func viewWillAppear(animated: Bool) {
        view.alpha = 1
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    func raiseViewsFor4S()
    {
        for aView in self.view.subviews as [UIView]
        {
            aView.center.y -= 65
        }
    }

    @IBAction func onRegisterButtonTapped(sender: UIButton)
    {
        spinner.startAnimating()

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
                    self.spinner.stopAnimating()
                }
                else
                {
                    let newProfile = Profile()
                    newProfile.user = PFUser.currentUser()
                    newProfile.user.username = self.emailTextField.text
                    newProfile.imageFile = PFFile.file(UIImage(named: kCrewMemberImage))

                    UniversalProfile.sharedInstance.profile = newProfile
                    kStandardDefaults.setValue(self.passwordTextField.text, forKey: kDefaultsPword)

                    newProfile.saveInBackgroundWithBlock({ (succeeded, error) -> Void in
                        let editVC = self.storyboard?.instantiateViewControllerWithIdentifier(kStoryboardIdEditGeneralInfo) as EditGeneralInfoViewController
                        editVC.fromRegister = true
                        self.navigationController?.pushViewController(editVC, animated: true)
                        self.spinner.stopAnimating()
                    })
                }
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

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        view.endEditing(true)

        if editing == true
        {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.view.center.y += 40
            })
        }
        editing = false
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        view.alpha = 0
    }
}
