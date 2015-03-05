//
//  ActivityItemProvider.swift
//  
//
//  Created by Vik Denic on 3/4/15.
//
//

import UIKit

class ActivityItemTextProvider: UIActivityItemProvider {

    override func activityViewController(activityViewController: UIActivityViewController, itemForActivityType activityType: String) -> AnyObject? {
        switch activityType
        {
        case UIActivityTypeMail:
            return "Mail" ;
        case UIActivityTypeMessage:
            return "Message";
        case UIActivityTypePostToFacebook:
            return "Facebook"
        case UIActivityTypePostToTwitter:
            return "Twitter";
        default:
            return "Other";
        }
    }

    func getSharingPostfix(activityType : String) -> String
    {
        switch activityType
        {
        case UIActivityTypePostToTwitter:
            return ", via @ChiMediaProject"
        case UIActivityTypePostToFacebook, UIActivityTypeMail, UIActivityTypeMessage:
            return "";
        default:
            return "";
        }
    }
   
}
