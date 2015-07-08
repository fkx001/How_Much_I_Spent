//
//  TrendGraphic.m
//  How_Much_I_Spent
//
//  Created by Kangxing Fu on 9/19/14.
//  Copyright (c) 2014 Kangxing Fu. All rights reserved.
//

#import "TrendGraphic.h"

@implementation TrendGraphic
{
    double originPointX;
    double originPointY;
    double axisLengthX;
    double axisLengthY;
    NSArray *pointsXArray;
    NSArray *pointsYArray;
    CGContextRef contextRef;
    CGColorRef black;
    int numOfMarkOnAxisY;
}

- (id)initWithOriginPointX:(double)paraOriginPointX OriginPointY:(double)paraOriginPointY AxisLengthX:(double)paraAxisLengthX AxisLengthY:(double)paraAxisLengthY PointsXArray:(NSArray *)paraPointsXArray PointsYArray:(NSArray *)paraPointsYArray
{
    self = [super init];
    if (self) {
        numOfMarkOnAxisY = 4;
        originPointX = paraOriginPointX;
        originPointY = paraOriginPointY;
        axisLengthX = paraAxisLengthX;
        axisLengthY = paraAxisLengthY;
        pointsXArray = paraPointsXArray;
        pointsYArray = paraPointsYArray;
        UIGraphicsBeginImageContext([[UIScreen mainScreen] bounds].size);
        contextRef = UIGraphicsGetCurrentContext();
        black = [[UIColor blackColor] CGColor];
        
        NSMutableArray *coordinateXMutableArray = [[NSMutableArray alloc] init];
        NSMutableArray *coordinateYMutableArray = [[NSMutableArray alloc] init];
        double intervalX = axisLengthX / (double)([pointsXArray count] - 1);
        for (int i = 0; i < [pointsXArray count]; i++) {
            NSNumber *coordinateX = [[NSNumber alloc] initWithDouble:(originPointX + (double)i * intervalX)];
            [coordinateXMutableArray addObject:coordinateX];
        }
        double maxMoney = 0.0;
        for (int i = 0; i < [pointsYArray count]; i++) {
            NSNumber *moneyNum = [pointsYArray objectAtIndex:i];
            double money = [moneyNum doubleValue];
            if (money > maxMoney) {
                maxMoney = money;
            }
        }
        if (maxMoney == 0.0) {
            maxMoney = 1.0;
        }
        double intervalPerMoney = axisLengthY / maxMoney;
        for (int i = 0; i < [pointsYArray count]; i++) {
            NSNumber *moneyNum = [pointsYArray objectAtIndex:i];
            double money = [moneyNum doubleValue];
            NSNumber *coordinateY = [[NSNumber alloc] initWithDouble:(originPointY - money * intervalPerMoney)];
            [coordinateYMutableArray addObject:coordinateY];
        }
        [self drawAxisWithCoordinateXArray:[coordinateXMutableArray copy] CoordinateYArray:[coordinateYMutableArray copy]];
        [self drawLinesWithCoordinateXArray:[coordinateXMutableArray copy] CoordinateYArray:[coordinateYMutableArray copy]];
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        _imageView = [[UIImageView alloc] initWithImage:image];
        
        for (int i = 0; i < [pointsXArray count]; i++) {
            NSNumber *pointsX = [pointsXArray objectAtIndex:i];
            double leftPosition = [[coordinateXMutableArray objectAtIndex:i] doubleValue] - intervalX / 2.0;
            double topPosition = originPointY + 2.0;
            double labelViewWidth = intervalX;
            double labelViewHeight = axisLengthX / 20.0;
            CGRect rect = CGRectMake(leftPosition, topPosition, labelViewWidth, labelViewHeight);
            UILabel *label = [[UILabel alloc] initWithFrame:rect];
            [label setText:[pointsX stringValue]];
            [label setTextAlignment:NSTextAlignmentCenter];
            UIFont *font = [UIFont boldSystemFontOfSize:axisLengthX / 40.0];
            [label setFont:font];
            [_imageView addSubview:label];
        }
        
        for (int i = 0; i < numOfMarkOnAxisY; i++) {
            double y = originPointY - axisLengthY / numOfMarkOnAxisY * (i + 1);
            double labelViewHeight = axisLengthX / 20.0;
            double labelViewWidth = originPointX - 2.0;
            double leftPosition = 0.0;
            double topPosition = y - labelViewHeight / 2.0;
            CGRect rect = CGRectMake(leftPosition, topPosition, labelViewWidth, labelViewHeight);
            UILabel *label = [[UILabel alloc] initWithFrame:rect];
            double ynum = maxMoney / numOfMarkOnAxisY * (i + 1);
            [label setText:[[[NSNumber alloc] initWithDouble:ynum] stringValue]];
            [label setTextAlignment:NSTextAlignmentRight];
            UIFont *font = [UIFont boldSystemFontOfSize:axisLengthX / 40.0];
            [label setFont:font];
            [_imageView addSubview:label];

        }
    }
    return self;
}

- (void)drawLinesWithCoordinateXArray:(NSArray *)coordinateXArray CoordinateYArray:(NSArray *)coordinateYArray
{
    if ([coordinateXArray count] == 0) {
        return;
    }
    CGContextMoveToPoint(contextRef, [[coordinateXArray objectAtIndex:0] doubleValue], [[coordinateYArray objectAtIndex:0] doubleValue]);
    for (int i = 1; i < [coordinateXArray count]; i++) {
        CGContextAddLineToPoint(contextRef, [[coordinateXArray objectAtIndex:i] doubleValue], [[coordinateYArray objectAtIndex:i] doubleValue]);
    }
    CGContextSetStrokeColorWithColor(contextRef, black);
    CGContextStrokePath(contextRef);
}

- (void)drawAxisWithCoordinateXArray:(NSArray *)coordinateXArray CoordinateYArray:(NSArray *)coordinateYArray
{
    CGContextMoveToPoint(contextRef, originPointX, originPointY);
    CGContextAddLineToPoint(contextRef, originPointX + axisLengthX, originPointY);
    CGContextSetStrokeColorWithColor(contextRef, black);
    CGContextStrokePath(contextRef);
    CGContextMoveToPoint(contextRef, originPointX, originPointY);
    CGContextAddLineToPoint(contextRef, originPointX, originPointY - axisLengthY);
    CGContextSetStrokeColorWithColor(contextRef, black);
    CGContextStrokePath(contextRef);
    for (int i = 0; i < [coordinateXArray count]; i++) {
        double coordinateX = [[coordinateXArray objectAtIndex:i] doubleValue];
        CGContextMoveToPoint(contextRef, coordinateX, originPointY);
        CGContextAddLineToPoint(contextRef, coordinateX, originPointY - 5);
        CGContextSetStrokeColorWithColor(contextRef, black);
        CGContextStrokePath(contextRef);
    }
    for (int i = 0; i < numOfMarkOnAxisY; i++) {
        double coordinateY = axisLengthY / numOfMarkOnAxisY * (i + 1);
        CGContextMoveToPoint(contextRef, originPointX, originPointY - coordinateY);
        CGContextAddLineToPoint(contextRef, originPointX + 5, originPointY - coordinateY);
        CGContextSetStrokeColorWithColor(contextRef, black);
        CGContextStrokePath(contextRef);
    }
}

@end
