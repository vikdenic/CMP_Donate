//
//  CrewMember.swift
//  CMP_Donations
//
//  Created by Vik Denic on 1/24/15.
//  Copyright (c) 2015 Chicago Media Project. All rights reserved.
//

import Foundation

class CrewMember: PFObject, PFSubclassing
{
    override class func load()
    {
        self.registerSubclass()
    }

    class func parseClassName() -> String!
    {
        return "CrewMember"
    }

    @NSManaged var name : String!
    @NSManaged var role : String!
    @NSManaged var imageFile : PFFile!
}