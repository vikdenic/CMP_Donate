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

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsetsMake(4, 5, 4, 5)
//        layout.minimumLineSpacing = 5
//        layout.itemSize = CGSizeMake(91, 91)
//        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
//        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
//        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionViewCellIdentifier)
//        collectionView.backgroundColor = UIColor.greenColor()
//        collectionView.showsHorizontalScrollIndicator = false
//        contentView.addSubview(self.collectionView)
//        layoutMargins = UIEdgeInsetsMake(10, 0, 10, 0)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let frame = self.contentView.bounds
        collectionView.frame = CGRectMake(0, 0.5, frame.size.width, frame.size.height - 1)
    }

    func setCollectionViewDataSourceDelegate(dataSourceDelegate delegate: protocol<UICollectionViewDelegate,UICollectionViewDataSource>, index: NSInteger) {
        collectionView.dataSource = delegate
        collectionView.delegate = delegate
        collectionView.tag = index
        collectionView.reloadData()
    }
}