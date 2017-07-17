//
//  ScrollableTableDataModel.h
//  ScrollableTable
//
//  Created by Hitesh Joshi on 10/07/17.
//  Copyright © 2017 Hitesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScrollableTableDataModel : NSObject

@property (atomic, readwrite) NSString * _Nonnull title;
@property (atomic, readwrite) NSString * _Nonnull rights;
@property (atomic, readwrite) NSString * _Nonnull singers;
@property (atomic, readwrite) NSString * _Nonnull price;
@property (atomic, readwrite) NSString * _Nonnull releaseDate;

@end
