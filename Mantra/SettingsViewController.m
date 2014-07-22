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
        [[User shared] setMeterGravityIsOn:YES];
        NSLog(@"Gravity!");
    }
    else{
        [[User shared] setMeterGravityIsOn:NO];
        NSLog(@"No Gravity!");
    }
}
- (void)hideKeyboard{
    //update field values on keyboard hide
   [self.view endEditing:YES];
}


- (void)viewDidLoad
{
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableView addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;
    
    self.view.userInteractionEnabled = YES;
    [super viewDidLoad];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


@end
