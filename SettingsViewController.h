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


@interface SettingsViewController : UITableViewController {
   
    
    IBOutlet UISwitch *gravitySwitch;
    IBOutlet UISwitch *targetBreathingSwitch;
    IBOutlet UIButton *targetBreathingInfoButton;
    IBOutlet UILabel *connectionStatusLabel;
    IBOutlet UIButton *connectionStatusButton;
    IBOutlet UITextField *inhaleTimeField;
    IBOutlet UITextField *exhaleTimeField;
    IBOutlet UILabel *breathingRateLabel;
    IBOutlet UIActivityIndicatorView *indConnecting;
    IBOutlet UILabel *lblRSSI;
}




@end
