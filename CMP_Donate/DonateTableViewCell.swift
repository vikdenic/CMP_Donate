//
//  DonateTableViewCell.swift
//  CMP_Donate
//
//  Created by Vik Denic on 2/7/15.
//  Copyright (c) 2015 mobilemakers. All rights reserved.
//

import UIKit

@objc protocol DonateTableViewCellDelegate
{
    optional func didTapBubbleOne(amount : NSNumber)
    optional func didTapBubbleTwo(amount : NSNumber)
    optional func didTapBubbleThree(amount : NSNumber)
    optional func didTapOtherAmount()
}

class DonateTableViewCell: UITableViewCell {

    var delegate = DonateTableViewCellDelegate?()

    @IBOutlet var bubbleButtonOne: UIButton!
    @IBOutlet var bubbleButtonTwo: UIButton!
    @IBOutlet var bubbleButtonThree: UIButton!
    @IBOutlet var otherAmountButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        otherAmountButton.layer.borderWidth = 1.0
        otherAmountButton.layer.cornerRadius = 5
        otherAmountButton.layer.borderColor = UIColor.customRedColor().CGColor

        bubbleButtonOne.toCircular(1.0, borderColor: UIColor.customRedColor())
        bubbleButtonTwo.toCircular(1.0, borderColor: UIColor.customRedColor())
        bubbleButtonThree.toCircular(1.0, borderColor: UIColor.customRedColor())
    }

    @IBAction func onBubbleOneTapped(sender: UIButton)
    {
        delegate?.didTapBubbleOne!(bubbleButtonOne.titleLabel!.text!.removeDollarPrefix().toInt()!)
    }

    @IBAction func onBubbleTwoTapped(sender: UIButton)
    {
        delegate?.didTapBubbleTwo!(bubbleButtonTwo.titleLabel!.text!.removeDollarPrefix().toInt()!)
    }

    @IBAction func onBubbleThreeTapped(sender: UIButton)
    {
        delegate?.didTapBubbleThree!(bubbleButtonThree.titleLabel!.text!.removeDollarPrefix().toInt()!)
    }

    @IBAction func onOtherAmountTapped(sender: UIButton)
    {
        delegate?.didTapOtherAmount!()
    }
}
