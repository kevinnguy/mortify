//
//  MTActivityDetailsViewController.m
//  Mortify
//
//  Created by America on 10/19/13.
//  Copyright (c) 2013 Kevin Nguy. All rights reserved.
//

#import "MTActivityDetailsViewController.h"

@interface MTActivityDetailsViewController ()
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UILabel *activityNameLabel;
@end

@implementation MTActivityDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTableView];
}

- (void)setupTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark - UITableView delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    int height = 0;
    
    if (tableView == self.tableView) {
        
    }
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
//        MTActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:ACTIVITY_CELL];
//        
//        if (cell == nil) {
//            cell = [[MTActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ACTIVITY_CELL];
//        }
//        
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        MTActivity *activity = self.activityLogMutableArray[indexPath.row];
//        cell.activityLabel.text = activity.name;
//        
//        if (indexPath.row == 0) {
//            cell.microMortLabel.text = @"";
//            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"plus-icon.png"]];
//            [cell.microMortLabel addSubview:imageView];
//        } else {
//            if (activity.score > 0) {
//                cell.microMortLabel.text = [NSString stringWithFormat:@"%0.1f", activity.score];
//                cell.microMortLabel.backgroundColor = [UIColor greenMortifyColor];
//                cell.microMortLabel.layer.borderColor = [UIColor greenMortifyColor].CGColor;
//            } else {
//                cell.microMortLabel.text = [NSString stringWithFormat:@"%0.1f", activity.score * -1];
//                cell.microMortLabel.backgroundColor = [UIColor orangeMortifyColor];
//                cell.microMortLabel.layer.borderColor = [UIColor orangeMortifyColor].CGColor;
//            }
//            
//            cell.microMortLabel.textColor = [UIColor blackBackgroundColor];
//        }
//        
//        
//        return cell;
    }
    
    // Is not suppose to return
    UITableViewCell *cell;
    return cell;
}


@end
