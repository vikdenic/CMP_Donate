//
//  CrewCollectionViewCell.swift
//  CMP_Donate
//
//  Created by Vik Denic on 2/6/15.
//  Copyright (c) 2015 mobilemakers. All rights reserved.
//

import UIKit

class CrewCollectionViewCell: UICollectionViewCell {

    @IBOutlet var crewLabel: UILabel!
    @IBOutlet var crewImageView: PFImageView!

    override func layoutSubviews() {
        super.layoutSubviews()
        
        crewImageView.frame = CGRect(x: 0, y: 0, width: 75, height: 75)
        crewImageView.frame.origin = CGPointMake(crewImageView.superview!.center.x - (crewImageView.frame.size.width / 2), crewImageView.superview!.frame.size.height * 0.28)
        crewImageView.layer.cornerRadius = crewImageView.frame.size.height / 2
        crewImageView.clipsToBounds = true
    }
}
