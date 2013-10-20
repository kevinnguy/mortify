//
//  MTActivity.m
//  Mortify
//
//  Created by America on 10/19/13.
//  Copyright (c) 2013 Kevin Nguy. All rights reserved.
//

#import "MTActivity.h"

@implementation MTActivity
- (id)initWithActivity:(NSString *)name score:(float)score {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.name = name;
    self.baseScore = score;
    self.score = score;
    
    return self;
}
@end
