//
//  PFFile+Custom.m
//  CMP_Donate
//
//  Created by Vik Denic on 3/3/15.
//  Copyright (c) 2015 mobilemakers. All rights reserved.
//

#import "PFFile+Custom.h"

@implementation PFFile (Custom)

+ (PFFile *) fileWithImage:(UIImage *)image
{
    return [[PFFile alloc]initWithImage:image];
}

- (instancetype)initWithImage:(UIImage *)image
{
    NSData *data = UIImagePNGRepresentation(image);

    self = [PFFile fileWithData:data];

    return self;
}

@end
