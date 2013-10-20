//
//  MTViewController.m
//  Mortify
//
//  Created by America on 10/19/13.
//  Copyright (c) 2013 Kevin Nguy. All rights reserved.
//

#import "MTViewController.h"

#import "MTAddActivityTableViewController.h"
#import "MTActivityDetailsViewController.h"
#import "MTActivityCell.h"
#import "MTActivity.h"

@interface MTViewController () <MTAddActivityDelegate, MTActivityDetailsDelegate>
@property (nonatomic, strong) NSMutableArray *activityLogMutableArray;

@property (nonatomic, strong) UIScrollView *timerScrollView;
@property (nonatomic, strong) UILabel *countdownTimer;
@property (nonatomic, strong) UIPageControl *timerPageControl;

@property (nonatomic, strong) MTActivity *selectedActivity;
@property (nonatomic) int selectedActivityLogArrayIndex;
@end


@implementation MTViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTabBar];
    [self setupNavigationBar];
    [self setupTableView];
    [self setupTimerView];
    
    MTActivity *addActivity = [[MTActivity alloc] initWithActivity:@"Add Activity" score:0];
    self.activityLogMutableArray = [@[addActivity] mutableCopy];
//    [self setNeedsStatusBarAppearanceUpdate];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)setupTabBar {
    [self.tabBarController.tabBar.items[0] setTitle:@"Home"];
    [self.tabBarController.tabBar.items[1] setTitle:@"Stats"];
    [self.tabBarController.tabBar.items[2] setTitle:@"Social"];
    
    [[self.tabBarController.tabBar.items objectAtIndex:0] setImage:[UIImage imageNamed:@"home-icon.png"]];
    [[self.tabBarController.tabBar.items objectAtIndex:1] setImage:[UIImage imageNamed:@"stats-icon.png"]];
    [[self.tabBarController.tabBar.items objectAtIndex:2] setImage:[UIImage imageNamed:@"social-icon.png"]];
}

- (void)setupNavigationBar {
    self.navigationItem.title = @"Home";
}

- (void)setupTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[MTActivityCell class] forCellReuseIdentifier:ACTIVITY_CELL];
}

- (void)setupTimerView {
    // Timer Scroll View
    int numberOfPages = 4;
    self.timerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), CGRectGetHeight(self.timerView.frame))];
    self.timerScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.tableView.frame) * numberOfPages, CGRectGetHeight(self.timerView.frame));
    
    self.timerPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.timerScrollView.frame)/2) - 30, CGRectGetHeight(self.timerScrollView.frame) - 30, 30 * 2, 30)];
    self.timerPageControl.numberOfPages = numberOfPages;
    self.timerPageControl.currentPage = 1;

    
    self.countdownTimer = [[UILabel alloc] initWithFrame:CGRectMake(30, 30, CGRectGetWidth(self.timerScrollView.frame) - 30 - 30, 80)];
    self.countdownTimer.font = [UIFont helveticaNeueThinWithSize:56.0f];
    self.countdownTimer.textAlignment = NSTextAlignmentCenter;
    self.countdownTimer.textColor = [UIColor whiteColor];
    self.countdownTimer.text = @"13:35:23";
    
    [self.timerScrollView addSubview:self.countdownTimer];
    
    self.timerView.backgroundColor = [UIColor blackBackgroundColor];
    [self.timerView addSubview:self.timerScrollView];
    [self.timerView addSubview:self.timerPageControl];
}

#pragma mark - Prepare segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SegueToActivityDetails"]) {
        [self segueToActivityDetails:segue.destinationViewController];
    }
}

- (void)segueToAddActivityProgrammatically {
    MTAddActivityTableViewController *viewController = [[MTAddActivityTableViewController alloc] init];
    viewController.delegate = self;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)segueToActivityDetails:(MTActivityDetailsViewController *)destinationViewController {
    destinationViewController.delegate = self;
    destinationViewController.activity = self.selectedActivity;
    destinationViewController.activityLogArrayIndex = self.selectedActivityLogArrayIndex;
}

#pragma mark - UITableView delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.activityLogMutableArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        MTActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:ACTIVITY_CELL];
        
        if (cell == nil) {
            cell = [[MTActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ACTIVITY_CELL];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        MTActivity *activity = self.activityLogMutableArray[indexPath.row];
        cell.activityLabel.text = activity.name;
        
        if (indexPath.row == 0) {
            cell.microMortLabel.text = @"";
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"plus-icon.png"]];
            [cell.microMortLabel addSubview:imageView];
        } else {
            if (activity.score > 0) {
                cell.microMortLabel.text = [NSString stringWithFormat:@"%0.1f", activity.score];
//                cell.microMortLabel.backgroundColor = [UIColor greenMortifyColor];
                cell.microMortLabel.layer.borderColor = [UIColor greenMortifyColor].CGColor;
                cell.microMortLabel.textColor = [UIColor greenMortifyColor];
            } else {
                cell.microMortLabel.text = [NSString stringWithFormat:@"%0.1f", activity.score * -1];
//                cell.microMortLabel.backgroundColor = [UIColor orangeMortifyColor];
                cell.microMortLabel.layer.borderColor = [UIColor orangeMortifyColor].CGColor;
                cell.microMortLabel.textColor = [UIColor orangeMortifyColor];
            }
            
            cell.microMortLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
        }
        
        
        return cell;
    }
    
    // Is not suppose to return
    UITableViewCell *cell;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        if (indexPath.row == 0) {
            [self segueToAddActivityProgrammatically];
        } else {
            self.selectedActivity = self.activityLogMutableArray[indexPath.row];
            self.selectedActivityLogArrayIndex = indexPath.row;
            [self performSegueWithIdentifier:@"SegueToActivityDetails" sender:self];
        }
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - MTAddActivityDelegate
- (void)didAddActivity:(MTActivity *)activity {
    [self.activityLogMutableArray addObject:activity];
    [self.tableView reloadData];
}

#pragma mark - MTActivityDetailsDelegate
- (void)didChangeScore:(float)score atRowIndex:(int)index {
    MTActivity *activity = self.activityLogMutableArray[index];
    activity.score = score;
    
    [self.activityLogMutableArray setObject:activity atIndexedSubscript:index];
}

@end
