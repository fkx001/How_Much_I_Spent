//
//  SpentDataSets.m
//  How_Much_I_Spent
//
//  Created by Kangxing Fu on 9/17/14.
//  Copyright (c) 2014 Kangxing Fu. All rights reserved.
//

#import "SpentDataSets.h"

@implementation SpentDataSets

- (id)init
{
    self = [super init];
    if (self) {
        AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
        _managedObjectContext = [appdelegate managedObjectContext];
    }
    return self;
}

- (void)addSpentIssueWithYear:(NSNumber *)year Month:(NSNumber *)month Day:(NSNumber *)day Hour:(NSNumber *)hour Money:(NSNumber *)money Describe:(NSString *)describe
{
    SpentIssue *spentIssue = [NSEntityDescription insertNewObjectForEntityForName:@"SpentIssue" inManagedObjectContext:_managedObjectContext];
    NSDecimalNumber *moneyvalid = [[NSDecimalNumber alloc] initWithDouble:(round(100 * [money doubleValue]) / 100)];
    [spentIssue setYear:year];
    [spentIssue setMonth:month];
    [spentIssue setDay:day];
    [spentIssue setHour:hour];
    [spentIssue setMoney:moneyvalid];
    [spentIssue setDescribe:describe];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *sumbyYear = [NSEntityDescription entityForName:@"SumbyYear" inManagedObjectContext:_managedObjectContext];
    [request setEntity:sumbyYear];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"year == %@", year];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *sumbyyearArray = [_managedObjectContext executeFetchRequest:request error:&error];
    if ([sumbyyearArray count] == 0) {
        SumbyYear *oneSumbyYear = [NSEntityDescription insertNewObjectForEntityForName:@"SumbyYear" inManagedObjectContext:_managedObjectContext];
        [oneSumbyYear setYear:year];
        [oneSumbyYear setMoney:moneyvalid];
    }
    else {
        SumbyYear *oneSumbyYear = [sumbyyearArray objectAtIndex:0];
        [oneSumbyYear setMoney:[moneyvalid decimalNumberByAdding:[oneSumbyYear money]]];
    }
    
    request = [[NSFetchRequest alloc] init];
    NSEntityDescription *sumbyMonth = [NSEntityDescription entityForName:@"SumbyMonth" inManagedObjectContext:_managedObjectContext];
    [request setEntity:sumbyMonth];
    predicate = [NSPredicate predicateWithFormat:@"(year == %@) AND (month == %@)", year, month];
    [request setPredicate:predicate];
    NSArray *sumbymonthArray = [_managedObjectContext executeFetchRequest:request error:&error];
    if ([sumbymonthArray count] == 0) {
        SumbyMonth *oneSumbyMonth = [NSEntityDescription insertNewObjectForEntityForName:@"SumbyMonth" inManagedObjectContext:_managedObjectContext];
        [oneSumbyMonth setYear:year];
        [oneSumbyMonth setMonth:month];
        [oneSumbyMonth setMoney:moneyvalid];
    }
    else {
        SumbyMonth *oneSumbyMonth = [sumbymonthArray objectAtIndex:0];
        [oneSumbyMonth setMoney:[moneyvalid decimalNumberByAdding:[oneSumbyMonth money]]];
    }
    
    request = [[NSFetchRequest alloc] init];
    NSEntityDescription *sumbyDay = [NSEntityDescription entityForName:@"SumbyDay" inManagedObjectContext:_managedObjectContext];
    [request setEntity:sumbyDay];
    predicate = [NSPredicate predicateWithFormat:@"(year == %@) AND (month == %@) AND (day == %@)", year, month, day];
    [request setPredicate:predicate];
    NSArray *sumbydayArray = [_managedObjectContext executeFetchRequest:request error:&error];
    if ([sumbydayArray count] == 0) {
        SumbyDay *oneSumbyDay = [NSEntityDescription insertNewObjectForEntityForName:@"SumbyDay" inManagedObjectContext:_managedObjectContext];
        [oneSumbyDay setYear:year];
        [oneSumbyDay setMonth:month];
        [oneSumbyDay setDay:day];
        [oneSumbyDay setMoney:moneyvalid];
    }
    else {
        SumbyDay *oneSumbyDay = [sumbydayArray objectAtIndex:0];
        [oneSumbyDay setMoney:[moneyvalid decimalNumberByAdding:[oneSumbyDay money]]];
    }
    
    request = [[NSFetchRequest alloc] init];
    NSEntityDescription *sumbyHour = [NSEntityDescription entityForName:@"SumbyHour" inManagedObjectContext:_managedObjectContext];
    [request setEntity:sumbyHour];
    predicate = [NSPredicate predicateWithFormat:@"(year == %@) AND (month == %@) AND (day == %@) AND (hour == %@)", year, month, day, hour];
    [request setPredicate:predicate];
    NSArray *sumbyhourArray = [_managedObjectContext executeFetchRequest:request error:&error];
    if ([sumbyhourArray count] == 0) {
        SumbyHour *oneSumbyHour = [NSEntityDescription insertNewObjectForEntityForName:@"SumbyHour" inManagedObjectContext:_managedObjectContext];
        [oneSumbyHour setYear:year];
        [oneSumbyHour setMonth:month];
        [oneSumbyHour setDay:day];
        [oneSumbyHour setHour:hour];
        [oneSumbyHour setMoney:moneyvalid];
    }
    else {
        SumbyHour *oneSumbyHour = [sumbyhourArray objectAtIndex:0];
        [oneSumbyHour setMoney:[moneyvalid decimalNumberByAdding:[oneSumbyHour money]]];
    }
    
    
    if (![_managedObjectContext save:&error]) {
        
    }
    
}

- (void)deleteSpentIssueWith:(SpentIssue *)oneSpentIssue
{
    [_managedObjectContext deleteObject:oneSpentIssue];
    NSNumber *year = [oneSpentIssue year];
    NSNumber *month = [oneSpentIssue month];
    NSNumber *day = [oneSpentIssue day];
    NSNumber *hour = [oneSpentIssue hour];
    NSDecimalNumber *moneyvalid = [oneSpentIssue money];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *sumbyYear = [NSEntityDescription entityForName:@"SumbyYear" inManagedObjectContext:_managedObjectContext];
    [request setEntity:sumbyYear];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"year == %@", year];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *sumbyyearArray = [_managedObjectContext executeFetchRequest:request error:&error];
    SumbyYear *oneSumbyYear = [sumbyyearArray objectAtIndex:0];
    [oneSumbyYear setMoney:[[oneSumbyYear money] decimalNumberBySubtracting:moneyvalid]];
    
    request = [[NSFetchRequest alloc] init];
    NSEntityDescription *sumbyMonth = [NSEntityDescription entityForName:@"SumbyMonth" inManagedObjectContext:_managedObjectContext];
    [request setEntity:sumbyMonth];
    predicate = [NSPredicate predicateWithFormat:@"(year == %@) AND (month == %@)", year, month];
    [request setPredicate:predicate];
    NSArray *sumbymonthArray = [_managedObjectContext executeFetchRequest:request error:&error];
    SumbyMonth *oneSumbyMonth = [sumbymonthArray objectAtIndex:0];
    [oneSumbyMonth setMoney:[[oneSumbyMonth money] decimalNumberBySubtracting:moneyvalid]];
    
    request = [[NSFetchRequest alloc] init];
    NSEntityDescription *sumbyDay = [NSEntityDescription entityForName:@"SumbyDay" inManagedObjectContext:_managedObjectContext];
    [request setEntity:sumbyDay];
    predicate = [NSPredicate predicateWithFormat:@"(year == %@) AND (month == %@) AND (day == %@)", year, month, day];
    [request setPredicate:predicate];
    NSArray *sumbydayArray = [_managedObjectContext executeFetchRequest:request error:&error];
    SumbyDay *oneSumbyDay = [sumbydayArray objectAtIndex:0];
    [oneSumbyDay setMoney:[[oneSumbyDay money] decimalNumberBySubtracting:moneyvalid]];
    
    request = [[NSFetchRequest alloc] init];
    NSEntityDescription *sumbyHour = [NSEntityDescription entityForName:@"SumbyHour" inManagedObjectContext:_managedObjectContext];
    [request setEntity:sumbyHour];
    predicate = [NSPredicate predicateWithFormat:@"(year == %@) AND (month == %@) AND (day == %@) AND (hour == %@)", year, month, day, hour];
    [request setPredicate:predicate];
    NSArray *sumbyhourArray = [_managedObjectContext executeFetchRequest:request error:&error];
    SumbyHour *oneSumbyHour = [sumbyhourArray objectAtIndex:0];
    [oneSumbyHour setMoney:[[oneSumbyHour money] decimalNumberBySubtracting:moneyvalid]];
    
    request = [[NSFetchRequest alloc] init];
    NSEntityDescription *spentIssue = [NSEntityDescription entityForName:@"SpentIssue" inManagedObjectContext:_managedObjectContext];
    [request setEntity:spentIssue];
    predicate = [NSPredicate predicateWithFormat:@"year == %@", year];
    [request setPredicate:predicate];
    NSArray *spentIssuebyYear = [_managedObjectContext executeFetchRequest:request error:&error];
    if ([spentIssuebyYear count] == 0) {
        [_managedObjectContext deleteObject:oneSumbyYear];
    }
    
    request = [[NSFetchRequest alloc] init];
    spentIssue = [NSEntityDescription entityForName:@"SpentIssue" inManagedObjectContext:_managedObjectContext];
    [request setEntity:spentIssue];
    predicate = [NSPredicate predicateWithFormat:@"(year == %@) AND (month == %@)", year, month];
    [request setPredicate:predicate];
    NSArray *spentIssuebyMonth = [_managedObjectContext executeFetchRequest:request error:&error];
    if ([spentIssuebyMonth count] == 0) {
        [_managedObjectContext deleteObject:oneSumbyMonth];
    }
    
    request = [[NSFetchRequest alloc] init];
    spentIssue = [NSEntityDescription entityForName:@"SpentIssue" inManagedObjectContext:_managedObjectContext];
    [request setEntity:spentIssue];
    predicate = [NSPredicate predicateWithFormat:@"(year == %@) AND (month == %@) AND (day == %@)", year, month, day];
    [request setPredicate:predicate];
    NSArray *spentIssuebyDay = [_managedObjectContext executeFetchRequest:request error:&error];
    if ([spentIssuebyDay count] == 0) {
        [_managedObjectContext deleteObject:oneSumbyDay];
    }
    
    request = [[NSFetchRequest alloc] init];
    spentIssue = [NSEntityDescription entityForName:@"SpentIssue" inManagedObjectContext:_managedObjectContext];
    [request setEntity:spentIssue];
    predicate = [NSPredicate predicateWithFormat:@"(year == %@) AND (month == %@) AND (day == %@) AND (hour == %@)", year, month, day, hour];
    [request setPredicate:predicate];
    NSArray *spentIssuebyHour = [_managedObjectContext executeFetchRequest:request error:&error];
    if ([spentIssuebyHour count] == 0) {
        [_managedObjectContext deleteObject:oneSumbyHour];
    }
    
    if (![_managedObjectContext save:&error]) {
        
    }

}

- (NSArray *)getSumbyYearList
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *sumbyYear = [NSEntityDescription entityForName:@"SumbyYear" inManagedObjectContext:_managedObjectContext];
    [request setEntity:sumbyYear];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"year" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    NSError *error = nil;
    NSArray *SumbyYearList = [_managedObjectContext executeFetchRequest:request error:&error];
    return SumbyYearList;
}

- (NSArray *)getSumbyMonthListWithYear:(NSNumber *)year
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *sumbyMonth = [NSEntityDescription entityForName:@"SumbyMonth" inManagedObjectContext:_managedObjectContext];
    [request setEntity:sumbyMonth];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"year == %@", year];
    [request setPredicate:predicate];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"month" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    NSError *error = nil;
    NSArray *SumbyMonthList = [_managedObjectContext executeFetchRequest:request error:&error];
    return SumbyMonthList;
}

- (NSArray *)getSumbyDayListWithYear:(NSNumber *)year Month:(NSNumber *)month
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *sumbyDay = [NSEntityDescription entityForName:@"SumbyDay" inManagedObjectContext:_managedObjectContext];
    [request setEntity:sumbyDay];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(year == %@) AND (month == %@)", year, month];
    [request setPredicate:predicate];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"day" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    NSError *error = nil;
    NSArray *SumbyDayList = [_managedObjectContext executeFetchRequest:request error:&error];
    return SumbyDayList;
}

- (NSArray *)getSumbyHourListWithYear:(NSNumber *)year Month:(NSNumber *)month Day:(NSNumber *)day
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *sumbyHour = [NSEntityDescription entityForName:@"SumbyHour" inManagedObjectContext:_managedObjectContext];
    [request setEntity:sumbyHour];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(year == %@) AND (month == %@) AND (day == %@)", year, month, day];
    [request setPredicate:predicate];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"hour" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    NSError *error = nil;
    NSArray *SumbyHourList = [_managedObjectContext executeFetchRequest:request error:&error];
    return SumbyHourList;
}

- (NSArray *)getSpentIssueListWithYear:(NSNumber *)year Month:(NSNumber *)month Day:(NSNumber *)day Hour:(NSNumber *)hour
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *spentIssue = [NSEntityDescription entityForName:@"SpentIssue" inManagedObjectContext:_managedObjectContext];
    [request setEntity:spentIssue];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(year == %@) AND (month == %@) AND (day == %@) AND (hour == %@)", year, month, day, hour];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *SpentIssueList = [_managedObjectContext executeFetchRequest:request error:&error];
    return SpentIssueList;
}

- (NSArray *)getDataWithDataPointsNumber:(NSInteger)dataPointsNumber InSumbyYearWithLastYear:(NSInteger)lastYear
{
    NSMutableArray *resultData = [[NSMutableArray alloc] init];
    int year = lastYear;
    for (int i = 0; i < dataPointsNumber; i++) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *sumbyYear = [NSEntityDescription entityForName:@"SumbyYear" inManagedObjectContext:_managedObjectContext];
        [request setEntity:sumbyYear];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"year == %i", year];
        [request setPredicate:predicate];
        NSError *error = nil;
        NSArray *sumbyyearArray = [_managedObjectContext executeFetchRequest:request error:&error];
        NSMutableArray *oneData = [[NSMutableArray alloc] init];
        [oneData addObject:[[NSNumber alloc] initWithInt:year]];
        if ([sumbyyearArray count] == 0) {
            [oneData addObject:[[NSNumber alloc] initWithDouble:0.0]];
        }
        else {
            SumbyYear *oneSumbyYear = [sumbyyearArray objectAtIndex:0];
            NSDecimalNumber *money = [oneSumbyYear money];
            [oneData addObject:(NSNumber *)money];
        }
        [resultData insertObject:[oneData copy] atIndex:0];
        year--;
    }
    return [resultData copy];
}

- (NSArray *)getDataWithDataPointsNumber:(NSInteger)dataPointsNumber InSumbyMonthWithLastYear:(NSInteger)lastYear LastMonth:(NSInteger)lastMonth
{
    NSMutableArray *resultData = [[NSMutableArray alloc] init];
    int year = lastYear;
    int month = lastMonth;
    for (int i = 0; i < dataPointsNumber; i++) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *sumbyMonth = [NSEntityDescription entityForName:@"SumbyMonth" inManagedObjectContext:_managedObjectContext];
        [request setEntity:sumbyMonth];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(year == %i) AND (month == %i)", year, month];
        [request setPredicate:predicate];
        NSError *error = nil;
        NSArray *sumbymonthArray = [_managedObjectContext executeFetchRequest:request error:&error];
        NSMutableArray *oneData = [[NSMutableArray alloc] init];
        [oneData addObject:[[NSNumber alloc] initWithInt:month]];
        if ([sumbymonthArray count] == 0) {
            [oneData addObject:[[NSNumber alloc] initWithDouble:0.0]];
        }
        else {
            SumbyMonth *oneSumbyMonth = [sumbymonthArray objectAtIndex:0];
            NSDecimalNumber *money = [oneSumbyMonth money];
            [oneData addObject:(NSNumber *)money];
        }
        [resultData insertObject:[oneData copy] atIndex:0];
        month--;
        if (month < 1) {
            year--;
            month = 12;
        }
    }
    return [resultData copy];
}

- (NSArray *)getDataWithDataPointsNumber:(NSInteger)dataPointsNumber InSumbyDayWithLastYear:(NSInteger)lastYear LastMonth:(NSInteger)lastMonth LastDay:(NSInteger)lastDay
{
    NSMutableArray *resultData = [[NSMutableArray alloc] init];
    int year = lastYear;
    int month = lastMonth;
    int day = lastDay;
    for (int i = 0; i < dataPointsNumber; i++) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *sumbyDay = [NSEntityDescription entityForName:@"SumbyDay" inManagedObjectContext:_managedObjectContext];
        [request setEntity:sumbyDay];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(year == %i) AND (month == %i) AND (day == %i)", year, month, day];
        [request setPredicate:predicate];
        NSError *error = nil;
        NSArray *sumbydayArray = [_managedObjectContext executeFetchRequest:request error:&error];
        NSMutableArray *oneData = [[NSMutableArray alloc] init];
        [oneData addObject:[[NSNumber alloc] initWithInt:day]];
        if ([sumbydayArray count] == 0) {
            [oneData addObject:[[NSNumber alloc] initWithDouble:0.0]];
        }
        else {
            SumbyDay *oneSumbyDay = [sumbydayArray objectAtIndex:0];
            NSDecimalNumber *money = [oneSumbyDay money];
            [oneData addObject:(NSNumber *)money];
        }
        [resultData insertObject:[oneData copy] atIndex:0];
        day--;
        if (day < 1) {
            month--;
            if (month < 1) {
                year--;
                month = 12;
            }
            day = [self numOfDaysInYear:year Month:month];
        }
    }
    return [resultData copy];
}

- (int)numOfDaysInYear:(int)year Month:(int)month
{
    int daysnum[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    if (month == 2 && (year % 400 == 0 || (year % 4 == 0 && year % 100 != 0))) {
        return 29;
    }
    else {
        return daysnum[month - 1];
    }
}

@end
