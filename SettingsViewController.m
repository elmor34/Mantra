//
//  SettingsViewController.m
//  MantraV1.2
//
//  Created by David Crow on 6/18/13.
//  Copyright (c) 2013 David Crow. All rights reserved.
//

#import "SettingsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MantraUser.h"
#import "MantraUser.m"


@interface SettingsViewController ()

@end

@implementation SettingsViewController

//@synthesize connectionLabel, meterGravitySwitch, targetBreathingSwitch, inhaleTimeField, exhaleTimeField, breathingRateField, targetBreathingSwitch, exhaleTimeCell, breathingRateCell;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

//- (IBOutlet)toggleGravity:
//{
//    if (state == YES) {
//        [self.shape1View startGravity];
//    }
//    else{
//        [self.shape1View stopGravity];
//    }
//    
//    //    for (DPMeterView *shapeView in [self shapeViews]) {
//    //        if ([self.gravitySwitch isOn] && ![shapeView isGravityActive]) {
//    //            [shapeView startGravity];
//    //        } else if (![self.gravitySwitch isOn] && [shapeView isGravityActive]) {
//    //            [shapeView stopGravity];
//    //        }
//    //    }
//}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
