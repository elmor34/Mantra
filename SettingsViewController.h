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
#import "MantraUser.m"
#import "CustomSettingsCell.h"

@interface SettingsViewController : UITableViewController

@property (strong, nonatomic) CustomSettingsCell *connectionCell;
@property (strong, nonatomic) IBOutlet CustomSettingsCell *meterGravityCell;
@property (strong, nonatomic) CustomSettingsCell *targetBreathingCell;
@property (strong, nonatomic) CustomSettingsCell *inhaleTimeCell;
@property (strong, nonatomic) CustomSettingsCell *exhaleTimeCell;
@property (strong, nonatomic) CustomSettingsCell *breathingRateCell;


@end
