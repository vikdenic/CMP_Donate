//
//  UniversalProfile.swift
//  CMP_Donate
//
//  Created by Vik Denic on 1/24/15.
//  Copyright (c) 2015 Chicago Media Project. All rights reserved.
//

import Foundation

private let SharedProfile = UniversalProfile()

@objc class UniversalProfile {

    class var sharedInstance : UniversalProfile
    {
        return SharedProfile
    }

    var profile = Profile?()

    class func clearUserDefaults()
    {
        kStandardDefaults.setObject(nil, forKey: kDefaultsStripeCardLast4)
        kStandardDefaults.setObject(nil, forKey: kDefaultsStripeCustomerID)
        kStandardDefaults.setObject(nil, forKey: kDefaultsCreditCard)
        kStandardDefaults.setObject(nil, forKey: kDefaultsPayPal)
        kStandardDefaults.setObject(nil, forKey: kDefaultsPreferredPaymentType)
        kStandardDefaults.setObject(nil, forKey: kDefaultsPword)
    }
}