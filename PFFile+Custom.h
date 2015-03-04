//
//  PFFile+Custom.h
//  CMP_Donate
//
//  Created by Vik Denic on 3/3/15.
//  Copyright (c) 2015 mobilemakers. All rights reserved.
//

#import <Parse/Parse.h>

@interface PFFile (Custom)

+ (PFFile *) fileWithImage:(UIImage *)image;

@end
