//
//  GraphViewController.m
//  How_Much_I_Spent
//
//  Created by Kangxing Fu on 9/19/14.
//  Copyright (c) 2014 Kangxing Fu. All rights reserved.
//

#import "GraphViewController.h"

@interface GraphViewController ()

@end

@implementation GraphViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    double totalX = [[UIScreen mainScreen] bounds].size.width;
    double totalY = [[UIScreen mainScreen] bounds].size.height;
    double originPointX = totalX * 0.075;
    double originPointY = totalY * 2.0 / 3.0;
    double axisXLength = totalX * 0.85;
    double axisYLength = totalY / 3.0;
    TrendGraphic *trendGraphic = [[TrendGraphic alloc] initWithOriginPointX:originPointX OriginPointY:originPointY AxisLengthX:axisXLength AxisLengthY:axisYLength PointsXArray:_pointsXArray PointsYArray:_pointsYArray];
    [self.view addSubview:[trendGraphic imageView]];
    
    UILabel *unitXLabel = [[UILabel alloc] initWithFrame:CGRectMake(totalX * 0.35, originPointY + 2.0 + axisXLength / 20.0, totalX * 0.3, axisXLength / 10.0)];
    [unitXLabel setText:_unitString];
    [unitXLabel setTextAlignment:NSTextAlignmentCenter];
    UIFont *fontX = [UIFont boldSystemFontOfSize:20];
    [unitXLabel setFont:fontX];
    [self.view addSubview:unitXLabel];
    
    UILabel *unitYLabel = [[UILabel alloc] initWithFrame:CGRectMake(1.0, originPointY - axisYLength - 25.0, 200.0, 20.0)];
    [unitYLabel setText:@"Spent Amount"];
    [unitYLabel setTextAlignment:NSTextAlignmentLeft];
    UIFont *fontY = [UIFont boldSystemFontOfSize:20];
    [unitYLabel setFont:fontY];
    [self.view addSubview:unitYLabel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
