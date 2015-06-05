//
//  CMPExtensions.swift
//  CMP_Donate
//
//  Created by Vik Denic on 1/25/15.
//  Copyright (c) 2015 Chicago Media Project. All rights reserved.
//

import Foundation

extension UIColor
{
    /// :returns: CMP's custom red color
    class func customRedColor() -> UIColor
    {
        return UIColor(red: 234/255.0, green: 34/255.0, blue: 45/255.0, alpha: 100)
    }
    /// :returns: a custom light gray color
    class func customLightGreyColor() -> UIColor
    {
        return UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 100)
    }
    /// :returns: a custom green color
    class func customGreenColor() -> UIColor
    {
        return UIColor(red: 0/255.0, green: 123/255.0, blue: 35/255.0, alpha: 100)
    }
}

extension String
{
    func removeDollarPrefix() -> String
    {
        if self.hasPrefix("$")
        {
            let convertedString = self as NSString
            let range = NSMakeRange(1, convertedString.length - 1)
            let newString = convertedString.substringWithRange(range)
            return newString
        }
        else
        {
            return self
        }
    }

    func isValidEmail() -> Bool
    {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluateWithObject(self)
    }
}

extension UIButton {
    func toCircular(borderThickness : CGFloat, borderColor : UIColor)
    {
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true

        layer.borderWidth = borderThickness
        layer.borderColor = borderColor.CGColor
    }
}

extension UINavigationController
{
    func setNavBarToClear()
    {
        self.navigationBarHidden = false
        self.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.translucent = true
        self.view.backgroundColor = UIColor.clearColor()
    }

    func resetNavBar()
    {
        self.navigationBarHidden = false
        self.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default)
        self.navigationBar.shadowImage = nil
        self.navigationBar.translucent = true
        self.view.backgroundColor = nil
    }
}

extension UITextField {

    func addBottomBorder()
    {
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRectMake(0.0, frame.size.height - 1, frame.size.width, 1.0)
        bottomBorder.backgroundColor = UIColor.groupTableViewBackgroundColor().CGColor
        layer.addSublayer(bottomBorder)
    }
}

extension PFFile {

    class func file(image : UIImage!) -> PFFile
    {
        let imageData = UIImagePNGRepresentation(image) as NSData!
        return PFFile(data: imageData)
    }
}



///Presents an alert displaying the passed-in title and message, all within the specified viewController.
///
///If device running iOS8 or higher, present UIAlertController. Else, shows a UIAlert.
func showAlert(title : String!, message : String!, viewController : UIViewController)
{
    var alert : UIAlertController = UIAlertController(title: title,
        message: message, preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "OK", style:.Default, handler: nil))
    viewController.presentViewController(alert, animated: true, completion: nil)
}

func showAlertWithError(error : NSError!, forVC : UIViewController)
{
    let alert = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .Alert)
    let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
    alert.addAction(okAction)
    forVC.presentViewController(alert, animated: true, completion: nil)
}