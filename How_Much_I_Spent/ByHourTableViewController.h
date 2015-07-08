//
//  ByHourTableViewController.h
//  How_Much_I_Spent
//
//  Created by Kangxing Fu on 9/17/14.
//  Copyright (c) 2014 Kangxing Fu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpentDataSets.h"
#import "SpentIssueTableViewController.h"

@interface ByHourTableViewController : UITableViewController

@property (retain, nonatomic) SpentDataSets *dataSets;
@property (retain, nonatomic) NSNumber *year;
@property (retain, nonatomic) NSNumber *month;
@property (retain, nonatomic) NSNumber *day;
@property (retain, nonatomic) NSArray *sumbyhourArray;

@end
