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

- (void)viewDidLoad
{
    //Propertly load settings
    if ([[User shared] fakeDataIsOn] == YES) {
        [self.fakeUserSwitch setOn:YES];
    }
    else [self.fakeUserSwitch setOn:NO];
    
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
        
        [self.fakeUserInhaleTimeTextField.text integerValue];
        [self.fakeUserExhaleTimeTextField.text integerValue];
        [self.fakeUserMaxSensorTextField.text integerValue];
        [self.fakeUserMinSensorTextField.text integerValue];
        [self.fakeUserMaxVolumeTextField.text floatValue];
        [self.fakeUserMinVolumeTextField.text floatValue];
        
        fakeUserGlobalMaxSensorValue; //value between 0 and 9999 (usually 700-800)
        fakeUserGlobalMinSensorValue; //value between 0 and 9999 (usually 700-800)
        fakeUserGlobalMaxVolume;//value between 0 and 1
        fakeUserGlobalMinVolume;//value between 0 and 1
        
        [[FakeDataGenerator shared] startFakeBreathing];
        
      [[FakeDataGenerator shared] startFakeBreathingWithFakeInhaleTime:[NSNumber numberWithInteger:[self.fakeUserInhaleTimeTextField.text integerValue]] fakeExhaleTime:[NSNumber numberWithInteger:[self.fakeUserExhaleTimeTextField.text integerValue]] fakeMaxSens:[NSNumber numberWithInteger:[self.fakeUserMaxSensorTextField.text integerValue]] fakeMinSens:[NSNumber numberWithInteger:[self.fakeUserMinSensorTextField.text integerValue]] fakeMaxVol:[NSNumber numberWithInteger:[self.fakeUserMaxVolumeTextField.text floatValue]] fakeMinVol:[NSNumber numberWithInteger:[self.fakeUserMinVolumeTextField.text floatValue]]];
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
        
        [NSNumber numberWithInteger:[self.fakeUserInhaleTimeTextField.text integerValue]];
        
        //this is so ugly it hurts
        [[FakeDataGenerator shared] startFakeBreathingWithFakeInhaleTime:[NSNumber numberWithInteger:[self.fakeUserInhaleTimeTextField.text integerValue]] fakeExhaleTime:[NSNumber numberWithInteger:[self.fakeUserExhaleTimeTextField.text integerValue]] fakeMaxSens:[NSNumber numberWithInteger:[self.fakeUserMaxSensorTextField.text integerValue]] fakeMinSens:[NSNumber numberWithInteger:[self.fakeUserMinSensorTextField.text integerValue]] fakeMaxVol:[NSNumber numberWithInteger:[self.fakeUserMaxVolumeTextField.text floatValue]] fakeMinVol:[NSNumber numberWithInteger:[self.fakeUserMinVolumeTextField.text floatValue]]];
    }
    if (self.fakeUserSwitch.isOn == NO) {
        [[User shared] setFakeDataIsOn:NO];
        NSLog(@"fake data OFF");
        [[FakeDataGenerator shared] stopFakeBreathing];
    }
    

}


@end
