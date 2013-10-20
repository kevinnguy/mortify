//
//  MTActivityDetailsViewController.m
//  Mortify
//
//  Created by America on 10/19/13.
//  Copyright (c) 2013 Kevin Nguy. All rights reserved.
//

#import "MTActivityDetailsViewController.h"

@interface MTActivityDetailsViewController () <UINavigationControllerDelegate>
@property (nonatomic) float selectedScore;
@property (nonatomic) MTActivity *selectedActivity;

// Details Row
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UILabel *activityNameLabel;
@property (nonatomic, strong) UIStepper *scoreStepper;
@property (nonatomic, strong) UILabel *scoreCountLabel;
// Risk Row


// Social Row

@end

#define CELL_IDENTIFIER @"Cell"

#define DETAILS_ROW 0
#define RISK_ROW 1
#define SOCIAL 2

@implementation MTActivityDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupViews];
    [self setupTableView];
    
    self.selectedScore = self.activity.score;
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.delegate didChangeScore:self.selectedScore atRowIndex:self.activityLogArrayIndex];
}

- (void)setupTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)setupViews {
    // Details Row
    self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 50, 50)];
    self.scoreLabel.font = [UIFont helveticaNeueThinWithSize:20.0f];
    self.scoreLabel.textAlignment = NSTextAlignmentCenter;
    self.scoreLabel.textColor = [UIColor blackBackgroundColor];
    self.scoreLabel.layer.borderWidth = 1.0f;
    self.scoreLabel.layer.cornerRadius = CGRectGetWidth(self.scoreLabel.frame) / 2;
    
    if (self.activity.score > 0) {
        self.scoreLabel.backgroundColor = [UIColor greenMortifyColor];
        self.scoreLabel.text = [NSString stringWithFormat:@"%0.1f", self.activity.score];
    } else {
        self.scoreLabel.backgroundColor = [UIColor orangeMortifyColor];
        self.scoreLabel.text = [NSString stringWithFormat:@"%0.1f", self.activity.score * -1];
    }
    self.scoreLabel.layer.borderColor = self.scoreLabel.backgroundColor.CGColor;
    
    self.activityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + CGRectGetWidth(self.scoreLabel.frame) + 10, 20, CGRectGetWidth(self.view.frame) - 20 - CGRectGetWidth(self.scoreLabel.frame) - 10, CGRectGetHeight(self.scoreLabel.frame))];
    self.activityNameLabel.font = [UIFont helveticaNeueThinWithSize:40.0f];
    self.activityNameLabel.textColor = [UIColor whiteColor];
    self.activityNameLabel.text = self.activity.name;
    
    self.scoreStepper = [[UIStepper alloc] initWithFrame:CGRectMake(20, CGRectGetHeight(self.scoreLabel.frame) + 45, 0, 0)];
    self.scoreStepper.minimumValue = 1;
    self.scoreStepper.maximumValue = INT16_MAX;
    [self.scoreStepper addTarget:self action:@selector(scoreStepperPressed:) forControlEvents:UIControlEventValueChanged];
    self.scoreStepper.tintColor = self.scoreLabel.backgroundColor;
    
    self.scoreCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + CGRectGetWidth(self.scoreStepper.frame) + 10, CGRectGetHeight(self.scoreLabel.frame) + 40, CGRectGetWidth(self.view.frame) - 20 - CGRectGetWidth(self.scoreStepper.frame), 40)];
    self.scoreCountLabel.font = [UIFont helveticaNeueThinWithSize:28.0f];
    self.scoreCountLabel.textColor = [UIColor whiteColor];
    self.scoreCountLabel.text = @"1 cigarette";
}

#pragma mark - Button Pressed
- (void)scoreStepperPressed:(UIStepper *)sender {
    self.selectedScore = self.activity.score * sender.value;
    
    if (self.activity.score > 0) {
        self.scoreLabel.text = [NSString stringWithFormat:@"%0.1f", self.selectedScore];
    } else {
        self.scoreLabel.text = [NSString stringWithFormat:@"%0.1f", self.selectedScore * -1];
    }
}

#pragma mark - UITableView delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    int height = 0;
    
    if (tableView == self.tableView) {
        switch (indexPath.row) {
            case 0:
                height = 150;
                break;
            
            case 1:
                height = 150;
                break;
                
            default:
                break;
        }
    }
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        
        switch (indexPath.row) {
            case 0:{
                [cell addSubview:self.scoreLabel];
                [cell addSubview:self.activityNameLabel];
                [cell addSubview:self.scoreStepper];
                [cell addSubview:self.scoreCountLabel];
                break;
            }
                
            case 1:{
                
                break;
            }
                
            default:
                break;
        }
        
        
        return cell;
        
        
        
    }
    
    // Is not suppose to return
    UITableViewCell *cell;
    return cell;
}


@end
