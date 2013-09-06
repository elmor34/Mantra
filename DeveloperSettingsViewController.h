//
//  DeveloperSettingsViewController.h
//  MantraV1.2
//
//  Created by David Crow on 7/21/13.
//  Copyright (c) 2013 David Crow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeveloperSettingsViewController : UITableViewController


    @property (strong, nonatomic) IBOutlet UITextField *fakeUserInhaleTimeTextField;
    @property (strong, nonatomic) IBOutlet UITextField *fakeUserExhaleTimeTextField;
    @property (strong, nonatomic) IBOutlet UITextField *fakeUserMaxStretchTextField;
    @property (strong, nonatomic) IBOutlet UITextField *fakeUserMinStretchTextField;
    @property (strong, nonatomic) IBOutlet UITextField *fakeUserMaxVolumeTextField;
    @property (strong, nonatomic) IBOutlet UITextField *fakeUserMinVolumeTextField;
    @property (strong, nonatomic) IBOutlet UITextField *fakeUserGlobalMaxStretchTextField;
    @property (strong, nonatomic) IBOutlet UITextField *fakeUserGlobalMinStretchTextField;
    @property (strong, nonatomic) IBOutlet UITextField *fakeUserGlobalMaxVolumeTextField;
    @property (strong, nonatomic) IBOutlet UITextField *fakeUserGlobalMinVolumeTextField;
    @property (strong, nonatomic) IBOutlet UISwitch *fakeUserSwitch;

    -(IBAction)fakeUserSwitchTouched:(id)sender;
    -(void)updateFakeDataGeneratorProperties;

    
@end
