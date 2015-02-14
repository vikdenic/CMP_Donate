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

extension UIImageView
{
    func addBlurEffect(style : UIBlurEffectStyle)
    {
        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: style)) as UIVisualEffectView

        visualEffectView.frame = bounds

        addSubview(visualEffectView)
    }
}