//
//  SettingsViewController.h
//  MantraV1.2
//
//  Created by David Crow on 6/18/13.
//  Copyright (c) 2013 David Crow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BreathViewController.h"
#import "MantraUser.h"




@interface SettingsViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UILabel *connectionLabel;
@property (strong, nonatomic) IBOutlet UISwitch *gravityMeterSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *targetBreathingSwitch;
@property (strong, nonatomic) IBOutlet UIButton *targetBreathingInfoButton;
@property (strong, nonatomic) IBOutlet UITextField *inhaleTimeField;
@property (strong, nonatomic) IBOutlet UITextField *exhaleTimeField;
@property (strong, nonatomic) IBOutlet UITextField *breathingRateField;

@property (strong, nonatomic) IBOutlet UITableViewCell *targetBreathingCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *inhaleTimeCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *exhaleTimeCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *breathingRateCell;

- (IBAction)gravitySwitchTouched:(id)sender;
- (IBAction)targetBreathingSwitchTouched:(id)sender;
- (IBAction)targetBreathingInfoButtonTouched:(id)sender;

@end
