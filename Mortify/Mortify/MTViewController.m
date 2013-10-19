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

    [self setupTableView];
    [self setupViews];
    
    self.activityLogMutableArray = [@[@"Smoking", @"Eating", @"Sleeping"] mutableCopy];
    
}

- (void)setupTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[MTActivityCell class] forCellReuseIdentifier:ACTIVITY_CELL];

}

- (void)setupViews {
    int numberOfPages = 4;
    self.timerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), 120)];
    self.timerScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.tableView.frame) * numberOfPages, 120);
    
    self.timerPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.timerScrollView.frame)/2) - 30, CGRectGetHeight(self.timerScrollView.frame) - 20, 30 * 2, 20)];
    self.timerPageControl.numberOfPages = numberOfPages;
    self.timerPageControl.currentPage = 1;
    self.timerPageControl.backgroundColor = [UIColor redColor];

    
    self.countdownTimer = [[UILabel alloc] initWithFrame:CGRectMake(30, 30, CGRectGetWidth(self.timerScrollView.frame) - 30 - 30, 60)];
    self.countdownTimer.font = [UIFont systemFontOfSize:26.0f];
    self.countdownTimer.textAlignment = NSTextAlignmentCenter;
    self.countdownTimer.text = @"13:35:23";
    
    [self.timerScrollView addSubview:self.countdownTimer];
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        UIView *view = [[UIView alloc] initWithFrame:self.timerScrollView.frame];
        [view addSubview:self.timerScrollView];
        [view addSubview:self.timerPageControl];
        
        return view;
        
        
    }
    
    // Is not suppose to return
    UIView *view;
    return view;
}

@end
