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
    optional func didTapBubbleOne()
    optional func didTapBubbleTwo()
    optional func didTapBubbleThree()
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
    }

    @IBAction func onBubbleOneTapped(sender: UIButton)
    {
        delegate?.didTapBubbleOne!()
    }

    @IBAction func onBubbleTwoTapped(sender: UIButton)
    {
        delegate?.didTapBubbleTwo!()
    }

    @IBAction func onBubbleThreeTapped(sender: UIButton)
    {
        delegate?.didTapBubbleThree!()
    }

    @IBAction func onOtherAmountTapped(sender: UIButton)
    {
        delegate?.didTapOtherAmount!()
    }
}
