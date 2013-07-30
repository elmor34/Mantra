//
//  FakeSensor.m
//  MantraV1.2
//
//  Created by David Crow on 7/20/13.
//  Copyright (c) 2013 David Crow. All rights reserved.
//

#import "FakeMantraUser.h"

@implementation FakeMantraUser

@synthesize breathingRate, breathingOn, sensorVal,sampleTime, fakeUserCurrentVolume, deltaSize, fakeUserMaxVolume, fakeUserExhaleTime, fakeUserInhaleTime, fakeUserMinVolume, inhaleTimer, exhaleTimer;
    
    
+ (FakeMantraUser *)shared
    {
        DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
            return [[self alloc] init];
        });
    }
    
-(FakeMantraUser *)init{
    self = [super init];
    
    self.breathingOn = NO;
    self.breathingRate = 0;
    self.fakeUserExhaleTime = 0;
    self.fakeUserInhaleTime = 0;
    self.fakeUserMaxVolume = 0;
    self.fakeUserMinVolume = 0;
    self.sensorVal = 0;

    return self;
}

-(void)startFakeBreathingWithFakeUserInhaleTime:(NSNumber*)fakeInhaleTime andFakeUserExhaleTime:(NSNumber*)fakeExhaleRate fakeMaxVolume:(NSNumber*)fakeMaxVolume andFakeUserMinVolume:(NSNumber*)fakeMinVolume{
    
    self.fakeUserExhaleTime = fakeExhaleRate.floatValue;
    self.fakeUserInhaleTime = fakeInhaleTime.floatValue;
    self.fakeUserMaxVolume = fakeMaxVolume.floatValue;
    self.fakeUserMinVolume = fakeMinVolume.floatValue;
    self.sensorVal = 770;
    self.fakeUserCurrentVolume = sensorVal;
    self.breathingOn = YES;
    self.sampleTime = 1; //sample rate for the fake sensor is 100 ms
    
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
    self.breathingOn = NO;
    self.breathingRate = 0;
    self.breathingOn = NO;
    self.breathingRate = 0;
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
    
    if(breathingOn == YES){
        
        
        if (fakeUserCurrentVolume <= fakeUserMaxVolume) {
            if (inhaleTimer == nil){
            //set a timer to call self until the above condition is no longer true
            self.inhaleTimer = [[NSTimer alloc] init];
            self.inhaleTimer = [NSTimer scheduledTimerWithTimeInterval:self.sampleTime target:self selector:@selector(fakeInhale) userInfo:nil repeats:YES];
            }
            self.fakeUserCurrentVolume = self.fakeUserCurrentVolume + self.deltaSize;
            [self printFakeDataToConsole];
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

    if(breathingOn == YES){
        
        if (fakeUserCurrentVolume >= fakeUserMinVolume) {
            
            //set a timer to call self until the above condition is no longer true
            if (exhaleTimer == nil){
                //set a timer to call self until the above condition is no longer true
                self.exhaleTimer = [[NSTimer alloc] init];
                self.exhaleTimer = [NSTimer scheduledTimerWithTimeInterval:self.sampleTime target:self selector:@selector(fakeExhale) userInfo:nil repeats:YES];
            }
                        
            self.fakeUserCurrentVolume = self.fakeUserCurrentVolume + self.deltaSize;
            [self printFakeDataToConsole];

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
    //Post notification that sensor value changed
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"fakeSensorValueChanged"
     object:[FakeMantraUser shared]];
    
    //NSLog(@"fake_sensorVal: %hu", self.sensorVal);
    NSLog(@"fakeUserCurrentVolume: %f", self.fakeUserCurrentVolume);
    NSLog(@"fake_inhaleRate: %f", self.fakeUserInhaleTime);
   
    NSLog(@"fake_exhaleRate: %f", self.fakeUserExhaleTime);
    NSLog(@"deltaSize: %f", self.deltaSize);
}


    
    
@end
