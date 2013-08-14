//
//  DeveloperSettingsViewController.m
//  MantraV1.2
//
//  Created by David Crow on 7/21/13.
//  Copyright (c) 2013 David Crow. All rights reserved.
//

#import "DeveloperSettingsViewController.h"
#import "FakeDataGenerator.h"
#import "User.h"

@interface DeveloperSettingsViewController ()

@end

@implementation DeveloperSettingsViewController

@synthesize fakeUserExhaleTimeTextField, fakeUserInhaleTimeTextField, fakeUserMaxVolumeTextField, fakeUserMinVolumeTextField,fakeUserSwitch;

- (void)viewDidLoad
{
    //Propertly load settings
    if ([[User shared] fakeDataIsOn] == YES) {
        [fakeUserSwitch setOn:YES];
    }
    else [fakeUserSwitch setOn:NO];
    
    self.view.userInteractionEnabled = TRUE;
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;
    
    [super viewDidLoad];	
}

- (void)hideKeyboard{

    if ([self checkTextFieldValues] == YES) {
         [self.view endEditing:YES];
    }
   
}

-(BOOL)checkTextFieldValues{
    
    if (([self.fakeUserInhaleTimeTextField.text floatValue] < 0.5) || ([self.fakeUserInhaleTimeTextField.text floatValue] > 300))
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"Please choose a inhale time between 0.5 seconds and 5 minutes"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
    if (([self.fakeUserExhaleTimeTextField.text floatValue] < 0.5) || ([self.fakeUserInhaleTimeTextField.text floatValue] > 300))
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"Please choose a exhale time between 0.5 seconds and 5 minutes"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
    if (([self.fakeUserMaxVolumeTextField.text floatValue] < 500) || ([self.fakeUserInhaleTimeTextField.text floatValue] > 9999))
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"Please choose a maximum volume between 5 percent and 100 percent lung capacity"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
    if (([self.fakeUserMinVolumeTextField.text floatValue] < 500) || ([self.fakeUserInhaleTimeTextField.text floatValue] > 9999))
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"Please choose a minimum volume between 5 percent and 100 percent lung capacity"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
    else return YES;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)fakeUserSwitchTouched:(id)sender{
    if (self.fakeUserSwitch.isOn == YES) {
        [[User shared] setFakeDataIsOn:YES];
        
        NSLog(@"fake data ON");
        //fix this to use real values from fakeuser
        
        [NSNumber numberWithInteger:[fakeUserInhaleTimeTextField.text integerValue]];
        
        
        [[FakeDataGenerator shared] startFakeBreathingWithFakeUserInhaleTime:[NSNumber numberWithInteger:[fakeUserInhaleTimeTextField.text integerValue]] andFakeUserExhaleTime:[NSNumber numberWithInteger:[fakeUserExhaleTimeTextField.text integerValue]] fakeMaxVolume:[NSNumber numberWithInteger:[fakeUserMaxVolumeTextField.text integerValue]] andFakeUserMinVolume:[NSNumber numberWithInteger:[fakeUserMinVolumeTextField.text integerValue]]];
    }
    if (self.fakeUserSwitch.isOn == NO) {
        [[User shared] setFakeDataIsOn:NO];
        NSLog(@"fake data OFF");
        [[FakeDataGenerator shared] stopFakeBreathing];
    }
    

}


@end
