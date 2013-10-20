//
//  MTActivityDetailsViewController.h
//  Mortify
//
//  Created by America on 10/19/13.
//  Copyright (c) 2013 Kevin Nguy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MTActivity.h"

@protocol MTActivityDetailsDelegate <NSObject>

- (void)didChangeScore:(float)score atRowIndex:(int)index;

@end

@interface MTActivityDetailsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) MTActivity *activity;
@property (nonatomic) int activityLogArrayIndex;

@property (nonatomic, assign) id<MTActivityDetailsDelegate> delegate;
@end
