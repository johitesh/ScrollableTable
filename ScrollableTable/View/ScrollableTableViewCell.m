//
//  ScrollableTableViewCell.m
//  ScrollableTable
//
//  Created by Hitesh Joshi on 09/07/17.
//  Copyright © 2017 Hitesh. All rights reserved.
//
/******************************************************************************
This class is added to customize the table view cell behaviou as required.
• Currently it serves the purpose of changing the value of label constraint(minimum till 10px) 
  per need basis, by just changing the constraints constant values.
• Future Changes:
    • This class be useful to support Image along with label in the table view row.
    • Add support to  have minimum constraint constants value less from 10px.
 
*******************************************************************************/


#import "ScrollableTableViewCell.h"

//Autolayout Constraints constant value, can be change as per requirement.
//Currently the minimum value supported is 10px, setting less then that may give strange table view behaviour.
//Support for less minimum value for constraints is tagged for future changes
long labelTopConstraintValue = 32;
long labelBottomConstraintValue = 32;
long labelLeadingConstraintValue = 16;
long labelTrailingConstraintValue = 16;

@implementation ScrollableTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_labelTopConstraint setConstant: labelTopConstraintValue];
    [_labelBottomConstraint setConstant:labelBottomConstraintValue];
    [_labelLeadingConstraint setConstant:labelLeadingConstraintValue];
    [_labelTrailingConstant setConstant:labelTrailingConstraintValue];
    [self layoutIfNeeded];
}

@end
