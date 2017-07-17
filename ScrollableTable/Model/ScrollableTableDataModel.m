//
//  ScrollableTableDataModel.m
//  ScrollableTable
//
//  Created by Hitesh Joshi on 10/07/17.
//  Copyright © 2017 Hitesh. All rights reserved.
//
/******************************************************************************
 Model class to store the data from the iTunes feed.
 *******************************************************************************/

#import "ScrollableTableDataModel.h"

@implementation ScrollableTableDataModel

#pragma mark - initialization

//Initialize
- (id)init
{
    self = [super init];
    if (self)
    {
        _title = @"Default Title";
        _rights = @"Default Rights";
        _singers = @"Default Singers";
        _price = @"Default Price";
    }
    return self;
}


@end
