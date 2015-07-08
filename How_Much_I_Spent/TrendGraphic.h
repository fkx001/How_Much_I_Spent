//
//  TrendGraphic.h
//  How_Much_I_Spent
//
//  Created by Kangxing Fu on 9/19/14.
//  Copyright (c) 2014 Kangxing Fu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrendGraphic : NSObject

@property (retain, nonatomic) UIImageView *imageView;

- (id)initWithOriginPointX:(double)paraOriginPointX OriginPointY:(double)paraOriginPointY AxisLengthX:(double)paraAxisLengthX AxisLengthY:(double)paraAxisLengthY PointsXArray:(NSArray *)paraPointsXArray PointsYArray:(NSArray *)paraPointsYArray;

@end
