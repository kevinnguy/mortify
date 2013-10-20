//
//  UIColor+Mortify.m
//  Mortify
//
//  Created by America on 10/19/13.
//  Copyright (c) 2013 Kevin Nguy. All rights reserved.
//

#import "UIColor+Mortify.h"

@implementation UIColor (Mortify)
+ (UIColor *)blackBackgroundColor {
    float black = 60.0f;
    return [UIColor colorWithRed:black/255.0f green:black/255.0f blue:black/255.0f alpha:1.0f];
}

+ (UIColor *)whiteTableViewSeparatorColor {
    return [UIColor colorWithRed:100.f/255.0f green:100.f/255.0f blue:100.f/255.0f alpha:1.0f];
}

+ (UIColor *)blackNavigationBarColor {
    return [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
}

+ (UIColor *)redMortifyColor {
    return [UIColor colorWithRed:243.0f/255.0f green:93.0f/255.0f blue:93.0f/255.0f alpha:1.0f];
}

+ (UIColor *)greenMortifyColor {
    return [UIColor colorWithRed:126.0f/255.0f green:238.0f/255.0f blue:179.0f/255.0f alpha:1.0f];
}

+ (UIColor *)orangeMortifyColor {
    return [UIColor colorWithRed:244.0f/255.0f green:160.0f/255.0f blue:146.0f/255.0f alpha:1.0f];
}

+ (UIColor *)blueMortifyColor {
    return [UIColor colorWithRed:124.0f/255.0f green:198.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
}

@end
