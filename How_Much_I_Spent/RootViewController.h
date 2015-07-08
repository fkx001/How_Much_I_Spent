//
//  RootViewController.h
//  How_Much_I_Spent
//
//  Created by Kangxing Fu on 9/17/14.
//  Copyright (c) 2014 Kangxing Fu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpentDataSets.h"
#import "AddSpentIssueViewController.h"
#import "ByYearTableViewController.h"
#import "GraphCustomizeViewController.h"

@interface RootViewController : UIViewController

@property (retain, nonatomic) SpentDataSets *dataSets;

@end
