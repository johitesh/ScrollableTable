//
//  ScrollableTableViewController.h
//  ScrollableTable
//
//  Created by Hitesh Joshi on 09/07/17.
//  Copyright © 2017 Hitesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollableTableViewController : UITableViewController

@property (nonatomic, assign) NSInteger currentExpandedRow;
@property (nonatomic, assign) NSInteger previousExpandedRow;
@property (nonatomic, strong) NSMutableArray *dataArray;

-(void) loadData;

@end
