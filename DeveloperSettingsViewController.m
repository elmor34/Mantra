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
    
    if ([self checkTextFieldValues] == YES && [self.fakeUserSwitch isOn]) {
        //hide keyboard
        [self.view endEditing:YES];
        //restart fake data generation with new values
        [[FakeDataGenerator shared] startFakeBreathingWithFakeInhaleTime:[NSNumber numberWithInteger:[fakeUserInhaleTimeTextField.text integerValue]] fakeExhaleTime:[NSNumber numberWithInteger:[fakeUserExhaleTimeTextField.text integerValue]] fakeMaxSens:[NSNumber numberWithInteger:[fakeUserMaxVolumeTextField.text integerValue]] fakeMinSens:[NSNumber numberWithInteger:[fakeUserMinVolumeTextField.text integerValue]]];
    }
    else{
    [self.view endEditing:YES];
    }
}

-(BOOL)checkTextFieldValues{
    
//    if (([self.fakeUserInhaleTimeTextField.text floatValue] < 0.5) || ([self.fakeUserInhaleTimeTextField.text floatValue] > 300))
//    {
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"Please choose a inhale time between 0.5 seconds and 300 seconds"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alertView show];
//        return NO;
//    }
//    if (([self.fakeUserExhaleTimeTextField.text floatValue] < 0.5) || ([self.fakeUserExhaleTimeTextField.text floatValue] > 300))
//    {
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"Please choose a exhale time between 0.5 seconds and 300 seconds"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alertView show];
//        return NO;
//    }
//    if (([self.fakeUserMinVolumeTextField.text floatValue] < [[User shared] userCalibratedMinSensorValue].floatValue) || ([self.fakeUserMinVolumeTextField.text floatValue] > [[User shared] userCalibratedMaxSensorValue].floatValue))
//    {
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"Please choose a minimum sensor value between %1.0f and %1.0f", [[User shared] userCalibratedMinSensorValue].floatValue, [[User shared] userCalibratedMaxSensorValue].floatValue] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alertView show];
//        return NO;
//    }
//    if (([self.fakeUserMaxVolumeTextField.text floatValue] < [[User shared] userCalibratedMinSensorValue].floatValue) || ([self.fakeUserMaxVolumeTextField.text floatValue] > [[User shared] userCalibratedMaxSensorValue].floatValue))
//    {
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"Please choose a maximum sensor value between %1.0f and %1.0f", [[User shared] userCalibratedMinSensorValue].floatValue, [[User shared] userCalibratedMaxSensorValue].floatValue] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alertView show];
//        return NO;
//    }
     return YES;

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
        
        
        [[FakeDataGenerator shared] startFakeBreathingWithFakeInhaleTime:[NSNumber numberWithInteger:[fakeUserInhaleTimeTextField.text integerValue]] fakeExhaleTime:[NSNumber numberWithInteger:[fakeUserExhaleTimeTextField.text integerValue]] fakeMaxSens:[NSNumber numberWithInteger:[fakeUserMaxVolumeTextField.text integerValue]] fakeMinSens:[NSNumber numberWithInteger:[fakeUserMinVolumeTextField.text integerValue]]];
    }
    if (self.fakeUserSwitch.isOn == NO) {
        [[User shared] setFakeDataIsOn:NO];
        NSLog(@"fake data OFF");
        [[FakeDataGenerator shared] stopFakeBreathing];
    }
    

}


@end
