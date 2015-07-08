//
//  GraphCustomizeViewController.h
//  How_Much_I_Spent
//
//  Created by Kangxing Fu on 9/19/14.
//  Copyright (c) 2014 Kangxing Fu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpentDataSets.h"
#import "GraphViewController.h"

@interface GraphCustomizeViewController : UIViewController

@property (retain, nonatomic) SpentDataSets *dataSets;
@property (weak, nonatomic) IBOutlet UISegmentedControl *unitSegment;
@property (weak, nonatomic) IBOutlet UIDatePicker *lastDatePicker;
@property (weak, nonatomic) IBOutlet UITextField *dataPointsNumberTextField;

- (IBAction)generateButtonAction:(id)sender;

@end
