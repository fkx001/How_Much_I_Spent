//
//  ByMonthTableViewController.h
//  How_Much_I_Spent
//
//  Created by Kangxing Fu on 9/17/14.
//  Copyright (c) 2014 Kangxing Fu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpentDataSets.h"
#import "ByDayTableViewController.h"

@interface ByMonthTableViewController : UITableViewController

@property (retain, nonatomic) SpentDataSets *dataSets;
@property (retain, nonatomic) NSNumber *year;
@property (retain, nonatomic) NSArray *sumbymonthArray;

@end
