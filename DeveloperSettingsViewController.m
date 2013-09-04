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

-(void)updateFakeDataGeneratorProperties{
    
    //Set all the necessary FakeDataGenerator properties
    [[FakeDataGenerator shared] setFakeUserInhaleTime:[self.fakeUserInhaleTimeTextField.text integerValue]];
    [[FakeDataGenerator shared] setFakeUserExhaleTime:[self.fakeUserExhaleTimeTextField.text integerValue]];
    [[FakeDataGenerator shared] setFakeUserCurrentMaxSensorValue:[self.fakeUserMaxSensorTextField.text floatValue]];
    [[FakeDataGenerator shared] setFakeUserCurrentMinSensorValue:[self.fakeUserMinSensorTextField.text floatValue]];
    [[FakeDataGenerator shared] setFakeUserCurrentMaxVolumeValue:[self.fakeUserMaxVolumeTextField.text floatValue]];
    [[FakeDataGenerator shared] setFakeUserCurrentMinVolumeValue:[self.fakeUserMinVolumeTextField.text floatValue]];
    [[FakeDataGenerator shared] setFakeUserGlobalMaxSensorValue:[self.fakeUserGlobalMaxSensorTextField.text floatValue]];
    [[FakeDataGenerator shared] setFakeUserGlobalMinSensorValue:[self.fakeUserGlobalMinSensorTextField.text floatValue]];
    [[FakeDataGenerator shared] setFakeUserGlobalMaxVolume:[self.fakeUserGlobalMaxVolumeTextField.text floatValue]];
    [[FakeDataGenerator shared] setFakeUserGlobalMinVolume:[self.fakeUserGlobalMinVolumeTextField.text floatValue]];
}

- (void)hideKeyboard{
    
    if ([self checkTextFieldValues] == YES && [self.fakeUserSwitch isOn]) {
        //hide keyboard
        [self.view endEditing:YES];
        
        //restart fake data generation with updated values pulled from the UI
        [self updateFakeDataGeneratorProperties];
        [[FakeDataGenerator shared] startFakeBreathing];

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
        [self updateFakeDataGeneratorProperties];
        [[FakeDataGenerator shared] startFakeBreathing];
    }
    if (self.fakeUserSwitch.isOn == NO) {
        [[User shared] setFakeDataIsOn:NO];
        NSLog(@"fake data OFF");
        [[FakeDataGenerator shared] stopFakeBreathing];
    }
}

@end
