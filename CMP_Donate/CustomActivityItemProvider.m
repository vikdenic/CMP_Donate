//
//  CustomActivityProvider.m
//  CMP_Donate
//
//  Created by Vik Denic on 3/4/15.
//  Copyright (c) 2015 mobilemakers. All rights reserved.
//

#import "CustomActivityItemProvider.h"

@interface CustomActivityItemProvider()

@property (nonatomic, strong) NSString *text;

@end

@implementation CustomActivityItemProvider

- (id)initWithText:(NSString *)text link:(NSString *)link{

    if ((self = [super initWithPlaceholderItem:text])) {
        self.text = text ?: @"";
        self.link = link ?: @"";
    }
    return self;
}

- (id)item
{
    //Generates and returns the actual data object
    return @"";
}
//
//// The following are two methods in the UIActivityItemSource Protocol
//// (UIActivityItemProvider conforms to this protocol) - both methods required
//
////- Returns the data object to be acted upon. (required)
- (id)activityViewController:(UIActivityViewController *)activityViewController itemForActivityType:(NSString *)activityType
{
    if ([activityType isEqualToString:UIActivityTypePostToTwitter]) {
        return [NSString stringWithFormat:@"Join me in supporting \"%@\", via @ChiMediaProject", self.text];
    }

    if ([activityType isEqualToString:UIActivityTypePostToFacebook] ||
        [activityType isEqualToString:UIActivityTypePostToWeibo] ||
        [activityType isEqualToString:UIActivityTypeMail]) {
        return [NSString stringWithFormat:@"Join me in supporting \"%@\", an independant film project. \r \r %@", self.text, self.link];
    }

    return [NSString stringWithFormat:@"Join me in supporting \"%@\", an independant film project. \r \r %@", self.text, self.link];;
}
@end