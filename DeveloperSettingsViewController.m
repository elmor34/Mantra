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
    if (self.fakeUserSwitch.isOn) {
        
        
        
        //fix this to use real values from fakeuser
        [[FakeMantraUser shared] startFakeBreathingWithFakeBreathingStats:10 exhaleRate:10 fakeUserMaxVolume:10 fakeUserMinVolume:10];
    }
}
@end
