//
//  NextAddSpentIssueViewController.m
//  How_Much_I_Spent
//
//  Created by Kangxing Fu on 9/17/14.
//  Copyright (c) 2014 Kangxing Fu. All rights reserved.
//

#import "NextAddSpentIssueViewController.h"

@interface NextAddSpentIssueViewController ()

@end

@implementation NextAddSpentIssueViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"Input Spent"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addButtonAction:(id)sender {
    if ([[_amountTextField text] length] == 0) {
        UIAlertView *noMoneyAlert = [[UIAlertView alloc] initWithTitle:@"Invalid Amount" message:@"The amount value cannot be empty" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [noMoneyAlert show];
        return;
    }
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    if (![numberFormatter numberFromString:[_amountTextField text]]) {
        UIAlertView *invalidAlert = [[UIAlertView alloc] initWithTitle:@"Invalid Amount" message:@"The amount input should be numeric" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [invalidAlert show];
        return;
    }
    NSDecimalNumber *money = [NSDecimalNumber decimalNumberWithString:[_amountTextField text]];
    NSString *description = [_descriptionTextField text];
    [_dataSets addSpentIssueWithYear:_year Month:_month Day:_day Hour:_hour Money:money Describe:description];
    [_amountTextField setText:@""];
    [_descriptionTextField setText:@""];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notification" message:@"New information has been added" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

@end
