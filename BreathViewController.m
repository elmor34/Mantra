//
//  FirstViewController.m
//  MantraV1.2
//
//  Created by David Crow on 6/12/13.
//  Copyright (c) 2013 David Crow. All rights reserved.
//

#import "BreathViewController.h"
#import "SettingsViewController.h"
#import "User.h"
#import "DPMeterView.h"
#import "UIBezierPath+BasicShapes.h"

@interface BreathViewController ()
//@property (nonatomic, strong) NSTimer* animationTimer;
@end

@implementation BreathViewController

@synthesize meterLevel;


- (void)viewDidLoad
{
    [super viewDidLoad];
    meterLevel = 0.0;//default meter level is 0
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(sensorValueChanged:)
     name:@"sensorValueChanged"
     object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(sensorValueChanged:)
     name:@"fakeSensorValueChanged"
     object:nil];
    

    
    //Set initial apperance (white)
    [[DPMeterView appearance] setTrackTintColor:[UIColor colorWithRed:255/255.f green:0/255.f blue:0/255.f alpha:0.7f]];
    [[DPMeterView appearance] setProgressTintColor:[UIColor colorWithRed:255/255.f green:255/255.f blue:255/255.f alpha:0.5f]];
    
    //Lungs shape
    [self.shape1View setShape:[UIBezierPath heartShape:self.shape1View.frame].CGPath];
    self.shape1View.progressTintColor = [UIColor colorWithRed:255/255.f green:255/255.f blue:255/255.f alpha:0.5f];
    
    
    [[User shared] scanForPeripherals:self];
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.shape1View setHidden:NO];
    
    
    //apply gravity setting last selected in the settings screen
    [self setGravity];
    [self loadDevLabels];
}

-(void)loadDevLabels{
    
    if ([[User shared] fakeDataIsOn]) {
        self.breathCountLabel.hidden = NO;
        self.lungValLabel.hidden = NO;
        self.rawLabel.hidden = NO;
        self.cMaxVolLabel.hidden = NO;
        self.cMinVolLabel.hidden = NO;
        self.maxSensLabel.hidden = NO;
        self.minSensLabel.hidden = NO;

    }
    else {
        self.breathCountLabel.hidden = YES;
        self.lungValLabel.hidden = YES;
        self.rawLabel.hidden = YES;
        self.cMaxVolLabel.hidden = YES;
        self.cMinVolLabel.hidden = YES;
        self.maxSensLabel.hidden =YES;
        self.minSensLabel.hidden = YES;
    }
}

- (NSArray *)shapeViews
{
    NSMutableArray *shapeViews = [NSMutableArray array];
    
    if (self.shape1View && [self.shape1View isKindOfClass:[DPMeterView class]])
        [shapeViews addObject:self.shape1View];
    
    
    return [NSArray arrayWithArray:shapeViews];
}

- (void)updateProgressWithDelta:(CGFloat)delta animated:(BOOL)animated
{
    NSArray *shapeViews = [self shapeViews];
    for (DPMeterView *shapeView in shapeViews) {
        if (delta < 0) {
            [shapeView minus:fabs(delta) animated:animated];
        } else {
            [shapeView add:fabs(delta) animated:animated];
        }
    }
    
    /*self.title = [NSString stringWithFormat:@"%.2f%%",
                  [(DPMeterView *)[shapeViews lastObject] progress]*100];*/
}


- (void)fakeSensorValueChanged:(NSNotification *)notification{
    NSLog(@"fake sensor notifcation received, fakeSensorValueChanged called!");

}


- (void)sensorValueChanged:(NSNotification *)notification{
    NSLog(@"sensor notifcation received, sensorValueChanged called!");
    //Set the shape view to match the sensor value 
    [self.shape1View setProgress:(1 -[[User shared] userCurrentLungVolume]) animated:YES]; //Inverted (more air is less fill)
    
    NSString *sensorString = [NSString stringWithFormat: @"Raw: %1.1hu", [[User shared] rawStretchSensorValue]];
    self.rawLabel.text = sensorString;
    
    
    NSString *lungString = [NSString stringWithFormat: @"Vol: %1.0f%%", [[User shared] userCurrentLungVolume] * 100];
    self.lungValLabel.text = lungString;
   
//    NSString *bleConnected = [NSString stringWithFormat:@"%hhd", [[User shared] bleIsConnected]];
//    self.connectedLabel.text = bleConnected;
    
    NSString *breathCount = [NSString stringWithFormat:@"%1.1f", [[User shared] userBreathCount]];
    self.breathCountLabel.text = breathCount;
    
    NSString *cMaxVol = [NSString stringWithFormat:@"SMax: %1.2f", [[User shared] userCalibratedMaxVolume].doubleValue];
    self.cMaxVolLabel.text = cMaxVol;
    
    NSString *cMinVol = [NSString stringWithFormat:@"SMin: %1.2f",[[User shared] userCalibratedMinVolume].doubleValue];
    self.cMinVolLabel.text = cMinVol;
    
    NSString *maxSens = [NSString stringWithFormat:@"cSMax: %1.2f",[[User shared] userCalibratedMaxSensorValue].doubleValue];
     self.maxSensLabel.text = maxSens;
    
    NSString *minSens = [NSString stringWithFormat:@"cSMin: %1.2f",[[User shared] userCalibratedMinSensorValue].doubleValue];
    self.minSensLabel.text = minSens;
    
//    self.connectionStrengthLabel.text = [[[User shared] connectionStrength] stringValue];
}


- (void)setGravity
{
    if ([[User shared] meterGravityEnabled] == YES) {
        [self.shape1View startGravity];
        NSLog(@"Gravity has started");
    }
    else{
        [self.shape1View stopGravity];
        NSLog(@"Gravity has stopped");
    }
}

-(UIColor*)setLungColor{
    CGFloat red = 255;
    CGFloat green = 0;
    CGFloat blue = 0;
    
 
    
        // Timer check 
    
    UIColor *color = [UIColor colorWithRed:red/255.f green:green/255.f blue:blue/255.f alpha:0.7f];

    return color;
}



- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
