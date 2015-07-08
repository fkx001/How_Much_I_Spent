//
//  SumbyMonth.h
//  How_Much_I_Spent
//
//  Created by Kangxing Fu on 9/17/14.
//  Copyright (c) 2014 Kangxing Fu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SumbyMonth : NSManagedObject

@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) NSNumber * month;
@property (nonatomic, retain) NSDecimalNumber * money;

@end
