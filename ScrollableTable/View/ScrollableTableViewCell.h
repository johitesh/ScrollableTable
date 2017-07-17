 //
//  ScrollableTableViewCell.h
//  ScrollableTable
//
//  Created by Hitesh Joshi on 09/07/17.
//  Copyright © 2017 Hitesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollableTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *scrollTableViewLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelTrailingConstant;

@end
