//
//  MTActivityCell.m
//  Mortify
//
//  Created by America on 10/19/13.
//  Copyright (c) 2013 Kevin Nguy. All rights reserved.
//

#import "MTActivityCell.h"

#import <QuartzCore/QuartzCore.h>

@implementation MTActivityCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.microMortLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        self.microMortLabel.font = [UIFont helveticaNeueThinWithSize:20.0f];
        self.microMortLabel.textAlignment = NSTextAlignmentCenter;
        self.microMortLabel.textColor = [UIColor whiteColor];
        self.microMortLabel.layer.borderColor = self.microMortLabel.textColor.CGColor;
        self.microMortLabel.layer.borderWidth = 1.0f;
        self.microMortLabel.layer.cornerRadius = CGRectGetWidth(self.microMortLabel.frame) / 2;
        
        self.activityLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 + CGRectGetWidth(self.microMortLabel.frame) + 10, 10, CGRectGetWidth(self.contentView.frame) - 10 - CGRectGetWidth(self.microMortLabel.frame) - 10, 40)];
        self.activityLabel.font = [UIFont helveticaNeueThinWithSize:26.0f];
        self.activityLabel.textColor = [UIColor whiteColor];
        
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.microMortLabel];
        [self.contentView addSubview:self.activityLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    
}

@end
