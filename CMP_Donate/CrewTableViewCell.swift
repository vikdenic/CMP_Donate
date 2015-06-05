//
//  CrewTableViewCell.swift
//  CMP_Donate
//
//  Created by Vik Denic on 2/6/15.
//  Copyright (c) 2015 mobilemakers. All rights reserved.
//

import UIKit
let collectionViewCellIdentifier: NSString = "CrewCVCell"

class CrewTableViewCell: UITableViewCell {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pageDots: UIPageControl!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.tag = kCrewScrollViewTag

        let frame = self.contentView.bounds
        collectionView.frame = CGRectMake(0, 0.5, frame.size.width, frame.size.height - 1)

        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 0
        //Silences "item height must be less than CV height minus insets" warning
        layout.itemSize.height = collectionView.frame.size.height
    }

    func setCollectionViewDataSourceDelegate(dataSourceDelegate delegate: protocol<UICollectionViewDelegate,UICollectionViewDataSource>, index: NSInteger) {
        collectionView.dataSource = delegate
        collectionView.delegate = delegate
        collectionView.tag = index
        collectionView.reloadData()
    }
}