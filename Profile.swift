//
//  Profile.swift
//  CMP_Donations
//
//  Created by Vik Denic on 1/24/15.
//  Copyright (c) 2015 Chicago Media Project. All rights reserved.
//

import Foundation

class Profile: PFObject, PFSubclassing
{
    override class func load()
    {
        self.registerSubclass()
    }

    class func parseClassName() -> String!
    {
        return "Profile"
    }

    @NSManaged var user : PFUser!
    @NSManaged var name : String!
    @NSManaged var fundedFilms : [Film]!
    @NSManaged var starredFilms : [Film]!
    @NSManaged var imageFile : PFFile!

    class func queryForCurrentUserProfile(completed: (profile: Profile!, error: NSError!)-> Void)
    {
        var ldsQuery = Profile.query()
        ldsQuery.fromPinWithName("profile")
        ldsQuery.whereKey("user", equalTo: PFUser.currentUser())
        ldsQuery.includeKey("fundedFilms")
        ldsQuery.includeKey("starredFilms")
        ldsQuery.includeKey("user")

        ldsQuery.getFirstObjectInBackgroundWithBlock { (theProfile, profileError) -> Void in
            if profileError != nil
            {
                completed(profile: nil, error: profileError)
            }
            else
            {
                completed(profile: theProfile as Profile!, error: nil)
            }
        }
        
        let query = Profile.query()
        query.whereKey("user", equalTo: PFUser.currentUser())
        query.includeKey("fundedFilms")
        query.includeKey("starredFilms")
        query.includeKey("user")

        query.getFirstObjectInBackgroundWithBlock({ (theProfile, profileError) -> Void in
            if profileError != nil
            {
                completed(profile: nil, error: profileError)
            }
            else
            {
                (theProfile as Profile).pinInBackgroundWithName("profile", nil)
                completed(profile: theProfile as Profile!, error: nil)
            }
        })
    }
}