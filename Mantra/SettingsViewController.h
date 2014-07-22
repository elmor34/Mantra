//
//  SettingsViewController.h
//  MantraV1.2
//
//  Created by David Crow on 6/18/13.
//  Copyright (c) 2013 David Crow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BreathViewController.h"
#import "User.h"




@interface SettingsViewController : UITableViewController

//might want to copy connection view controller and not have these be properties
@property (strong, nonatomic) IBOutlet UILabel *connectionLabel;
@property (strong, nonatomic) IBOutlet UISwitch *gravityMeterSwitch;


@property (strong, nonatomic) IBOutlet UITableViewCell *targetBreathingCell;


- (IBAction)gravitySwitchTouched:(id)sender;
- (IBAction)targetBreathingSwitchTouched:(id)sender;
- (IBAction)targetBreathingInfoButtonTouched:(id)sender;

//Update persistent user settings
-(void)updateUserSettings;

@end
