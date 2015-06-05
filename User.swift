//
//  User.swift
//  CMP_Donations
//
//  Created by Vik Denic on 1/24/15.
//  Copyright (c) 2015 Chicago Media Project. All rights reserved.
//

import Foundation

class User: PFUser, PFSubclassing
{
    override class func initialize()
    {
        self.registerSubclass()
    }

    ///Creates a new user
    class func registerNewUser(username : String!, password : String!, completed:(result : Bool!, error : NSError!) -> Void)
    {
        let newUser = User()
        newUser.username = username.lowercaseString
        newUser.password = password.lowercaseString

        newUser.signUpInBackgroundWithBlock { (succeeded, signUpError) -> Void in

            if signUpError == nil
            {
                //Create new profile that points to this user
//                let newProfile = Profile()
//                newProfile.user = newUser
//                newProfile.saveInBackgroundWithBlock({ (profileCreationSucceeded, profileCreationError) -> Void in
                    completed(result: true, error: signUpError)
//                })
            }
            else
            {
                completed(result: false, error: signUpError)
            }
        }
    }

    ///Logs in a user
    class func loginUser(username : String!, password : String!, completed:(result : Bool!, error : NSError!) -> Void)
    {
        PFUser.logInWithUsernameInBackground(username, password: password) { (user, loginError) -> Void in

            if loginError != nil
            {
                completed(result: false, error: loginError)
            }
            else
            {
                completed(result: true, error: nil)
            }
        }
    }
}
