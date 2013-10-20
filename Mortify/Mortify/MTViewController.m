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

@property (nonatomic, strong) UIImageView *imageView;
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

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)setupTabBar {
    [self.tabBarController.tabBar.items[0] setTitle:@"Home"];
    [self.tabBarController.tabBar.items[1] setTitle:@"Grim Reports"];
    [self.tabBarController.tabBar.items[2] setTitle:@"Social"];
    
    [[self.tabBarController.tabBar.items objectAtIndex:0] setImage:[UIImage imageNamed:@"home-icon.png"]];
    [[self.tabBarController.tabBar.items objectAtIndex:1] setImage:[UIImage imageNamed:@"stats-icon.png"]];
    [[self.tabBarController.tabBar.items objectAtIndex:2] setImage:[UIImage imageNamed:@"social-icon.png"]];
}

- (void)setupNavigationBar {
    self.navigationItem.title = @"Home";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Update" style:UIBarButtonItemStyleBordered target:self action:@selector(updateBarButtonPressed:)];
}

- (void)setupTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[MTActivityCell class] forCellReuseIdentifier:ACTIVITY_CELL];
}

- (void)setupTimerView {
    int padding = 12;
    self.countdownTimer = [[UILabel alloc] initWithFrame:CGRectMake(padding, padding, CGRectGetWidth(self.timerView.frame) - padding - padding, CGRectGetHeight(self.timerView.frame) - padding)];
//    self.countdownTimer.font = [UIFont helveticaNeueThinWithSize:62.0f];
    self.countdownTimer.font = [UIFont helveticaNeueThinWithSize:22.0f];
    self.countdownTimer.textAlignment = NSTextAlignmentCenter;
    self.countdownTimer.textColor = [UIColor whiteColor];
    
    NSDate *currentDate = [NSDate date];
//    NSDateComponents *currentDateComponents = [[NSCalendar currentCalendar] components:NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:currentDate];
//    NSDateComponents *currentDateToMidnight = [[NSDateComponents alloc] init];
//    [currentDateToMidnight setHour:-[currentDateComponents hour]];
//    [currentDateToMidnight setMinute:-[currentDateComponents minute]];
//    [currentDateToMidnight setSecond:-[currentDateComponents second]];
//    NSDate *midnight = [[NSCalendar currentCalendar] dateByAddingComponents:currentDateToMidnight toDate:currentDate options:0];
    NSTimeInterval todayTimeInterval = [currentDate timeIntervalSince1970];
    self.countdownTimer.text = [self stringFromTimeInterval:todayTimeInterval];
    
    self.timerView.backgroundColor = [UIColor blackBackgroundColor];
    [self.timerView addSubview:self.countdownTimer];
}

- (void)updateBarButtonPressed:(id)sender {
    
}

#pragma mark - Timer
- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
    NSInteger ti = (NSInteger)interval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    return [NSString stringWithFormat:@"%02i:%02i:%02i", hours, minutes, seconds];
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
            self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"plus-icon.png"]];
            [cell.microMortLabel addSubview:self.imageView];
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
            
//            cell.microMortLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
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
    self.activityLogMutableArray = [[[self.activityLogMutableArray reverseObjectEnumerator] allObjects] mutableCopy];
    [self.activityLogMutableArray removeLastObject];
    [self.activityLogMutableArray addObject:activity];
    
    MTActivity *addActivity = [[MTActivity alloc] initWithActivity:@"Add Activity" score:0];
    [self.activityLogMutableArray addObject:addActivity];
    self.activityLogMutableArray = [[[self.activityLogMutableArray reverseObjectEnumerator] allObjects] mutableCopy];
    
    [self.tableView reloadData];
}

#pragma mark - MTActivityDetailsDelegate
- (void)didChangeScore:(float)score atRowIndex:(int)index {
    MTActivity *activity = self.activityLogMutableArray[index];
    activity.score = score;
    
    [self.activityLogMutableArray setObject:activity atIndexedSubscript:index];
    [self.tableView reloadData];
}

@end
