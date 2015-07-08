//
//  GraphCustomizeViewController.m
//  How_Much_I_Spent
//
//  Created by Kangxing Fu on 9/19/14.
//  Copyright (c) 2014 Kangxing Fu. All rights reserved.
//

#import "GraphCustomizeViewController.h"

@interface GraphCustomizeViewController ()

@end

@implementation GraphCustomizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_lastDatePicker setDatePickerMode:UIDatePickerModeDate];
    [_dataPointsNumberTextField setText:@"5"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"drawthegraph"]) {
        GraphViewController *graphViewController = [segue destinationViewController];
        int segmentIndex = [_unitSegment selectedSegmentIndex];
        NSInteger dataPointsNumber = [[_dataPointsNumberTextField text] integerValue];
        if (dataPointsNumber > 15) {
            dataPointsNumber = 15;
        }
        if (dataPointsNumber < 2) {
            dataPointsNumber = 2;
        }
        NSDate *lastDate = [_lastDatePicker date];
        NSDateComponents *lastDateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:lastDate];
        NSInteger year = [lastDateComponents year];
        NSInteger month = [lastDateComponents month];
        NSInteger day = [lastDateComponents day];
        NSArray *dataPointsArray;
        if (segmentIndex == 0) {
            dataPointsArray = [_dataSets getDataWithDataPointsNumber:dataPointsNumber InSumbyYearWithLastYear:year];
            [graphViewController setUnitString:@"Year"];
        }
        else if (segmentIndex == 1) {
            dataPointsArray = [_dataSets getDataWithDataPointsNumber:dataPointsNumber InSumbyMonthWithLastYear:year LastMonth:month];
            [graphViewController setUnitString:@"Month"];
        }
        else if (segmentIndex == 2) {
            dataPointsArray = [_dataSets getDataWithDataPointsNumber:dataPointsNumber InSumbyDayWithLastYear:year LastMonth:month LastDay:day];
            [graphViewController setUnitString:@"Day"];
        }
        NSMutableArray *pointsXArray = [[NSMutableArray alloc] init];
        NSMutableArray *pointsYArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < [dataPointsArray count]; i++) {
            NSNumber *pointX = [[dataPointsArray objectAtIndex:i] objectAtIndex:0];
            NSNumber *pointY = [[dataPointsArray objectAtIndex:i] objectAtIndex:1];
            [pointsXArray addObject:pointX];
            [pointsYArray addObject:pointY];
        }
        [graphViewController setPointsXArray:[pointsXArray copy]];
        [graphViewController setPointsYArray:[pointsYArray copy]];
    }
}

- (IBAction)generateButtonAction:(id)sender {
}
@end
