//
//  TargetBreathingSettingsViewController.m
//  MantraV1.2
//
//  Created by David Crow on 8/16/13.
//  Copyright (c) 2013 David Crow. All rights reserved.
//

#import "TargetBreathingSettingsViewController.h"
#import "User.h"

@interface TargetBreathingSettingsViewController ()

@end

@implementation TargetBreathingSettingsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableView addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;
    
    self.view.userInteractionEnabled = TRUE;
    [super viewDidLoad];
    inhaleTimeCell.hidden = YES;
    exhaleTimeCell.hidden = YES;
    breathingRateCell.hidden = YES;
    targetDepthCell.hidden =YES;
    
    [targetDepthSlider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)hideKeyboard{
    //update field values on keyboard hide
    
    [[User shared] setUserTargetInhaleTime:[NSNumber numberWithFloat:inhaleTimeField.text.floatValue]];
    [[User shared] setUserTargetExhaleTime:[NSNumber numberWithFloat:exhaleTimeField.text.floatValue]];
    [[User shared] setUserTargetDepth:[NSNumber numberWithFloat:1.0 - targetDepthSlider.value]];
    [self.view endEditing:YES];
}

- (IBAction)targetBreathingInfoButtonTouched:(id)sender{
    //sexy modal with instructions
}

- (IBAction)targetBreathingSwitchTouched:(id)sender
{
    if ([sender isOn]) {
        inhaleTimeCell.hidden = NO;
        exhaleTimeCell.hidden = NO;
        breathingRateCell.hidden = NO;
        targetDepthCell.hidden = NO;
    }
    else {
        inhaleTimeCell.hidden = YES;
        exhaleTimeCell.hidden = YES;
        breathingRateCell.hidden = YES;
        targetDepthCell.hidden = YES;
    }
}

-(BOOL)checkTextFieldValues{
    // change this to something like: [field checkFieldValuesAreBetween: 0 and: 1 withUnitsString: @"minutes"]
    if (([inhaleTimeField.text floatValue] < 0.5) || ([inhaleTimeField.text floatValue] > 300))
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"Please choose a inhale time between 0.5 and 300 seconds"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
    if (([exhaleTimeField.text floatValue] < 0.5) || ([exhaleTimeField.text floatValue] > 300))
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"Please choose a exhale time between 0.5 and 300 seconds"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
    if (([breathingRateField.text floatValue] < 0.2) || ([breathingRateField.text floatValue] > 240))
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"Please choose a breathing rate between 240 and 0.2 breaths per minute"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
    else return YES;
    
}

- (void)sliderChanged:(UISlider *)slider {
    targetDepthLabel.text = [NSString stringWithFormat:@"%1.0f%%", slider.value * 100];
    //update target breathingdepth
    [[User shared] setUserTargetDepth:[NSNumber numberWithFloat:targetDepthSlider.value]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
