//
//  Transaction.swift
//  CMP_Donate
//
//  Created by Vik Denic on 3/4/15.
//  Copyright (c) 2015 Chicago Media Project. All rights reserved.
//

import Foundation

let kContributor = "contributor"
let kPinTransactions = "transactionsPin"
let kCreatedAt = "createdAt"

class Transaction: PFObject, PFSubclassing
{
    override class func load()
    {
        self.registerSubclass()
    }

    class func parseClassName() -> String!
    {
        return "Transaction"
    }

    @NSManaged var contributor : Profile!
    @NSManaged var film : Film!
    @NSManaged var amount : NSNumber!

    convenience init(contributor theContributor : Profile, film theFilm : Film, amount theAmount : NSNumber)
    {
        self.init()
        contributor = theContributor
        film = theFilm
        amount = theAmount
    }

    class func queryTransactions(profile : Profile, completed:(transactions:[Transaction], error:NSError!)->Void)
    {
        var ldsQuery = Transaction.query()
        ldsQuery.fromPinWithName(kPinTransactions)
        ldsQuery.orderByDescending(kCreatedAt)

        ldsQuery.findObjectsInBackgroundWithBlock({ (transactions, error) -> Void in
            completed(transactions: transactions as [Transaction], error: nil)
        })

        var query = Transaction.query()
        query.whereKey(kContributor, equalTo: profile)
        query.orderByDescending(kCreatedAt)

        query.findObjectsInBackgroundWithBlock({ (transactions, error) -> Void in
            PFObject.pinAllInBackground(transactions as [Transaction], withName: kPinTransactions, block: nil)
            completed(transactions: transactions as [Transaction], error: nil)
        })
    }
}