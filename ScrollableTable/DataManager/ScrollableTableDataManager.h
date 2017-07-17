//
//  ScrollableTableDataManager.h
//  ScrollableTable
//
//  Created by Hitesh Joshi on 09/07/17.
//  Copyright © 2017 Hitesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollableTableDataManager : NSObject

@property (readwrite,nonatomic) NSMutableArray *feedArray;

- (void) downloadDataFromRequest: (void (^)(void))completionBlock;


@end
