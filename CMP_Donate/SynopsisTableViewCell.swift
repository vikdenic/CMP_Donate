//
//  SynopsisTableViewCell.swift
//  CMP_Donate
//
//  Created by Vik Denic on 2/7/15.
//  Copyright (c) 2015 mobilemakers. All rights reserved.
//

import UIKit

class SynopsisTableViewCell: UITableViewCell {

    @IBOutlet var synopsisTextView: UITextView!
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
        synopsisTextView.font = UIFont(name: "HelveticaNeue-Light", size: 17)
        synopsisTextView.frame = CGRectMake(8, 0, bounds.width - 7, bounds.height)
        synopsisTextView.setContentOffset(CGPointZero, animated: false)
    }
}
