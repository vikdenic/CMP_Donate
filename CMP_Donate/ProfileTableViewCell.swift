//
//  ProfileTableViewCell.swift
//  CMP_Donate
//
//  Created by Vik Denic on 1/25/15.
//  Copyright (c) 2015 mobilemakers. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet var profilePicImageView: PFImageView!
    @IBOutlet var coverPhotoImageView: PFImageView!
//    @IBOutlet var fundingLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        profilePicImageView.layer.cornerRadius = 50
        profilePicImageView.clipsToBounds = true

//        fundingLabel.layer.cornerRadius = 3
//        fundingLabel.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
