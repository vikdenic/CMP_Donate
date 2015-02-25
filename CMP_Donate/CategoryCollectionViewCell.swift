//
//  CategoryCollectionViewCell.swift
//  CMP_Donate
//
//  Created by Vik Denic on 2/24/15.
//  Copyright (c) 2015 mobilemakers. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet var categoryImageView: PFImageView!
    @IBOutlet var categoryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = frame.size.height / 24
        clipsToBounds = true
    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        layer.cornerRadius = frame.size.height / 32
//        clipsToBounds = true
//        categoryLabel.sizeToFit()
//    }
//
//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
}
