//
//  DeveloperSettingsViewController.m
//  MantraV1.2
//
//  Created by David Crow on 7/21/13.
//  Copyright (c) 2013 David Crow. All rights reserved.
//

#import "DeveloperSettingsViewController.h"
#import "DataGenerator.h"
#import "User.h"

@interface DeveloperSettingsViewController ()

@end

@implementation DeveloperSettingsViewController

- (void)viewDidLoad
{
    //Propertly load settings
    if ([[User shared] fakeDataIsOn] == YES) {
        [self.fakeUserSwitch setOn:YES];
    }
    else [self.fakeUserSwitch setOn:NO];
    
    self.view.userInteractionEnabled = TRUE;
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;
    
    [self configureRangeSliders];
    [super viewDidLoad];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    
}


-(void)updateFakeDataGeneratorProperties{
    
    //Set all the necessary FakeDataGenerator properties
    [[DataGenerator shared] setFakeUserInhaleTime:[self.fakeUserInhaleTimeTextField.text integerValue]];
    [[DataGenerator shared] setFakeUserExhaleTime:[self.fakeUserExhaleTimeTextField.text integerValue]];
    [[DataGenerator shared] setFakeUserCurrentMaxStretchValue:[self.fakeUserMinStretchTextField.text floatValue]];
    [[DataGenerator shared] setFakeUserCurrentMinStretchValue:[self.fakeUserMaxStretchTextField.text floatValue]];
    [[DataGenerator shared] setFakeUserCurrentMaxVolumeValue:self.generatedVolumeRangeSlider.upperValue/100];
    [[DataGenerator shared] setFakeUserCurrentMinVolumeValue:self.generatedVolumeRangeSlider.lowerValue/100];
    [[DataGenerator shared] setFakeUserGlobalMaxStretchValue:[self.fakeUserGlobalMinStretchTextField.text floatValue]];
    [[DataGenerator shared] setFakeUserGlobalMinStretchValue:[self.fakeUserGlobalMaxStretchTextField.text floatValue]];
    
}

- (void) configureRangeSliders
{
//    self.generatedVolumeRangeSlider.minimumValue = 0;
//    self.generatedVolumeRangeSlider.maximumValue = 100;
//    
//    self.generatedVolumeRangeSlider.lowerValue = 0;
//
//    self.generatedVolumeRangeSlider.upperValue = 100;
//    
//    self.generatedVolumeRangeSlider.minimumRange = 10;
}

- (IBAction)sliderRangeSliderChanged:(NMRangeSlider*)sender {
    CGPoint lowerCenter;
    lowerCenter.x = (sender.lowerCenter.x + sender.frame.origin.x);
    lowerCenter.y = (sender.center.y - 20.0f);
    
    self.generatedVolumeRangeLowLabel.center = lowerCenter;
    self.generatedVolumeRangeLowLabel.text = [NSString stringWithFormat:@"%d", (int)sender.lowerValue];

  
    
    CGPoint upperCenter;
    upperCenter.x = (sender.upperCenter.x + sender.frame.origin.x);
    upperCenter.y = (sender.center.y - 20.0f);
    self.generatedVolumeRangeHighLabel.center = upperCenter;
    self.generatedVolumeRangeHighLabel.text = [NSString stringWithFormat:@"%d", (int)sender.upperValue];
    
    //recalculate sensor range
    double lowPercent = sender.lowerValue/100;
    double highPercent = sender.upperValue/100;
    
    double minStretch = [self.fakeUserMinStretchTextField.text doubleValue];
    double maxStretch = [self.fakeUserMaxStretchTextField.text doubleValue];
    
    double minGlobalStretch = [self.fakeUserGlobalMinStretchTextField.text doubleValue];
    double maxGlobalStretch = [self.fakeUserGlobalMaxStretchTextField.text doubleValue];
   
    double dif = (maxGlobalStretch - minGlobalStretch);
    
    [self.fakeUserMinStretchTextField setText: [NSString stringWithFormat:@"%1.0f", minGlobalStretch + (dif * lowPercent)]];
    [self.fakeUserMaxStretchTextField setText: [NSString stringWithFormat:@"%1.0f", maxGlobalStretch - (dif * (1 - highPercent))]];
    
    [self updateFakeDataGeneratorProperties];

}

-(void)recalulateFields{

}

- (void)hideKeyboard{
    
    if ([self checkTextFieldValues] == YES && [self.fakeUserSwitch isOn]) {
        //hide keyboard
        [self.view endEditing:YES];
        
        //restart data generation with updated values pulled from the UI
        [self updateFakeDataGeneratorProperties];
        [[DataGenerator shared] startFakeBreathing];

    }
    else{
    [self.view endEditing:NO];
    }
}

-(BOOL)checkTextFieldValues{
    
    if (([self.fakeUserInhaleTimeTextField.text floatValue] < 0.5) || ([self.fakeUserInhaleTimeTextField.text floatValue] > 300))
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"Please choose a inhale time between 0.5 seconds and 300 seconds"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
    if (([self.fakeUserExhaleTimeTextField.text floatValue] < 0.5) || ([self.fakeUserExhaleTimeTextField.text floatValue] > 300))
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"Please choose a exhale time between 0.5 seconds and 300 seconds"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
    if ([self.fakeUserMinStretchTextField.text floatValue] < [self.fakeUserGlobalMinStretchTextField.text floatValue] || [self.fakeUserMaxStretchTextField.text floatValue] > [self.fakeUserGlobalMaxStretchTextField.text floatValue] )
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"Please choose a minimum sensor value between %1.0f and %1.0f", [self.fakeUserGlobalMinStretchTextField.text floatValue], [self.fakeUserGlobalMaxStretchTextField.text floatValue]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
    else     return YES;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)fakeUserSwitchTouched:(id)sender{
    if (self.fakeUserSwitch.isOn == YES) {
        [[User shared] setFakeDataIsOn:YES];
        
        NSLog(@"fake data ON");
        //fix this to use real values from fakeuser
        
        [NSNumber numberWithInteger:[self.fakeUserInhaleTimeTextField.text integerValue]];
        [self updateFakeDataGeneratorProperties];
        [[DataGenerator shared] startFakeBreathing];
    }
    if (self.fakeUserSwitch.isOn == NO) {
        [[User shared] setFakeDataIsOn:NO];
        NSLog(@"fake data OFF");
        [[DataGenerator shared] stopFakeBreathing];
    }
}

@end
