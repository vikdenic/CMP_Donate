//
//  CrewTableViewCell.h
//  CMP_Donate
//
//  Created by Vik Denic on 2/6/15.
//  Copyright (c) 2015 mobilemakers. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *CollectionViewCellIdentifier = @"CrewCVCell";

@interface CrewTableViewCell : UITableViewCell

@property (nonatomic, strong) UICollectionView *collectionView;

-(void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate index:(NSInteger)index;

@end
