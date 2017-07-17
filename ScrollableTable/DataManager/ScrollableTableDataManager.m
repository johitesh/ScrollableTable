//
//  ScrollableTableDataManager.m
//  ScrollableTable
//
//  Created by Hitesh Joshi on 09/07/17.
//  Copyright © 2017 Hitesh. All rights reserved.
//
/******************************************************************************
 This class is to deal with data, making a server request and getting the data
 and setting it up in model.
 • This class uses the AFNetworking framework for server calls and
 XMLDictionary classes for parsing the XML response.
 • Once the response is received it call back ScrollableTableViewController to
 set up the data in a view.
 *******************************************************************************/


#import "ScrollableTableDataManager.h"
#import "AFNetworking.h"
#import "XMLDictionary.h"
#import "ScrollableTableDataModel.h"

//Constants
static NSString *const feedURL = @"https://itunes.apple.com/us/rss/topsongs/limit=10/xml";
static NSString *const responseTitleKey = @"title";
static NSString *const responseRightsKey = @"rights";
static NSString *const responseArtistKey = @"im:artist";
static NSString *const responsePriceKey = @"im:price";
static NSString *const responseReleaseDateKey = @"im:releaseDate";
static NSString *const responseTextKey = @"__text";
static NSString *const responseLabelKey = @"_label";
static NSString *const responseEntryKey = @"entry";


@implementation ScrollableTableDataManager

@synthesize feedArray;

#pragma mark - Feed Download API
/**
 This methods download the top n songs from iTunes feed.
 @param completionBlock Call back for Table view to display the data in UI.
 */
- (void) downloadDataFromRequest: (void (^)(void))completionBlock{
    self.feedArray = [[NSMutableArray alloc] init];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    AFXMLParserResponseSerializer *responseSerializer = [AFXMLParserResponseSerializer serializer];
    NSMutableSet *currentContentTypes = responseSerializer.acceptableContentTypes.mutableCopy;
    [currentContentTypes addObject:@"application/atom+xml"];
    responseSerializer.acceptableContentTypes = [NSSet setWithSet:currentContentTypes];
    manager.responseSerializer = responseSerializer;
    
    NSURL *URL = [NSURL URLWithString:feedURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSDictionary *dictionary =  [[XMLDictionaryParser sharedInstance] dictionaryWithParser:responseObject];
            NSArray *dataArray = [dictionary arrayValueForKeyPath:responseEntryKey];
            for (id data in dataArray){
                ScrollableTableDataModel *dataObj = [[ScrollableTableDataModel alloc] init] ;
                dataObj.title = data[responseTitleKey];
                dataObj.rights = data[responseRightsKey];
                dataObj.singers = [[data objectForKey:responseArtistKey] valueForKey:responseTextKey];
                dataObj.price =  [[data objectForKey:responsePriceKey] valueForKey:responseTextKey];
                dataObj.releaseDate = [[data objectForKey:responseReleaseDateKey] valueForKey:responseLabelKey];
                //Set the data in feed Array.
                [self.feedArray addObject:dataObj];
            }
            //Call back for table view to reload data from feed.
            completionBlock();
        }
    }];
    [dataTask resume];
}

@end
