//
//  CustomSettingsCell.h
//  MantraV1.2
//
//  Created by David Crow on 6/20/13.
//  Copyright (c) 2013 David Crow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomSettingsCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *connectionLabel;

@property (strong, nonatomic) IBOutlet UISwitch *meterGravitySwitch;
@property (strong, nonatomic) IBOutlet UISwitch *targetBreathingSwitch;
@property (strong, nonatomic) IBOutlet UITextField *inhaleTimeField;
@property (strong, nonatomic) IBOutlet UITextField *exhaleTimeField;
@property (strong, nonatomic) IBOutlet UITextField *breathingRateField;

@property (strong, nonatomic) IBOutlet UIButton *targetBreathingInfoButton;

@property (strong, nonatomic) IBOutlet UITableViewCell *inhaleTimeCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *exhaleTimeCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *breathingRateCell;


@end
