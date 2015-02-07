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

    @NSManaged var title : String!
    @NSManaged var synopsis : String!
    @NSManaged var imageFile : PFFile!
    @NSManaged var videoFile : PFFile!
    @NSManaged var productionTeam : [CrewMember]!
    @NSManaged var productionStatus : String!
    @NSManaged var event : Event!

    @NSManaged var suggestedAmountOne : NSNumber!
    @NSManaged var suggestedAmountTwo : NSNumber!
    @NSManaged var suggestedAmountThree : NSNumber!

    class func queryAllFilms(completed:(films:[Film], error:NSError!)->Void)
    {
        var query = Film.query()
        query.includeKey("event")
        query.includeKey("productionTeam")

        query.findObjectsInBackgroundWithBlock({ (films, error) -> Void in
            completed(films: films as [Film], error: nil)
        })
    }
}