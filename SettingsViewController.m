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
    NSLog(@"WOOOOOO!");
}

- (IBAction)targetBreathingSwitchTouched:(id)sender

{

}
- (IBAction)targetBreathingInfoButtonTouched:(id)sender{

}

- (void)viewDidLoad
{
    [super viewDidLoad];

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
