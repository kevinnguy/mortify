//
//  MTActivityDetailsViewController.m
//  Mortify
//
//  Created by America on 10/19/13.
//  Copyright (c) 2013 Kevin Nguy. All rights reserved.
//

#import "MTActivityDetailsViewController.h"

#import "MTActivityCell.h"

@interface MTActivityDetailsViewController () <UINavigationControllerDelegate>
// Details Row
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UILabel *activityNameLabel;
@property (nonatomic, strong) UIStepper *scoreStepper;
@property (nonatomic, strong) UILabel *scoreCountLabel;

// Risk Row
@property (nonatomic, strong) NSMutableArray *riskActivitiesMutableArray;

// Social Row
@property (nonatomic, strong) NSMutableArray *socialMutableArray;

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
    
    self.riskActivitiesMutableArray = [@[[[MTActivity alloc] initWithActivity:@"Driving" score:-0.1],
                                         [[MTActivity alloc] initWithActivity:@"Ecstacy" score:-0.3],
                                         [[MTActivity alloc] initWithActivity:@"Coffee" score:0.1]
                                         ] mutableCopy];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.delegate didChangeScore:self.activity.score atRowIndex:self.activityLogArrayIndex];
    [self.navigationController popToRootViewControllerAnimated:YES];
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
    self.scoreCountLabel.font = [UIFont helveticaNeueThinWithSize:22.0f];
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
    
    [self.tableView reloadData];
}

#pragma mark - UITableView delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    int height = 0;
    
    switch (section) {
        case DETAILS_ROW:
            break;
            
        case RISK_ROW:
            height = 44;
            break;
            
        case SOCIAL:
            height = 44;
            break;
            
        default:
            break;
    }
    
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, CGRectGetWidth(tableView.frame) - 15, tableView.sectionHeaderHeight)];
    label.font = [UIFont systemFontOfSize:18.0f];
    label.textColor = [UIColor whiteColor];
    
    switch (section) {
        case DETAILS_ROW:
            label.frame = CGRectZero;
            break;
            
        case RISK_ROW:
            label.text = @"Risks you can take";
            break;
            
        case SOCIAL:
            label.text = @"Social Stats";
            break;
            
        default:
            break;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), tableView.sectionHeaderHeight)];
    view.backgroundColor = [UIColor clearColor];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(view.frame) - 1, CGRectGetWidth(view.frame), 1)];
    line.backgroundColor = [UIColor whiteTableViewSeparatorColor];
    [view addSubview:label];
    [view addSubview:line];
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int rows = 0;
    
    if (tableView == self.tableView) {
        switch (section) {
            case DETAILS_ROW:
                rows = 1;
                break;
                
            case RISK_ROW:
                rows = 3;
                break;
             
            case SOCIAL:
                rows = 3;
                break;
                
            default:
                break;
        }
    }
    
    return rows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    int height = 0;
    
    if (tableView == self.tableView) {
        switch (indexPath.section) {
            case DETAILS_ROW:
                height = 150;
                break;
            
            case RISK_ROW:
                height = 60;
                break;
             
            case SOCIAL:
                height = 60;
                break;
                
            default:
                break;
        }
    }
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        if (indexPath.section == DETAILS_ROW) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            
            [cell addSubview:self.scoreLabel];
            [cell addSubview:self.activityNameLabel];
            [cell addSubview:self.scoreStepper];
            [cell addSubview:self.scoreCountLabel];
            
            return cell;
        } else {
            MTActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:ACTIVITY_CELL];
            if (cell == nil) {
                cell = [[MTActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ACTIVITY_CELL];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (indexPath.section == RISK_ROW) {
                if (self.scoreStepper.value >= 3) {
                    if (indexPath.row == 0) {
                        cell.activityLabel.text = @"Smoking - 1 cigarette";
                        cell.microMortLabel.text = @"0.7";
                        
                        cell.microMortLabel.layer.borderColor = [UIColor orangeMortifyColor].CGColor;
                        cell.microMortLabel.textColor = [UIColor orangeMortifyColor];
                    } else if (indexPath.row == 1) {
                        cell.activityLabel.text = @"Skydiving - 1 time";
                        cell.microMortLabel.text = @"0.7";
                        
                        cell.microMortLabel.layer.borderColor = [UIColor orangeMortifyColor].CGColor;
                        cell.microMortLabel.textColor = [UIColor orangeMortifyColor];
                    } else if (indexPath.row == 2) {
                        cell.activityLabel.text = @"Exercise - 20 minutes";
                        cell.microMortLabel.text = @"1.0";

                        cell.microMortLabel.layer.borderColor = [UIColor greenMortifyColor].CGColor;
                        cell.microMortLabel.textColor = [UIColor greenMortifyColor];
                    }
                } else if (self.scoreStepper.value >= 2) {
                    if (indexPath.row == 0) {
                        cell.activityLabel.text = @"Driving - 40 minutes";
                        cell.microMortLabel.text = @"0.2";
                        
                        cell.microMortLabel.layer.borderColor = [UIColor orangeMortifyColor].CGColor;
                        cell.microMortLabel.textColor = [UIColor orangeMortifyColor];
                    } else if (indexPath.row == 1) {
                        cell.activityLabel.text = @"Ecstacy - 1 time";
                        cell.microMortLabel.text = @"0.5";
                        
                        cell.microMortLabel.layer.borderColor = [UIColor orangeMortifyColor].CGColor;
                        cell.microMortLabel.textColor = [UIColor orangeMortifyColor];
                    } else if (indexPath.row == 2) {
                        cell.activityLabel.text = @"Coffee - 1 cup";
                        cell.microMortLabel.text = @"1.0";
                        
                        cell.microMortLabel.layer.borderColor = [UIColor greenMortifyColor].CGColor;
                        cell.microMortLabel.textColor = [UIColor greenMortifyColor];
                    }
                } else if (self.scoreStepper.value >= 1) {
                    if (indexPath.row == 0) {
                        cell.activityLabel.text = @"Driving - 20 minutes";
                        cell.microMortLabel.text = @"0.1";
                        
                        cell.microMortLabel.layer.borderColor = [UIColor orangeMortifyColor].CGColor;
                        cell.microMortLabel.textColor = [UIColor orangeMortifyColor];
                    } else if (indexPath.row == 1) {
                        cell.activityLabel.text = @"Sitting - 1 hour";
                        cell.microMortLabel.text = @"0.1";
                        
                        cell.microMortLabel.layer.borderColor = [UIColor orangeMortifyColor].CGColor;
                        cell.microMortLabel.textColor = [UIColor orangeMortifyColor];
                    } else if (indexPath.row == 2) {
                        cell.activityLabel.text = @"Eating fruits/vegetables - 1 serving";
                        cell.microMortLabel.text = @"0.2";
                        
                        cell.microMortLabel.layer.borderColor = [UIColor greenMortifyColor].CGColor;
                        cell.microMortLabel.textColor = [UIColor greenMortifyColor];
                    }
                }
            } else if (indexPath.section == SOCIAL) {
                
                if (indexPath.row == 0) {
                    cell.activityLabel.text = @"Friends do this daily";
                    cell.microMortLabel.text = @"48";
                } else if (indexPath.row == 1) {
                    cell.activityLabel.text = @"Worldwide do this daily";
                    cell.microMortLabel.text = @"26%";
                    cell.microMortLabel.font = [UIFont helveticaNeueThinWithSize:16.0f];
                } else if (indexPath.row == 2) {
                    cell.activityLabel.text = @"23 year old men do this daily";
                    cell.microMortLabel.text = @"46%";
                    cell.microMortLabel.font = [UIFont helveticaNeueThinWithSize:16.0f];
                }
                
                cell.microMortLabel.layer.borderColor = [UIColor blueMortifyColor].CGColor;
                cell.microMortLabel.textColor = [UIColor blueMortifyColor];
            }
            
            return cell;
        }
    }
    
    // Is not suppose to return
    UITableViewCell *cell;
    return cell;
}


@end
