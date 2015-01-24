//
//  Event.swift
//  CMP_Donations
//
//  Created by Vik Denic on 1/24/15.
//  Copyright (c) 2015 Chicago Media Project. All rights reserved.
//

import Foundation

class Event: PFObject, PFSubclassing
{
    override class func load()
    {
        self.registerSubclass()
    }

    class func parseClassName() -> String!
    {
        return "Event"
    }

    @NSManaged var name : String!
    @NSManaged var city : String!
    @NSManaged var venue : String!
    @NSManaged var webAddress : String!
    @NSManaged var date : NSDate!
}