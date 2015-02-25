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
    /// :returns: the custom pink color from the PiggyBack design team
    class func customRedColor() -> UIColor
    {
        return UIColor(red: 234/255.0, green: 34/255.0, blue: 45/255.0, alpha: 100)
    }

    class func customLightGreyColor() -> UIColor
    {
        return UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 100)
    }
    class func customGreenColor() -> UIColor
    {
//        return UIColor(red: 40/255.0, green: 200/255.0, blue: 85/255.0, alpha: 100)
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
    //MARK: Helpers
    func setNavBarToClear()
    {
        self.navigationBarHidden = false
        self.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.translucent = true
        self.view.backgroundColor = UIColor.clearColor()
    }
}