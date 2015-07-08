//
//  GraphViewController.h
//  How_Much_I_Spent
//
//  Created by Kangxing Fu on 9/19/14.
//  Copyright (c) 2014 Kangxing Fu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrendGraphic.h"

@interface GraphViewController : UIViewController

@property (retain, nonatomic) NSArray *pointsXArray;
@property (retain, nonatomic) NSArray *pointsYArray;
@property (copy, nonatomic) NSString *unitString;

@end
