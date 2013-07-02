//
//  FirstViewController.h
//  MantraV1.2
//
//  Created by David Crow on 6/12/13.
//  Copyright (c) 2013 David Crow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MantraUser.h"
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



//Debug properties
@property (strong, nonatomic) IBOutlet UILabel *lungValLabel;
@property (strong, nonatomic) IBOutlet UILabel *sensorValLabel;
@property (strong, nonatomic) IBOutlet UILabel *connectionStrengthLabel;
@property (strong, nonatomic) IBOutlet UILabel *connectedLabel;


- (IBAction)testButton:(id)sender;
- (void)setGravity:(BOOL)state;
- (void)sensorValueChanged:(NSNotification *)notification;

@end
