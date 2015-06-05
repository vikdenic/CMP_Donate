//
//  VZCurrency.swift
//  CMP_Donate
//
//  Created by Vik Denic on 3/19/15.
//  Copyright (c) 2015 Nektar Labs. All rights reserved.
//

import Foundation
import Alamofire

/// Your API Key for jsonrates (http://jsonrates.com/signup/)
let rateKey = "jr-850d1e0bc3c23bed30132ee78f4e16c2" as String!

/**
A class for retrieving conversion rates from USD to the currency of the user's device's region.

References the localeIdentifier of the user's currentLocale for determining currency.

Relies on JSONRates.com for currency conversion dates
*/
class VZCurrency {
    /**
    Provides the currency conversion rate from USD to the currency of the region for the user's device

    :param: completion Currency conversion rate provided within the closure
    */
    class func obtainConversationRateForCurrentLocale(completion : (rate : Float) -> Void)
    {
        var originCode = "USD"

        let currentLocale = NSLocale.currentLocale()
        println(currentLocale.localeIdentifier)

        //List of localeIdentifiers: https://gist.github.com/jacobbubu/1836273
        //List of currencies for JSONRates API: http://jsonrates.com/docs/currencies/
        switch currentLocale.localeIdentifier {
        case "en_FR":
            originCode = "EUR"
        case "en_AR":
            originCode = "ARS"
        case "en_NO":
            originCode = "NOK"
        case "en_AU":
            originCode = "AUD"
        case "en_GB":
            originCode = "GBP"
        case "en_IN":
            originCode = "INR"
        default:
            break
        }

        convertCurrency(originCode, { (rate) -> Void in
            completion(rate: rate)
        })
    }
}

extension NSNumber {
    /**
    :returns: A String representation of the number, formatted for the currency of the user's current region
    */
    func formatCurrencyWithSymbol() -> String!
    {
        let theLocale = NSLocale.currentLocale()
        let currencySymbol = theLocale.objectForKey(NSLocaleCurrencySymbol) as! String!
        var currencyFormatter = NSNumberFormatter()
        currencyFormatter.roundingMode = NSNumberFormatterRoundingMode.RoundUp
        var formattedCurrency = currencyFormatter.stringFromNumber(self) as String!

        return currencySymbol + formattedCurrency
    }
}

/**
Retrieves and calculates currency conversion rate information from the JSONRates API

:param: abbrev     The abbreviation for the country you'd like to calculate the conversion rate (From USD) for
:param: completion Currency conversion rate provided within the closure
*/
func convertCurrency(abbrev : String, completion : (rate : Float) -> Void)
{
//    Alamofire.request(.GET, "http://jsonrates.com/get/?from=" + abbrev + "&to=USD&apiKey=\(rateKey)", parameters: [:], encoding: .URL).responseJSON() {
//        (_, _, data, _) in
//        //
//    }
//    Alamofire.request(.GET, "http://jsonrates.com/get/?from=" + abbrev + "&to=USD&apiKey=\(rateKey)").responseJSON() {
//        (_, _, data, _) in
//
//        if let someDict = data as NSDictionary!
//        {
//            let rate = 1 / (someDict.valueForKey("rate") as NSString).floatValue
//            completion(rate: rate)
//        }
//        else
//        {
//            completion(rate: 1.0)
//        }
//    }
}