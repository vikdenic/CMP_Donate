//
//  VZCurrency.swift
//  CMP_Donate
//
//  Created by Vik Denic on 3/19/15.
//  Copyright (c) 2015 mobilemakers. All rights reserved.
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

        //https://gist.github.com/jacobbubu/1836273
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
    func formatCurrencyForCurrentLocale() -> String!
    {
        var currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        currencyFormatter.locale = NSLocale.currentLocale()
        var currencyString = currencyFormatter.internationalCurrencySymbol as String!
        var format = currencyFormatter.positiveFormat
        format = format.stringByReplacingOccurrencesOfString("¤", withString: currencyString)
        currencyFormatter.positiveFormat = format

        var formattedCurrency = currencyFormatter.stringFromNumber(self) //SKProduct->price
        return formattedCurrency
    }
}

/**
Retrieves and calculates currency conversion rate information from the JSONRates API

:param: abbrev     The abbreviation for the country you'd like to calculate the conversion rate (From USD) for
:param: completion Currency conversion rate provided within the closure
*/
func convertCurrency(abbrev : String, completion : (rate : Float) -> Void)
{
    Alamofire.request(.GET, "http://jsonrates.com/get/?from=" + abbrev + "&to=USD&apiKey=\(rateKey)").responseJSON() {
        (_, _, data, _) in

        let dict = data! as NSDictionary
        let rate = 1 / (dict.valueForKey("rate") as NSString).floatValue
        completion(rate: rate)
    }
}