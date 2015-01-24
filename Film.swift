//
//  Film.swift
//  CMP_Donations
//
//  Created by Vik Denic on 1/24/15.
//  Copyright (c) 2015 Chicago Media Project. All rights reserved.
//

import Foundation

class Film: PFObject, PFSubclassing
{
    override class func load()
    {
        self.registerSubclass()
    }

    class func parseClassName() -> String!
    {
        return "Film"
    }

    @NSManaged var title : NSDate!
    @NSManaged var synopsis : NSDate!
    @NSManaged var imageFile : PFFile!
    @NSManaged var videoFile : PFFile!
    @NSManaged var productionTeam : [CrewMember]!
    @NSManaged var productionStatus : String!
    @NSManaged var event : Event!
}