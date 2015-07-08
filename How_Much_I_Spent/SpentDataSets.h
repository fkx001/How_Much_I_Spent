//
//  SpentDataSets.h
//  How_Much_I_Spent
//
//  Created by Kangxing Fu on 9/17/14.
//  Copyright (c) 2014 Kangxing Fu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "SpentIssue.h"
#import "SumbyHour.h"
#import "SumbyDay.h"
#import "SumbyMonth.h"
#import "SumbyYear.h"

@interface SpentDataSets : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)addSpentIssueWithYear:(NSNumber *)year Month:(NSNumber *)month Day:(NSNumber *)day Hour:(NSNumber *)hour Money:(NSNumber *)money Describe:(NSString *)describe;
- (void)deleteSpentIssueWith:(SpentIssue *)oneSpentIssue;
- (NSArray *)getSumbyYearList;
- (NSArray *)getSumbyMonthListWithYear:(NSNumber *)year;
- (NSArray *)getSumbyDayListWithYear:(NSNumber *)year Month:(NSNumber *)month;
- (NSArray *)getSumbyHourListWithYear:(NSNumber *)year Month:(NSNumber *)month Day:(NSNumber *)day;
- (NSArray *)getSpentIssueListWithYear:(NSNumber *)year Month:(NSNumber *)month Day:(NSNumber *)day Hour:(NSNumber *)hour;
- (NSArray *)getDataWithDataPointsNumber:(NSInteger)dataPointsNumber InSumbyYearWithLastYear:(NSInteger)lastYear;
- (NSArray *)getDataWithDataPointsNumber:(NSInteger)dataPointsNumber InSumbyMonthWithLastYear:(NSInteger)lastYear LastMonth:(NSInteger)lastMonth;
- (NSArray *)getDataWithDataPointsNumber:(NSInteger)dataPointsNumber InSumbyDayWithLastYear:(NSInteger)lastYear LastMonth:(NSInteger)lastMonth LastDay:(NSInteger)lastDay;

@end
