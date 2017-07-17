//
//  ScrollableTableViewController.m
//  ScrollableTable
//
//  Created by Hitesh Joshi on 09/07/17.
//  Copyright © 2017 Hitesh. All rights reserved.
//
/******************************************************************************
 The view controller class deals with getting the data and setting up in UI.
 Deal with the Tableview methods to set the data.
 *******************************************************************************/

#import "ScrollableTableViewController.h"
#import "ScrollableTableViewCell.h"
#import "ScrollableTableDataManager.h"
#import "ScrollableTableDataModel.h"

//Constants
static NSString *const primaryLabelTextFormat = @"Position: %lu\n%@";
static NSString *const secondaryLabelTextFormat = @"Track: %@\nRelease date: %@\nSingers: %@\nPrice: %@";
static NSString *const cellIdentifier = @"scrollableTableViewCell";

@interface ScrollableTableViewController ()

@end

@implementation ScrollableTableViewController

#pragma mark - Table view UI

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 140;
    _currentExpandedRow  = -1;
    _dataArray = [[NSMutableArray alloc] init];
    self.previousExpandedRow = _currentExpandedRow;
    [self loadData];
}

/**
 Method to call data Manager api to fetch the feed and display in UI.
 */
-(void) loadData{
    //Although there won't be retain cycle but as part of best coding practice
    //use weak self in blocks and avoid any future chnages to cause retain cycle.
    __weak ScrollableTableViewController *weakSelf = self;
    ScrollableTableDataManager *dataManager = [[ScrollableTableDataManager alloc] init];
    [dataManager downloadDataFromRequest:^{
        //Updating UI update in main queue as a part of best coding practice.
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.dataArray = [dataManager feedArray];
            [weakSelf.tableView reloadData];
        });
        
    }];
}
/**
 Format the text to be displayed in UI
 
 @param inputObject model object having the data from itunes feed.
 @return The formatted string which will be displayed in Scrollable table row.
 */
- (NSString*) formatText:(ScrollableTableDataModel*) inputObject {
    NSString *text = [NSString stringWithFormat:secondaryLabelTextFormat,inputObject.title,inputObject.releaseDate,inputObject.singers,inputObject.price];
    return text;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //Multiply the count by two to simulate the infinite scrolling for table view.
    return self.dataArray.count * 2 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Morphed the index path to support the infinite scrolling behavior.
    long mod = indexPath.row % self.dataArray.count;
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:mod inSection:indexPath.section];
    // Reusable table view cell.
    ScrollableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath1];
    //Check the index path to accomodate the expand and collapse behavior of row based on which row was tapped.
    if((indexPath1.row == _currentExpandedRow) || ((_currentExpandedRow != -1) && (indexPath1.row  ==  ((_currentExpandedRow)%_dataArray.count)))){
        //On tap, display all the label text
        cell.scrollTableViewLabel.numberOfLines = 0;
    }
    else{
        //Minimized or initial state, display only three lines of text.
        cell.scrollTableViewLabel.numberOfLines = 3;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //cell.scrollTableViewLabel.sizeToFit;
    cell.scrollTableViewLabel.lineBreakMode = 0;
    //Set the label text.
    cell.scrollTableViewLabel.text = [NSString stringWithFormat:primaryLabelTextFormat,indexPath1.row,[self formatText:_dataArray[indexPath1.row]]];
    cell.scrollTableViewLabel.textColor = [UIColor whiteColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //Collapse the current row if another row is tapped.
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:indexPath.row % _dataArray.count inSection:indexPath.section];
    if((_currentExpandedRow != -1) && (_previousExpandedRow != indexPath1.row)){
        //Avoid animation while reloading the table view.
        [UIView performWithoutAnimation:^{
            [tableView reloadData];
        }];
        
    }
    
    //Check to set the ivar for acheiving the expand and collapse behavior on tap.
    if (indexPath.row != _currentExpandedRow){
        _currentExpandedRow = indexPath.row;
        _previousExpandedRow = _currentExpandedRow;
    }
    else{
        _currentExpandedRow = -1;
    }
    //Beign,reloads and end update calls for expanding and collapsing the rows.
    //With fade animation which can be chnaged as needed.
    [[self tableView] beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationFade];
    [[self tableView] endUpdates];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
    //Changing the alternate row appearance.
    if(indexPath.row % 2 == 0){
        cell.backgroundColor = [UIColor blackColor];
    }
    else
    {
        cell.backgroundColor = [UIColor purpleColor];
    }
    tableView.backgroundColor = cell.backgroundColor;
}

#pragma mark - Table view Scroll

//Handles infinite scroll.
-(void)scrollViewDidScroll:(UIScrollView *)scrollView_
{
    CGFloat viewOffsetX = scrollView_.contentOffset.x;
    CGFloat viewOffSetY = scrollView_.contentOffset.y;
    CGFloat viewHeight = scrollView_.contentSize.height;
    //Reached top, set content to support infinite scroll.
    if (viewOffSetY <= 0.0) {
        scrollView_.contentOffset = CGPointMake(viewOffsetX,(viewOffSetY + (viewHeight/2)));
    }
    //Reached bottom, set content to support infinite scroll.
    if(viewOffSetY >= ( viewHeight - self.tableView.bounds.size.height )){
        scrollView_.contentOffset = CGPointMake(viewOffsetX,(viewOffSetY - (viewHeight/2)));
    }
}

@end
