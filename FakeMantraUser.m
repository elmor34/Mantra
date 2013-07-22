//
//  FakeSensor.m
//  MantraV1.2
//
//  Created by David Crow on 7/20/13.
//  Copyright (c) 2013 David Crow. All rights reserved.
//

#import "FakeMantraUser.h"

@implementation FakeMantraUser

    @synthesize breathingRate, breathingOn, sensorVal,sampleTime, fakeUserCurrentVolume, deltaSize, fakeUserMaxVolume, fakeUserExhaleTime, fakeUserInhaleTime, fakeUserMinVolume;
    
    
+ (FakeMantraUser *)shared
    {
        DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
            return [[self alloc] init];
        });
    }
    
-(FakeMantraUser *)init{
    self = [super init];
    
    breathingOn = NO;
    breathingRate = 0;
    fakeUserExhaleTime = 0;
    fakeUserInhaleTime = 0;
    fakeUserMaxVolume = 0;
    fakeUserMinVolume = 0;
    sensorVal = 0;
    
    return self;
}

-(void)startFakeBreathingWithFakeUserInhaleRate:(NSNumber*)fakeInhaleRate andFakeUserExhaleRate:(NSNumber*)fakeExhaleRate fakeMaxVolume:(NSNumber*)fakeMaxVolume andFakeUserMinVolume:(NSNumber*)fakeMinVolume{
    
    self.fakeUserExhaleTime = fakeExhaleRate.floatValue;
    self.fakeUserInhaleTime = fakeInhaleRate.floatValue;
    self.fakeUserMaxVolume = fakeMaxVolume.floatValue;
    self.fakeUserMinVolume = fakeMinVolume.floatValue;
    self.breathingOn = YES;
    self.sampleTime = 0; //sample rate for the fake sensor is 100 ms
    
    /*incrementSize needs to be calculated because the volume needs to increment at a more natural rate.  You must get to the maxVolume in inhaleTime - so the natural increment size is determined by taking (the amount you need to increment) / (the number of samples you will take)
    */
    self.deltaSize  = (self.fakeUserMaxVolume-self.fakeUserCurrentVolume)/(self.fakeUserInhaleTime/self.sampleTime);
    
    sensorVal = 700;
    [self fakeInhale];
    NSLog(@"fake breathing started with stats with \n fakeInhaleRate:%@ \n fakeExhaleRate:%@ \n fakeMinVolume:%@ \n fakeMaxVolume:%@",fakeInhaleRate,fakeExhaleRate ,fakeMaxVolume,fakeMinVolume);
}
    


-(void)stopFakeBreathing{
    breathingOn = NO;
    breathingRate = 0;
    breathingOn = NO;
    breathingRate = 0;
    fakeUserExhaleTime = 0;
    fakeUserInhaleTime = 0;
    fakeUserMaxVolume = 0;
    fakeUserMinVolume = 0;
    sensorVal = 0;
    [self printFakeDataToConsole];
    NSLog(@"fake breathing stopped");
}
    
-(void)fakeInhale{
    //Fake inhale will increment sensorval and continue to call itself until the total elapsed sampling time = the inhale rate
    
    NSTimer *inhaleTimer;
    
    if(breathingOn == YES){
        
        //continue to call the timer 
        if (fakeUserCurrentVolume > fakeUserMaxVolume) {
            
            //set a timer to call self until the above condition is no longer true
            inhaleTimer = [NSTimer scheduledTimerWithTimeInterval:self.sampleTime target:self selector:@selector(fakeInhale) userInfo:nil repeats:YES];
            NSLog(@"fake_sensorVal: %hu", sensorVal);
            
            self.fakeUserCurrentVolume = self.fakeUserCurrentVolume + self.deltaSize;
        }
        else{
            //invalidate the secondary timer and call fakeExhale
            [inhaleTimer invalidate];
            [self fakeExhale];
        }

    }
}
    
-(void)fakeExhale{
//intelligently copy fakeInhale
    NSTimer *exhaleTimer;
    
    if(breathingOn == YES){
        
        //continue to call the timer
        if (fakeUserCurrentVolume > fakeUserMaxVolume) {
            
            //set a timer to call self until the above condition is no longer true
            exhaleTimer = [NSTimer scheduledTimerWithTimeInterval:self.sampleTime target:self selector:@selector(fakeExhale) userInfo:nil repeats:YES];
            NSLog(@"fake_sensorVal: %hu", sensorVal);
            
            self.fakeUserCurrentVolume = self.fakeUserCurrentVolume - self.deltaSize;
        }
        else{
            //invalidate the secondary timer and call fakeExhale
            [exhaleTimer invalidate];
            [self fakeExhale];
        }
        
    }
}
    
-(void)printFakeDataToConsole{
    NSLog(@"fake_sensorVal: %hu", sensorVal);
    NSLog(@"fake_sensorVal: %f", fakeUserCurrentVolume);
    NSLog(@"fake_inhaleRate: %f", fakeUserInhaleTime);
    NSLog(@"fake_exhaleRate: %f", fakeUserExhaleTime);
}


-(void)naturalIncrement:(int)totalSamples{
//increment by a random number between 1-20
    NSLog(@"fake_sensorVal: %hu", sensorVal);
    
}

-(void)naturalDecrement:(int)totalSamples{
    NSLog(@"fake_sensorVal: %hu", sensorVal);
}

    
    
@end
