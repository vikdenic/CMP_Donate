//
//  FundedFilmTableViewCell.swift
//  CMP_Donate
//
//  Created by Vik Denic on 1/26/15.
//  Copyright (c) 2015 mobilemakers. All rights reserved.
//

import UIKit

class FundedFilmTableViewCell: UITableViewCell {

    @IBOutlet var filmImageView: PFImageView!
    @IBOutlet var filmTitleLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        filmImageView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
