//
//  CMPConstants.swift
//  CMP_Donate
//
//  Created by Vik Denic on 1/24/15.
//  Copyright (c) 2015 Chicago Media Project. All rights reserved.
//

import Foundation

let kProfile = UniversalProfile.sharedInstance.profile

//Segues
let kFeedToRegisterSegue = "FeedToRegisterSegue"
let kFeedToIndividualFilmSegue = "FeedToIndividualFilmSegue"
let kButton1ToPaySegue = "Button1ToPaySegue"
let kButton2ToPaySegue = "Button2ToPaySegue"
let kButton3ToPaySegue = "Button3ToPaySegue"
let kFundToPaySegue = "FundToPaySegue"
let kEditProfileToUpdateCardSegue = "EditProfileToUpdateCardSegue"
let kUpdateProfileToPreferredPaymentTypeSegue = "EditProfileToPreferredPaymentTypeSegue"
let kIndividualFilmToSelectPreferenceSegue = "IndividualFilmToSelectPreferenceSegue"

//Cells
let kFilmCell = "FilmCell"
let kProfileCell = "ProfileCell"
let kFundedFilmCell = "FundedFilmCell"
let kCrewCVCell = "CrewCVCell"
let kCrewTVCell = "CrewTVCell"
let kSynopsisCell = "SynopsisCell"
let kDonateCell = "DonateCell"
let kEditProfileCell = "EditProfileCell"
let kPreferredPaymentCell = "PreferredPaymentCell"

let kCrewScrollViewTag = 99

//Stripe
let kStripePublishableKey = "pk_test_oyA5FAsuqYVvFqEOUOSUg2hF"
let kDefaultsStripeCardLast4 = "card.last4"
let kDefaultsStripeCustomerID = "customerId"

let kDefaultsCreditCard = "CreditCard"
let kDefaultsPayPal = "PayPal"

let kDefaultsPreferredPaymentType = "preferredPaymentType"


//PayPal
let kPayPalClientIdSandbox = "AXwxFSPni98ZG2aXJ3PZYPKBAgH_gOpqMNufOqtL8Me_uvZaxtU2vJ6DYK-XLxHzCYxdftbcAW7WN72H"
let kPayPalClientIdProduction = "AeZRMN460sD44G7JnU5isWLY3VSXDp9sPQVQ7b3EXH6OWPNnHwvQZIgKE5PBlLhhLpglXS9ia7QYLGHA"

let kPayPalSecretIdSandbox = "EA0ebKbeiF-jRmEoaxIFaJ0k1HAJt4eIEtjQ0ob1Ht7lqihj3lzCAOsjpv8B8ssS774ZSrde6BUjC4Fc"
let kPayPalSecretIdProduction = "EH5yosQg45yEdlSr7RYeLmXFUDQHeAgDrgAtriXbgmuYlVlHOf20F_5cmwbaCd8xPrLbFNxEdidkKKZi"

//Other
let kStandardDefaults = NSUserDefaults.standardUserDefaults()
let kCrewMemberImage = "crewMemberImage"