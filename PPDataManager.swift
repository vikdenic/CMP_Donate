//
//  PPDataManager.swift
//  HealthBuddy
//
//  Created by Vik Denic on 2/15/15.
//  Copyright (c) 2015 Nektar Labs. All rights reserved.
//

import Foundation

class PPDataManager {

    class func httpRequestAccessToken(clientId : String!, secretId : String!, completion : (data : AnyObject!, error : NSError!) -> Void)
    {
        //Concatenate a String composed of the client and secret id's
        //Remeber to unwrap these, or the will be Optional'd() and call won't work
        let authString = "\(clientId!):\(secretId!)"
        let authData = authString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        let credentials = "Basic \(authData!.base64EncodedStringWithOptions(nil))"

        //Create and set configuration object with necessary Headers and values
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = ["Accept": "application/json", "Accept-Language": "en_US", "Content-Type": "application/x-www-form-urlencoded", "Authorization": credentials]

        //Create session
        let session = NSURLSession(configuration: configuration)

        //Create request
        let request = NSMutableURLRequest(URL: NSURL(string: "https://api.sandbox.paypal.com/v1/oauth2/token")!)
        request.HTTPMethod = "POST"

        //Create data for request
        let dataString = "grant_type=client_credentials"
        let theData = dataString.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)

        //Creates an HTTP request for the specified URL request object, uploads the provided data object, and calls a handler upon completion.
        let task = session.uploadTaskWithRequest(request, fromData: theData) { (data, response, error) -> Void in
            if error != nil
            {
                println(error.localizedDescription)
                completion(data: nil, error: error)
            }
            else
            {
                let theData: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil)!
                completion(data: theData, error: nil)
            }
        }
        task.resume()
    }

    class func httpVerifyPayment(token : String!, paymentId : String!, viewController : UIViewController, completion : (data : AnyObject!, error : NSError!) -> Void)
    {
        //Concatenate a String composed of the client and secret id's
        //Remeber to unwrap these, or the will be Optional'd() and call won't work
        //        let authData = token!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        //        let credentials = "Bearer \(authData!.base64EncodedStringWithOptions(nil))"
        let credentials = "Bearer \(token)"

        //Create and set configuration object with necessary Headers and values
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = ["Content-Type": "application/json", "Authorization": credentials]

        //Create session
        let session = NSURLSession(configuration: configuration)

        //Create request
        let request = NSMutableURLRequest(URL: NSURL(string: "https://api.paypal.com/v1/payments/payment/\(paymentId!)")!)
        request.HTTPMethod = "GET"

        let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, serverError) -> Void in

            if serverError != nil
            {
                completion(data: nil, error: serverError)
            }
            else
            {
                let retrievedData: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil)!
                let dataDict = retrievedData as! NSDictionary
                completion(data: dataDict, error: nil)
            }
        })
        
        dataTask.resume()
    }
}