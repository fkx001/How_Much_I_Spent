//
//  AddSpentIssueViewController.h
//  How_Much_I_Spent
//
//  Created by Kangxing Fu on 9/17/14.
//  Copyright (c) 2014 Kangxing Fu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpentDataSets.h"
#import "NextAddSpentIssueViewController.h"

@interface AddSpentIssueViewController : UIViewController

@property (retain, nonatomic) SpentDataSets *dataSets;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (retain, nonatomic) NSNumber *year;
@property (retain, nonatomic) NSNumber *month;
@property (retain, nonatomic) NSNumber *day;
@property (retain, nonatomic) NSNumber *hour;
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;

- (IBAction)nextButtonAction:(id)sender;

@end
