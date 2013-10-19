//
//  MTViewController.m
//  Mortify
//
//  Created by America on 10/19/13.
//  Copyright (c) 2013 Kevin Nguy. All rights reserved.
//

#import "MTViewController.h"

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

    [self setupTabbar];
    [self setupNavigationBar];
    [self setupTableView];
    [self setupViews];
    
    self.activityLogMutableArray = [@[@"Smoking", @"Eating", @"Sleeping", @"Smoking", @"Eating", @"Sleeping", @"Smoking", @"Eating", @"Sleeping", @"Smoking", @"Eating", @"Sleeping"] mutableCopy];
    
}

- (void)setupTabbar {
    self.tabBarController.tabBar.barTintColor = [UIColor blackNavigationBarColor];
    self.tabBarController.tabBar.tintColor = [UIColor redMortifyColor];
}

- (void)setupNavigationBar {
    self.navigationController.navigationBar.barTintColor = [UIColor blackNavigationBarColor];
    self.navigationController.navigationBar.tintColor = [UIColor redMortifyColor];
    
    self.navigationItem.title = @"Home View";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Red Button" style:UIBarButtonItemStyleBordered target:self action:nil];
}

- (void)setupTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.backgroundColor = [UIColor blackBackgroundColor];
    self.tableView.separatorColor = [UIColor whiteTableViewSeparatorColor];
    
    [self.tableView registerClass:[MTActivityCell class] forCellReuseIdentifier:ACTIVITY_CELL];

}

- (void)setupViews {
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
        [self segueToActivityDetails];
    }
}

- (void)segueToActivityDetails {
    
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


@end
