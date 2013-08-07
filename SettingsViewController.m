//
//  SettingsViewController.m
//  MantraV1.2
//
//  Created by David Crow on 6/18/13.
//  Copyright (c) 2013 David Crow. All rights reserved.
//

#import "SettingsViewController.h"
#import <QuartzCore/QuartzCore.h>




@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize breathingRateField,connectionLabel,gravityMeterSwitch,inhaleTimeField,inhaleTimeCell,exhaleTimeField,exhaleTimeCell,breathingRateCell,targetBreathingSwitch;


- (id)initWithStyle:(UITableViewStyle)style
{


    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)gravitySwitchTouched:(id)sender
{
    if ([sender isOn]) {
        [[MantraUser shared] setMeterGravityEnabled:YES];
        NSLog(@"Gravity!");
    }
    else{
        [[MantraUser shared] setMeterGravityEnabled:NO];
        NSLog(@"No Gravity!");
    }
}
- (void)hideKeyboard{
[self.view endEditing:YES];
}

- (IBAction)targetBreathingSwitchTouched:(id)sender
{
    if ([sender isOn]) {
        inhaleTimeCell.hidden = NO;
        exhaleTimeCell.hidden = NO;
        breathingRateCell.hidden = NO;
    }
    else {
        inhaleTimeCell.hidden = YES;
        exhaleTimeCell.hidden = YES;
        breathingRateCell.hidden = YES;
    }
}
- (IBAction)targetBreathingInfoButtonTouched:(id)sender{
//sexy modal with instructions
}

-(BOOL)checkTextFieldValues{
    
    if (([self.inhaleTimeField.text floatValue] < 0.5) || ([self.inhaleTimeField.text floatValue] > 300))
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"Please choose a inhale time between 0.5 seconds and 5 minutes"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
    if (([self.exhaleTimeField.text floatValue] < 0.5) || ([self.exhaleTimeField.text floatValue] > 300))
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"Please choose a exhale time between 0.5 seconds and 5 minutes"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
    if (([self.breathingRateField.text floatValue] < 0.2) || ([self.breathingRateField.text floatValue] > 240))
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"Please choose a breathing rate between 240 and 0.2 breaths per minute"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
    else return YES;
    
}

- (void)viewDidLoad
{
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableView addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;
    
    self.view.userInteractionEnabled = TRUE;
    [super viewDidLoad];
    inhaleTimeCell.hidden = YES;
    exhaleTimeCell.hidden = YES;
    breathingRateCell.hidden = YES;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
