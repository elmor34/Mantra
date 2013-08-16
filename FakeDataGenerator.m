//
//  FakeSensor.m
//  MantraV1.2
//
//  Created by David Crow on 7/20/13.
//  Copyright (c) 2013 David Crow. All rights reserved.
//

#import "FakeDataGenerator.h"
#import "User.h"

@implementation FakeDataGenerator {}

@synthesize fakeUserBreathingRate, fakeUserBreathingOn, sensorVal,sampleTime, fakeUserCurrentVolume, deltaSize, fakeUserMaxVolume, fakeUserExhaleTime, fakeUserInhaleTime, fakeUserMinVolume, inhaleTimer, exhaleTimer;
    
    
+ (FakeDataGenerator *)shared
    {
        DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
            return [[self alloc] init];
        });
    }
    
-(FakeDataGenerator *)init{
    self = [super init];
    
    self.fakeUserBreathingOn = NO;
    self.fakeUserBreathingRate = 0;
    self.fakeUserExhaleTime = 0;
    self.fakeUserInhaleTime = 0;
    self.fakeUserMaxVolume = 0;
    self.fakeUserMinVolume = 0;
    self.sensorVal = 0;

    return self;
}

//This method is ridiculous, refactor
-(void)startFakeBreathingWithFakeUserInhaleTime:(NSNumber*)fakeInhaleTime andFakeUserExhaleTime:(NSNumber*)fakeExhaleRate fakeMaxVolume:(NSNumber*)fakeMaxVolume andFakeUserMinVolume:(NSNumber*)fakeMinVolume{
    
    self.fakeUserExhaleTime = fakeExhaleRate.floatValue;
    self.fakeUserInhaleTime = fakeInhaleTime.floatValue;
    self.fakeUserMaxVolume = fakeMaxVolume.floatValue;
    self.fakeUserMinVolume = fakeMinVolume.floatValue;
    self.sensorVal = 770;
    self.fakeUserCurrentVolume = sensorVal;
    self.fakeUserBreathingOn = YES;
    self.sampleTime = .1; //sample rate for the fake sensor is 100 ms
    
    /*incrementSize needs to be calculated because the volume needs to increment at a more natural rate.  You must get to the maxVolume in inhaleTime - so the natural increment size is determined by taking (the amount you need to increment) / (the number of samples you will take)
    */
    //set initial inhale delta size
    self.deltaSize  = (self.fakeUserMaxVolume-self.fakeUserCurrentVolume)/(self.fakeUserInhaleTime/self.sampleTime);
    [self fakeInhale];
    NSLog(@"fake breathing started with stats with \n fakeInhaleRate:%@ \n fakeExhaleRate:%@ \n fakeMinVolume:%@ \n fakeMaxVolume:%@",fakeInhaleTime,fakeExhaleRate ,fakeMaxVolume,fakeMinVolume);
}

-(void)stopFakeBreathing{
    [self.inhaleTimer invalidate];
    self.inhaleTimer = nil;
    [self.exhaleTimer invalidate];
    self.exhaleTimer = nil;
    self.fakeUserBreathingOn = NO;
    self.fakeUserBreathingRate = 0;
    self.fakeUserExhaleTime = 0;
    self.fakeUserInhaleTime = 0;
    self.fakeUserMaxVolume = 0;
    self.fakeUserMinVolume = 0;
    self.fakeUserCurrentVolume = 0;
    self.sensorVal = 0;
    [self printFakeDataToConsole];
    NSLog(@"fake breathing stopped");
}
    
-(void)fakeInhale{
    //Fake inhale will increment sensorval and continue to call itself until the total elapsed sampling time = the inhale rate
    
    if(fakeUserBreathingOn == YES){
        
        
        if (fakeUserCurrentVolume < fakeUserMaxVolume) {
            if (inhaleTimer == nil){
            //set a timer to call self until the above condition is no longer true
            self.inhaleTimer = [[NSTimer alloc] init];
            self.inhaleTimer = [NSTimer scheduledTimerWithTimeInterval:self.sampleTime target:self selector:@selector(fakeInhale) userInfo:nil repeats:YES];
            }
            self.fakeUserCurrentVolume = self.fakeUserCurrentVolume + self.deltaSize;
            [self printFakeDataToConsole];
            [self loadFakeLungValIntoMantraUser];
        }
        else{
            //set exhale delta size
            self.deltaSize  = (self.fakeUserMinVolume-self.fakeUserCurrentVolume)/(self.fakeUserExhaleTime/self.sampleTime);
            
            //invalidate the secondary timer and call fakeExhale
            [self.inhaleTimer invalidate];
            self.inhaleTimer = nil;
            [self fakeExhale];
        }

    }
}
    
-(void)fakeExhale{

    if(fakeUserBreathingOn == YES){
        
        if (fakeUserCurrentVolume > fakeUserMinVolume) {
            
            //set a timer to call self until the above condition is no longer true
            if (exhaleTimer == nil){
                //set a timer to call self until the above condition is no longer true
                self.exhaleTimer = [[NSTimer alloc] init];
                self.exhaleTimer = [NSTimer scheduledTimerWithTimeInterval:self.sampleTime target:self selector:@selector(fakeExhale) userInfo:nil repeats:YES];
            }
                        
            self.fakeUserCurrentVolume = self.fakeUserCurrentVolume + self.deltaSize;
            [self printFakeDataToConsole];
            [self loadFakeLungValIntoMantraUser];

        }
        else{
            //set inhale delta size
            self.deltaSize  = (self.fakeUserMaxVolume-self.fakeUserCurrentVolume)/(self.fakeUserInhaleTime/self.sampleTime);
            //invalidate the secondary timer and call fakeExhale
            [self.exhaleTimer invalidate];
            self.exhaleTimer = nil;
            [self fakeInhale];
        }
        
    }

}
    
-(void)printFakeDataToConsole{
   //NSLog(@"fake_sensorVal: %hu", self.sensorVal);
    NSLog(@"fakeUserCurrentVolume: %f", self.fakeUserCurrentVolume);
    NSLog(@"fake_inhaleRate: %f", self.fakeUserInhaleTime);
   
    NSLog(@"fake_exhaleRate: %f", self.fakeUserExhaleTime);
    NSLog(@"deltaSize: %f", self.deltaSize);
}


-(void)loadFakeLungValIntoMantraUser{//refactor, this is not lungVal anymore
    //Post notification that sensor value changed
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"fakeSensorValueChanged"
     object:[FakeDataGenerator shared]];
    
    //Do mapping to set lunVal directly
    //plot value mapping (these values are a little counter intuitive because the min is high and the max is low
    CGFloat refInMax = [[User shared] userCalibratedMaxSensorValue].floatValue;//reference max determined by experimentation with sensor bands (this will calibrate dynamically)
    CGFloat refInMin = [[User shared] userCalibratedMinSensorValue].floatValue;//reference min determined by experimentation with sensor bands (this will calibrate dynamically)
    
    
    //dynamic calibration block
    
    CGFloat pastValue;
    CGFloat outMax = 1.0;
    CGFloat outMin = 0;
    CGFloat in = self.fakeUserCurrentVolume;
    CGFloat out = outMax + (outMin - outMax) * (in - refInMax) / (refInMin - refInMax);
    [[User shared] setUserCurrentLungVolume:out];
    [self calculateBreathCount];
    //Store a value to compare to the subsample ~0.5 seconds later
    pastValue = out;
    //Subsample the fake value for calculating the delta
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //code to be executed on the main queue after delay
        [self calculateBreathingDeltaWithPastValue:pastValue];
    });
    

    
}

//Calculate the delta by comparing the passed in sample from ~0.5 seconds ago to the current sample
-(void)calculateBreathingDeltaWithPastValue: (CGFloat) pastValue{
    CGFloat delta = pastValue - [[User shared] userCurrentLungVolume];
    NSLog(@"\n Delta:%f \n", delta);
    [[User shared] setUserCurrentBreathingDelta:[NSNumber numberWithFloat:delta]];
    
    
    CGFloat pastValue2 = delta;
    //Subsample the fake value for calculating the delta
double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //code to be executed on the main queue after delay
        [self calculateBreathingDeltaDeltaWithPastValue:pastValue2];
    });
    
}

-(void)calculateBreathingDeltaDeltaWithPastValue: (CGFloat) pastValue{
    CGFloat deltadelta = pastValue - [[User shared] userCurrentBreathingDelta].floatValue;
    NSLog(@"\n Deltadelta:%f \n", deltadelta);
    [[User shared] setUserCurrentBreathingDeltaDelta:[NSNumber numberWithFloat:deltadelta]];
}


-(void)calculateBreathCoherence{

}

//number of breaths taken with some target breathing pattern
-(void)calculateBreathCount{
    double tmpBreathCount = [[User shared] userBreathCount];
    
    if (inhaleCheck == 0) {
        if ([[User shared] userCurrentBreathingDeltaDelta].floatValue >= 0.05){
            NSLog(@"\nMax inhale\n");
            tmpBreathCount = tmpBreathCount + 0.5;
            inhaleCheck++;//increment to prevent re-counting inhale
            exhaleCheck = 0;//set to zero to allow counting of exhale
        }
        
    }
  
    if (exhaleCheck == 0){
        if ([[User shared] userCurrentBreathingDeltaDelta].floatValue <= -0.05){
            NSLog(@"\nMax Exhale\n");
            tmpBreathCount = tmpBreathCount + 0.5;
            exhaleCheck++;//increment to prevent re-counting exhale
            inhaleCheck = 0;//set to zero to allow counting of exhale
        }
      
    }
  
    
    [[User shared] setUserBreathCount:tmpBreathCount];
    NSLog(@"\nbreath count = %f\n", [[User shared] userBreathCount]);
}



@end
