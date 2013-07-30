//
//  DeveloperSettingsViewController.m
//  MantraV1.2
//
//  Created by David Crow on 7/21/13.
//  Copyright (c) 2013 David Crow. All rights reserved.
//

#import "DeveloperSettingsViewController.h"
#import "FakeMantraUser.h"

@interface DeveloperSettingsViewController ()

@end

@implementation DeveloperSettingsViewController

@synthesize fakeUserExhaleTimeTextField, fakeUserInhaleTimeTextField, fakeUserMaxVolumeTextField, fakeUserMinVolumeTextField,fakeUserSwitch;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fakeUserSwitchTouched:(id)sender{
    if (self.fakeUserSwitch.isOn == YES) {
        
        
        NSLog(@"fake data ON");
        //fix this to use real values from fakeuser
        
        [NSNumber numberWithInteger:[fakeUserInhaleTimeTextField.text integerValue]];
        
        
        [[FakeMantraUser shared] startFakeBreathingWithFakeUserInhaleTime:[NSNumber numberWithInteger:[fakeUserInhaleTimeTextField.text integerValue]] andFakeUserExhaleTime:[NSNumber numberWithInteger:[fakeUserExhaleTimeTextField.text integerValue]] fakeMaxVolume:[NSNumber numberWithInteger:[fakeUserMaxVolumeTextField.text integerValue]] andFakeUserMinVolume:[NSNumber numberWithInteger:[fakeUserMinVolumeTextField.text integerValue]]];
    }
    if (self.fakeUserSwitch.isOn == NO) {
        NSLog(@"fake data OFF");
        [[FakeMantraUser shared] stopFakeBreathing];
    }
    

}
@end
