//
//  MTActivity.h
//  Mortify
//
//  Created by America on 10/19/13.
//  Copyright (c) 2013 Kevin Nguy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTActivity : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic) float baseScore;
@property (nonatomic) float score;

- (id)initWithActivity:(NSString *)name score:(float)score;
@end
