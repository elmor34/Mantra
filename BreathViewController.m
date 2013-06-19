//
//  FirstViewController.m
//  MantraV1.2
//
//  Created by David Crow on 6/12/13.
//  Copyright (c) 2013 David Crow. All rights reserved.
//

#import "BreathViewController.h"
#import "SettingsViewController.h"
#import "MantraUser.h"
#import "DPMeterView.h"
#import "UIBezierPath+BasicShapes.h"

@interface BreathViewController ()
@property (nonatomic, strong) NSTimer* animationTimer;
@end

@implementation BreathViewController

@synthesize meterLevel;


- (void)viewDidLoad
{
    [super viewDidLoad];
    meterLevel = .0;//default meter level is 0
    
    
    // UIApperance
    [[DPMeterView appearance] setTrackTintColor:[UIColor redColor]];
    [[DPMeterView appearance] setProgressTintColor:[UIColor redColor]];
    
    // shape 1 -- Lungs
    [self.shape1View setShape:[UIBezierPath heartShape:self.shape1View.frame].CGPath];
    self.shape1View.progressTintColor = [UIColor colorWithRed:255/255.f green:255/255.f blue:255/255.f alpha:0.f];
}


- (void)sensorValChanged:(NSNotification *)notification{
    NSLog(@"ello sensorValDidChange");
}

- (IBAction)testButton:(id)sender
{
    
    //THIS is how you set to an arbitrary number (or in this case the sensorval)
    [self.shape1View setProgress:.5 animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.shape1View setHidden:NO];
    [self updateProgressWithDelta:1.0 animated:YES];
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
    
    self.title = [NSString stringWithFormat:@"%.2f%%",
                  [(DPMeterView *)[shapeViews lastObject] progress]*100];
}

- (IBAction)minus:(id)sender
{
    [self updateProgressWithDelta:+0.1 animated:YES];
}

- (IBAction)add:(id)sender
{
    [self updateProgressWithDelta:-0.1 animated:YES];
}

- (IBAction)orientationHasChanged:(id)sender
{
    CGFloat value = self.orientationSlider.value;
    CGFloat angle = (M_PI/180) * value;
    self.orientationLabel.text = [NSString stringWithFormat:@"orientation (%.0f°)", value];
    
    for (DPMeterView *v in [self shapeViews]) {
        [v setGradientOrientationAngle:angle];
    }
}



- (IBAction)toggleGravity:(id)sender
{
    for (DPMeterView *shapeView in [self shapeViews]) {
        if ([self.gravitySwitch isOn] && ![shapeView isGravityActive]) {
            [shapeView startGravity];
        } else if (![self.gravitySwitch isOn] && [shapeView isGravityActive]) {
            [shapeView stopGravity];
        }
    }
}

- (void)toggleGravity
{
    for (DPMeterView *shapeView in [self shapeViews]) {
        if ([self.gravitySwitch isOn] && ![shapeView isGravityActive]) {
            [shapeView startGravity];
        } else if (![self.gravitySwitch isOn] && [shapeView isGravityActive]) {
            [shapeView stopGravity];
        }
    }
}


- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
