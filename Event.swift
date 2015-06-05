
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
    override class func initialize()
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
    @NSManaged var imageFile : PFFile!

    class func queryAllEvents(completed:(events:[Event]?, error:NSError!)->Void)
    {
        var ldsQuery = Event.query()
        ldsQuery.fromPinWithName("categoriesPin")
        ldsQuery.orderByDescending("createdAt")

        ldsQuery.findObjectsInBackgroundWithBlock({ (events, error) -> Void in
            completed(events: events as? [Event], error: error)
        })

        var query = Event.query()
        query.orderByDescending("createdAt")

        query.findObjectsInBackgroundWithBlock({ (events, error) -> Void in
            completed(events: events as? [Event], error: error)

            if let someEvents = events as! [Event]!
            {
                PFObject.pinAllInBackground(someEvents, withName: "categoriesPin", block: nil)
            }
        })
    }
}