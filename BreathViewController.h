//
//  FirstViewController.h
//  MantraV1.2
//
//  Created by David Crow on 6/12/13.
//  Copyright (c) 2013 David Crow. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DPMeterView.h"


@class CalibrationViewController;
@class DPMeterView;
@class QBFlatButton;

@interface BreathViewController : UIViewController {
    
    CalibrationViewController * semiVC;
    
}





//@property (strong, nonatomic) IBOutlet UINavigationBar *navigationBar;
//DPMeterView

@property (strong, nonatomic) IBOutlet DPMeterView *shape1View;
@property float meterLevel;

@property (strong, nonatomic) IBOutlet UILabel *orientationLabel;
@property (strong, nonatomic) IBOutlet UISlider *orientationSlider;
@property (strong, nonatomic) IBOutlet UISwitch *gravitySwitch;

//Debug properties
@property (strong, nonatomic) UILabel *rawDataLabel;
@property (strong, nonatomic) UILabel *connectionStrengthLabel;


- (IBAction)minus:(id)sender;
- (IBAction)add:(id)sender;
- (IBAction)orientationHasChanged:(id)sender;
- (IBAction)toggleGravity:(id)sender;
- (IBAction)testButton:(id)sender;
- (void)toggleGravity;
- (void)sensorValueChanged:(NSNotification *)notification;

@end
