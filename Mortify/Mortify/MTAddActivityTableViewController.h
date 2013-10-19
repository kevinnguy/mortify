//
//  MTAddActivityTableViewController.h
//  Mortify
//
//  Created by America on 10/19/13.
//  Copyright (c) 2013 Kevin Nguy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MTActivity.h"


@protocol MTAddActivityDelegate <NSObject>

- (void)didAddActivity:(MTActivity *)activity;

@end

@interface MTAddActivityTableViewController : UITableViewController 
@property (nonatomic, assign) id<MTAddActivityDelegate> delegate;
@end
