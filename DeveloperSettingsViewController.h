//
//  DeveloperSettingsViewController.h
//  MantraV1.2
//
//  Created by David Crow on 7/21/13.
//  Copyright (c) 2013 David Crow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeveloperSettingsViewController : UIViewController


    @property (strong, nonatomic) IBOutlet UITextField *fakeUserInhaleRateTextField;
    @property (strong, nonatomic) IBOutlet UITextField *fakeUserExhaleRateTextField;
    @property (strong, nonatomic) IBOutlet UITextField *fakeUserMaxVolumeTextField;
    @property (strong, nonatomic) IBOutlet UITextField *fakeUserMinVolumeTextField;
    @property (strong, nonatomic) IBOutlet UISwitch *fakeUserSwitch;
    
    - (IBAction)fakeUserSwitchTouched:(id)sender;
    
    
@end
