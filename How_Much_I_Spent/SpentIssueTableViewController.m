//
//  SpentIssueTableViewController.m
//  How_Much_I_Spent
//
//  Created by Kangxing Fu on 9/17/14.
//  Copyright (c) 2014 Kangxing Fu. All rights reserved.
//

#import "SpentIssueTableViewController.h"

@interface SpentIssueTableViewController ()

@end

@implementation SpentIssueTableViewController
{
    NSArray *numtomonth;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _spentissueArray = [_dataSets getSpentIssueListWithYear:_year Month:_month Day:_day Hour:_hour];
    numtomonth = [[NSArray alloc] initWithObjects:@"January", @"February", @"March", @"April", @"May", @"June", @"July", @"August", @"September", @"October", @"November", @"Decemnber", nil];
    NSString *month = [numtomonth objectAtIndex:[_month intValue] - 1];
    int hournum =[_hour intValue];
    NSString *hour = [NSString stringWithFormat:@"%i:00 - %i:00", hournum, (hournum + 1)];
    [self setTitle:[NSString stringWithFormat:@"%@ %@ %@, %@", month, _day, _year, hour]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_spentissueArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"spentIssueCell" forIndexPath:indexPath];
    
    // Configure the cell...
    SpentIssue *oneSpentIssue = [_spentissueArray objectAtIndex:[indexPath row]];
    NSString *money = [[oneSpentIssue money] stringValue];
    NSString *description = [oneSpentIssue describe];
    [[cell textLabel] setText:[@"$" stringByAppendingString:money]];
    [[cell detailTextLabel] setText:description];
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableArray *spentissueMutableArray = [_spentissueArray mutableCopy];
        SpentIssue *deletedSpentIssue = [_spentissueArray objectAtIndex:[indexPath row]];
        [spentissueMutableArray removeObjectAtIndex:[indexPath row]];
        _spentissueArray = [NSArray arrayWithArray:spentissueMutableArray];
        [_dataSets deleteSpentIssueWith:deletedSpentIssue];
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _spentissueArray = [_dataSets getSpentIssueListWithYear:_year Month:_month Day:_day Hour:_hour];
    [self.tableView reloadData];
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
