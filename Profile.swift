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
}