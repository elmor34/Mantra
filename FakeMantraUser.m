//
//  FakeSensor.m
//  MantraV1.2
//
//  Created by David Crow on 7/20/13.
//  Copyright (c) 2013 David Crow. All rights reserved.
//

#import "FakeMantraUser.h"

@implementation FakeMantraUser

    @synthesize breathingRate, breathingOn, sensorVal,sampleTime, fakeCurrentVolume, incrementSize, fakeUserMaxVolume, fakeUserExhaleRate, fakeUserInhaleRate, fakeUserMinVolume;
    
    
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
    fakeUserExhaleRate = 0;
    fakeUserInhaleRate = 0;
    fakeUserMaxVolume = 0;
    fakeUserMinVolume = 0;
    sensorVal = 0;
    
    return self;
}

-(void)startFakeBreathingWithFakeUserInhaleRate:(NSNumber*)fakeInhaleRate andFakeUserExhaleRate:(NSNumber*)fakeExhaleRate fakeMaxVolume:(NSNumber*)fakeMaxVolume andFakeUserMinVolume:(NSNumber*)fakeMinVolume{
    
    self.fakeUserExhaleRate = fakeExhaleRate;
    self.fakeUserInhaleRate = fakeInhaleRate;
    self.fakeUserMaxVolume = fakeMaxVolume;
    self.fakeUserMinVolume = fakeMinVolume;
    self.breathingOn = YES;
    self.sampleTime = 0; //sample rate for the fake sensor is 100 ms
    
    /*incrementSize needs to be calculated because the volume needs to increment at a more natural rate.  You must get to the maxVolume in inhaleTime - so the natural increment size is determined by taking (the amount you need to increment) / (the number of samples you will take)
    */
    self.incrementSize2  = (self.fakeUserMaxVolume.floatValue-self.fakeCurrentVolume.floatValue)/(self.fakeUserInhaleRate.floatValue/self.sampleTime.floatValue);
    
    sensorVal = 700;
    [self fakeInhale];
    NSLog(@"fake breathing started with stats with \n fakeInhaleRate:%@ \n fakeExhaleRate:%@ \n fakeMinVolume:%@ \n fakeMaxVolume:%@",fakeInhaleRate,fakeExhaleRate ,fakeMaxVolume,fakeMinVolume);
}
    


-(void)stopFakeBreathing{
    breathingOn = NO;
    breathingRate = 0;
    breathingOn = NO;
    breathingRate = 0;
    fakeUserExhaleRate = 0;
    fakeUserInhaleRate = 0;
    fakeUserMaxVolume = 0;
    fakeUserMinVolume = 0;
    sensorVal = 0;
    [self printFakeDataToConsole];
    NSLog(@"fake breathing stopped");
}
    
-(void)fakeInhale{
    //Fake inhale will increment sensorval and continue to call itself until the total elapsed sampling time = the inhale rate
    
    
    
    if(breathingOn == YES){
        
        //continue to call the timer 
        if (fakeCurrentVolume > fakeUserMaxVolume) {
            
            //set a timer to call self until the above condition is no longer true
            [NSTimer scheduledTimerWithTimeInterval:self.sampleTime target:self selector:@selector(fakeInhale) userInfo:nil repeats:YES];
            NSLog(@"fake_sensorVal: %hu", sensorVal);
            
            fakeCurrentVolume + incrementSize = fakeCurrentVolume;
        }

    }
    
    //invalidate the secondary timer in fakeExhale
    

}
    
-(void)fakeExhale{
    if(breathingOn == YES){

    [NSTimer scheduledTimerWithTimeInterval:(float)exhaleRate.floatValue target:self selector:@selector(fakeInhale) userInfo:nil repeats:NO];
    
    }
    
    //invalidate the secondary timer in fakeInhale
}
    
-(void)printFakeDataToConsole{
    NSLog(@"fake_sensorVal: %hu", sensorVal);
    NSLog(@"fake_inhaleRate: %f", inhaleRate.floatValue);
    NSLog(@"fake_exhaleRate: %f", exhaleRate.floatValue);
}


-(void)naturalIncrement:(int)totalSamples{
//increment by a random number between 1-20
    NSLog(@"fake_sensorVal: %hu", sensorVal);
    
}

-(void)naturalDecrement:(int)totalSamples{
    NSLog(@"fake_sensorVal: %hu", sensorVal);
}

    
    
@end
