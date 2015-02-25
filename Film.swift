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
        var ldsQuery = Film.query()
        ldsQuery.fromPinWithName("feedFilms")
        ldsQuery.includeKey("event")
        ldsQuery.includeKey("productionTeam")
        ldsQuery.orderByDescending("createdAt")

        ldsQuery.findObjectsInBackgroundWithBlock({ (films, error) -> Void in
            completed(films: films as [Film], error: nil)
        })

        var query = Film.query()
        query.includeKey("event")
        query.includeKey("productionTeam")
        query.orderByDescending("createdAt")

        query.findObjectsInBackgroundWithBlock({ (films, error) -> Void in
            if error != nil
            {

            }
            else
            {
                PFObject.pinAllInBackground(films, withName: "feedFilms", block: nil)
                completed(films: films as [Film], error: nil)
            }
        })
    }

    class func queryAllFilms(event : Event, completed:(films:[Film], error:NSError!)->Void)
    {
        var ldsQuery = Film.query()
        ldsQuery.fromPinWithName("eventFilms")
        ldsQuery.includeKey("event")
        ldsQuery.includeKey("productionTeam")
        ldsQuery.orderByDescending("createdAt")

        ldsQuery.findObjectsInBackgroundWithBlock({ (films, error) -> Void in
            completed(films: films as [Film], error: nil)
        })


        var query = Film.query()
        query.includeKey("event")
        query.includeKey("productionTeam")
        query.whereKey("event", equalTo: event)

        query.findObjectsInBackgroundWithBlock({ (films, error) -> Void in
            PFObject.pinAllInBackground(films, withName: "eventFilms", block: nil)
            completed(films: films as [Film], error: nil)
        })
    }
}