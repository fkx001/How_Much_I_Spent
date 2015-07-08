//
//  AddSpentIssueViewController.m
//  How_Much_I_Spent
//
//  Created by Kangxing Fu on 9/17/14.
//  Copyright (c) 2014 Kangxing Fu. All rights reserved.
//

#import "AddSpentIssueViewController.h"

@interface AddSpentIssueViewController ()

@end

@implementation AddSpentIssueViewController

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
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
    [_timePicker setDatePickerMode:UIDatePickerModeTime];
    [self setTitle:@"Set Time"];
    [_scroller setScrollEnabled:YES];
    [_scroller setContentSize:CGSizeMake(320, 600)];
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
    if ([[segue identifier] isEqualToString:@"addtonext"]) {
        NextAddSpentIssueViewController *nextAddSpentIssueViewController = [segue destinationViewController];
        
        NSDate *date = [_datePicker date];
        NSDate *time = [_timePicker date];
        NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
        NSDateComponents *timeComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:time];
        _year = [[NSNumber alloc] initWithInteger:[dateComponents year]];
        _month = [[NSNumber alloc] initWithInteger:[dateComponents month]];
        _day = [[NSNumber alloc] initWithInteger:[dateComponents day]];
        _hour = [[NSNumber alloc] initWithInteger:[timeComponents hour]];
        
        [nextAddSpentIssueViewController setDataSets:_dataSets];
        [nextAddSpentIssueViewController setYear:_year];
        [nextAddSpentIssueViewController setMonth:_month];
        [nextAddSpentIssueViewController setDay:_day];
        [nextAddSpentIssueViewController setHour:_hour];
    }
}

- (IBAction)nextButtonAction:(id)sender {
}
@end
