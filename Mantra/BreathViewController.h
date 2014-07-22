//
//  FirstViewController.h
//  MantraV1.2
//
//  Created by David Crow on 6/12/13.
//  Copyright (c) 2013 David Crow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "DataGenerator.h"
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
@property (strong, nonatomic) UIColor *lungColor;
@property (strong, nonatomic) IBOutlet UILabel *rawLabel;
@property (strong, nonatomic) IBOutlet UILabel *volLabel;
@property (strong, nonatomic) IBOutlet UILabel *breathCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *cMaxVolLabel;
@property (strong, nonatomic) IBOutlet UILabel *cMinVolLabel;
@property (strong, nonatomic) IBOutlet UILabel *maxSensLabel;
@property (strong, nonatomic) IBOutlet UILabel *minSensLabel;
@property (strong, nonatomic) IBOutlet UIImageView *developerMenu;
@property (strong, nonatomic) IBOutlet UILabel *coherenceLabel;
@property (strong, nonatomic) IBOutlet UILabel *coherenceDeltaLabel;


-(void)setGravity;
- (void)sensorValueChanged:(NSNotification *)notification;
-(UIColor*)setLungColor;
-(int)calculateTargetCoherence;

@end
