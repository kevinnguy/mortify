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

@interface MTViewController ()
@property (nonatomic, strong) NSMutableArray *activityLogMutableArray;

@property (nonatomic, strong) UIScrollView *timerScrollView;
@property (nonatomic, strong) UILabel *countdownTimer;
@property (nonatomic, strong) UIPageControl *timerPageControl;

@end

#define ACTIVITY_CELL @"ActivityCell"

@implementation MTViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavigationBar];
    [self setupTableView];
    [self setupTimerView];
    
    self.activityLogMutableArray = [@[@"Add Activity", @"Smoking", @"Eating", @"Sleeping", @"Smoking", @"Eating", @"Sleeping", @"Smoking", @"Eating", @"Sleeping", @"Smoking", @"Eating", @"Sleeping"] mutableCopy];
    
}


- (void)setupNavigationBar {
    self.navigationItem.title = @"Home View";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Red Button" style:UIBarButtonItemStyleBordered target:self action:nil];
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
    self.countdownTimer.font = [UIFont systemFontOfSize:48.0f];
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
//    viewController.delegate = self;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)segueToActivityDetails:(MTActivityDetailsViewController *)destinationViewController {
    
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
        
        cell.activityLabel.text = self.activityLogMutableArray[indexPath.row];
        cell.microMortLabel.text = @"2";
        
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
            [self performSegueWithIdentifier:@"SegueToActivityDetails" sender:self];
        }
    }
}

@end
