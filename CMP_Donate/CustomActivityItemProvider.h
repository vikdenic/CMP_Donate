//
//  CustomActivityProvider.h
//  CMP_Donate
//
//  Created by Vik Denic on 3/4/15.
//  Copyright (c) 2015 Chicago Media Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomActivityItemProvider : UIActivityItemProvider

- (id)initWithText:(NSString *)text link:(NSString *)link;

@property NSString *link;

@end
