//
//  RootViewController.m
//  How_Much_I_Spent
//
//  Created by Kangxing Fu on 9/17/14.
//  Copyright (c) 2014 Kangxing Fu. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataSets = [[SpentDataSets alloc] init];
    [self setTitle:@"Menu"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"roottoadd"]) {
        AddSpentIssueViewController *addSpentIssueViewController = [segue destinationViewController];
        [addSpentIssueViewController setDataSets:_dataSets];
    }
    else if ([[segue identifier] isEqualToString:@"roottoyear"]) {
        ByYearTableViewController *byYearTableViewController = [segue destinationViewController];
        [byYearTableViewController setDataSets:_dataSets];
    }
    else if ([[segue identifier] isEqualToString:@"totrendgraph"]) {
        GraphCustomizeViewController *graphCustomizeViewController = [segue destinationViewController];
        [graphCustomizeViewController setDataSets:_dataSets];
    }
}


@end
