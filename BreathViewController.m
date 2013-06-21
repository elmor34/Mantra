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
    meterLevel = 0.0;//default meter level is 0
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(sensorValueChanged:)
     name:@"sensorValueChanged"
     object:nil];
    
    // UIApperance
    [[DPMeterView appearance] setTrackTintColor:[UIColor redColor]];
    [[DPMeterView appearance] setProgressTintColor:[UIColor redColor]];
    
    // shape 1 -- Lungs
    [self.shape1View setShape:[UIBezierPath heartShape:self.shape1View.frame].CGPath];
    self.shape1View.progressTintColor = [UIColor colorWithRed:255/255.f green:255/255.f blue:255/255.f alpha:0.f];
    
    [[MantraUser shared] scanForPeripherals:self];
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


- (void)sensorValueChanged:(NSNotification *)notification{
    NSLog(@"sensor notifcation received, sensorValueChanged called!");
    //Set the shape view to match the sensor value 
    [self.shape1View setProgress:[[MantraUser shared] lungVal] animated:YES];
    
    NSString *sensorString = [NSString stringWithFormat: @"%.2hu", [[MantraUser shared] sensorVal]];
    self.sensorValLabel.text = sensorString;
    
    NSString *lungString = [NSString stringWithFormat: @"%.2f", [[MantraUser shared] lungVal]];
    self.lungValLabel.text = lungString;
    
    NSString *bleConnected = [NSString stringWithFormat:@"%hhd", [[MantraUser shared] bleConnected]];
    self.connectedLabel.text = bleConnected;
    
    self.connectionStrengthLabel.text = [[[MantraUser shared] connectionStrength] stringValue];
}

- (void)setGravity:(BOOL)state
{
    if (state == YES) {
        [self.shape1View startGravity];
    }
    else{
        [self.shape1View stopGravity];
    }
}

- (IBAction)testButton:(id)sender{
    //Post notification that sensor value changed
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"sensorValueChanged"
     object:[MantraUser shared]];
    NSLog(@"notification posted!");
    [[MantraUser shared] scanForPeripherals:self];
}




- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
