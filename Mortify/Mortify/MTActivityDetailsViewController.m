//
//  MTActivityDetailsViewController.m
//  Mortify
//
//  Created by America on 10/19/13.
//  Copyright (c) 2013 Kevin Nguy. All rights reserved.
//

#import "MTActivityDetailsViewController.h"

@interface MTActivityDetailsViewController () <UINavigationControllerDelegate>
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
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.delegate didChangeScore:self.activity.score atRowIndex:self.activityLogArrayIndex];
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

    // Match score count label with activity
    float value = self.activity.score / self.activity.baseScore;
    
    if ([self.activity.name isEqualToString:@"Smoking"]) {
        self.scoreCountLabel.text = @"1 cigarette";
        if (value > 1) {
            self.scoreCountLabel.text = [NSString stringWithFormat:@"%.0f cigarettes", value];
            self.scoreStepper.value = value;
        }
    } else if ([self.activity.name isEqualToString:@"Skydiving"] || [self.activity.name isEqualToString:@"Ecstasy"]) {
        self.scoreCountLabel.text = @"1 time";
        if (value > 1) {
            self.scoreCountLabel.text = [NSString stringWithFormat:@"%.0f times", value];
            self.scoreStepper.value = value;
        }
    } else if ([self.activity.name isEqualToString:@"Coffee"]) {
        self.scoreCountLabel.text = @"1 cup";
        if (value > 1) {
            self.scoreCountLabel.text = [NSString stringWithFormat:@"%.0f cups", value];
            self.scoreStepper.value = value;
        }
    } else if ([self.activity.name isEqualToString:@"Exercise"] || [self.activity.name isEqualToString:@"Biking"] || [self.activity.name isEqualToString:@"Driving"]) {
        self.scoreCountLabel.text = @"20 minutes";
        if (value > 1) {
            self.scoreCountLabel.text = [NSString stringWithFormat:@"%.0f minutes", value * 20];
            self.scoreStepper.value = value;
        }
    } else if ([self.activity.name isEqualToString:@"Sitting"]) {
        self.scoreCountLabel.text = @"1 hour";
        if (value > 1) {
            self.scoreCountLabel.text = [NSString stringWithFormat:@"%.0f hours", value];
            self.scoreStepper.value = value;
        }
    } else if ([self.activity.name isEqualToString:@"Eating fruits/vegetables"]) {
        self.scoreCountLabel.text = @"1 serving";
        if (value > 1) {
            self.scoreCountLabel.text = [NSString stringWithFormat:@"%.0f servings", value];
            self.scoreStepper.value = value;
        }
    }

}

#pragma mark - Button Pressed
- (void)scoreStepperPressed:(UIStepper *)sender {
    self.activity.score = self.activity.baseScore * sender.value;
    
    if (self.activity.score > 0) {
        self.scoreLabel.text = [NSString stringWithFormat:@"%0.1f", self.activity.score];
    } else {
        self.scoreLabel.text = [NSString stringWithFormat:@"%0.1f", self.activity.score * -1];
    }
    
    if ([self.activity.name isEqualToString:@"Smoking"]) {
        self.scoreCountLabel.text = @"1 cigarette";
        if (sender.value > 1) {
            self.scoreCountLabel.text = [NSString stringWithFormat:@"%.0f cigarettes", sender.value];
        }
    } else if ([self.activity.name isEqualToString:@"Skydiving"] || [self.activity.name isEqualToString:@"Ecstasy"]) {
        self.scoreCountLabel.text = @"1 time";
        if (sender.value > 1) {
            self.scoreCountLabel.text = [NSString stringWithFormat:@"%.0f times", sender.value];
        }
    } else if ([self.activity.name isEqualToString:@"Coffee"]) {
        self.scoreCountLabel.text = @"1 cup";
        if (sender.value > 1) {
            self.scoreCountLabel.text = [NSString stringWithFormat:@"%.0f cups", sender.value];
        }
    } else if ([self.activity.name isEqualToString:@"Exercise"] || [self.activity.name isEqualToString:@"Biking"] || [self.activity.name isEqualToString:@"Driving"]) {
        self.scoreCountLabel.text = @"20 minutes";
        if (sender.value > 1) {
            self.scoreCountLabel.text = [NSString stringWithFormat:@"%.0f minutes", sender.value * 20];
        }
    } else if ([self.activity.name isEqualToString:@"Sitting"]) {
        self.scoreCountLabel.text = @"1 hour";
        if (sender.value > 1) {
            self.scoreCountLabel.text = [NSString stringWithFormat:@"%.0f hours", sender.value];
        }
    } else if ([self.activity.name isEqualToString:@"Eating fruits/vegetables"]) {
        self.scoreCountLabel.text = @"1 serving";
        if (sender.value > 1) {
            self.scoreCountLabel.text = [NSString stringWithFormat:@"%.0f servings", sender.value];
        }
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
