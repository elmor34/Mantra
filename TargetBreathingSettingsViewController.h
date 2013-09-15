//
//  TargetBreathingSettingsViewController.h
//  MantraV1.2
//
//  Created by David Crow on 8/16/13.
//  Copyright (c) 2013 David Crow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TargetBreathingSettingsViewController : UITableViewController{

    IBOutlet UITableViewCell *targetDepthCell;
    IBOutlet UITableViewCell *exhaleTimeCell;
    IBOutlet UITableViewCell *inhaleTimeCell;
    IBOutlet UITableViewCell *breathingRateCell;
    
    IBOutlet UISwitch *targetBreathingSwitch;
    IBOutlet UIButton *targetBreathingInfoButton;
    
    IBOutlet UILabel *inhaleTimeLabel;
    IBOutlet UILabel *exhaleTimeLabel;
    IBOutlet UILabel *breathingRateLabel;
    IBOutlet UILabel *targetDepthLabel;
    
    IBOutlet UITextField *breathingRateField;
    IBOutlet UITextField *inhaleTimeField;
    IBOutlet UITextField *exhaleTimeField;
 
    IBOutlet UISlider *targetDepthSlider;

}

- (IBAction)targetBreathingInfoButtonTouched:(id)sender;
- (IBAction)targetBreathingSwitchTouched:(id)sender;

//Manage user settings from NSUserDefaults
-(void)saveUserSettings;
-(void)loadUserSettings;

@end
