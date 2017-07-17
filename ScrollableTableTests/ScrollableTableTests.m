//
//  ScrollableTableViewControllerTests.m
//  ScrollableTable
//
//  Created by Hitesh Joshi on 13/07/17.
//  Copyright © 2017 Hitesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>
#import "ScrollableTableViewController.h"
#import "ScrollableTableDataManager.h"
#import "AFNetworking.h"



@interface ScrollableTableViewControllerTests : XCTestCase
@property (nonatomic, strong) ScrollableTableViewController *vc;
@property (nonatomic,assign) BOOL isInitialized;

@end

@implementation ScrollableTableViewControllerTests

- (void)setUp {
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.vc = [storyboard instantiateViewControllerWithIdentifier:@"scrollableTableView"];
}

- (void)tearDown
{
    self.vc = nil;
    [super tearDown];
}

#pragma mark - View loading tests
-(void)testThatViewLoads
{
    XCTAssertNotNil(self.vc.view, @"View not initiated properly");
}

-(void)testScrollableTableLoads
{
    XCTAssertNotNil(self.vc.tableView, @"TableView not initiated");
}

#pragma mark - UITableView tests
- (void)testScrollableTableConformsToTableViewDataSource
{
    XCTAssertTrue([self.vc conformsToProtocol:@protocol(UITableViewDataSource) ], @"View does not conform to UITableView datasource protocol");
}

- (void)testScrollableTableDataSource
{
    XCTAssertNotNil(self.vc.tableView.dataSource, @"Table datasource cannot be nil");
}

- (void)testScrollableTableConformsTableViewDelegate
{
    XCTAssertTrue([self.vc conformsToProtocol:@protocol(UITableViewDelegate) ], @"View does not conform to UITableView delegate protocol");
}

- (void)testScrollableTableDelegate
{
    XCTAssertNotNil(self.vc.tableView.delegate, @"Table delegate cannot be nil");
}

- (void) testDownloadDataFromRequestCall{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    AFXMLParserResponseSerializer *responseSerializer = [AFXMLParserResponseSerializer serializer];
    NSMutableSet *currentContentTypes = responseSerializer.acceptableContentTypes.mutableCopy;
    [currentContentTypes addObject:@"application/atom+xml"];
    responseSerializer.acceptableContentTypes = [NSSet setWithSet:currentContentTypes];
    manager.responseSerializer = responseSerializer;
    
    NSURL *URL = [NSURL URLWithString:@"https://itunes.apple.com/us/rss/topsongs/limit=10/xml"];
    NSString *description = [NSString stringWithFormat:@"GET %@", URL];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        
        XCTAssertNotNil(responseObject, "data should not be nil");
        XCTAssertNil(error, "error should be nil");
        
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            XCTAssertEqual(httpResponse.statusCode, 200, @"HTTP response status code should be 200");
            XCTAssertEqualObjects(httpResponse.URL.absoluteString, URL.absoluteString, @"HTTP response URL should be equal to original URL");
            XCTAssertEqualObjects(httpResponse.MIMEType, @"application/atom+xml", @"HTTP response content type should be application/atom+xml");
        } else {
            XCTFail(@"Response was not NSHTTPURLResponse");
        }
        
        [expectation fulfill];
        
    }];
    [dataTask resume];
    
    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
    }];
}

- (void)testScrollableTableRowsAndSections
{
    NSLog(@"Controller class-1: %@", self.vc);
    [self.vc view];
    __weak ScrollableTableViewController *weakSelf = self.vc;
    ScrollableTableDataManager *dataManager = [[ScrollableTableDataManager alloc] init];
    XCTestExpectation *expectation = [self expectationWithDescription:@"TEST"];
    [dataManager downloadDataFromRequest:^{
        weakSelf.dataArray = [dataManager feedArray];
        [weakSelf.tableView reloadData];
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:20 handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
    }];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    UITableViewCell *cell = [self.vc tableView:self.vc.tableView cellForRowAtIndexPath:indexPath];
    XCTAssertEqual([dataManager feedArray].count, 10, @"Response should have 10 counts");
    XCTAssertEqual([self.vc.tableView numberOfRowsInSection:0], 20, @"Table has %ld rows but it should have 20", [self.vc.tableView numberOfRowsInSection:0]);
    XCTAssertTrue([cell.reuseIdentifier isEqualToString:@"scrollableTableViewCell"], @"Table does not create reusable cells");
    XCTAssertLessThan(self.vc.tableView.rowHeight, self.vc.tableView.estimatedRowHeight, @"Response should have 10 counts");
    [self.vc tableView:[UITableView new] didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    XCTAssertEqual(self.vc.currentExpandedRow, 1 , @"Response should have 10 counts");
    
    
}



@end


