//
//  FakeSensor.m
//  MantraV1.2
//
//  Created by David Crow on 7/20/13.
//  Copyright (c) 2013 David Crow. All rights reserved.
//

#import "FakeMantraUser.h"

@implementation FakeMantraUser

    @synthesize breathingRate, exhaleRate, inhaleRate, maxVolume, minVolume, breathingOn, sensorVal;
    
    
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
    exhaleRate = 0;
    inhaleRate = 0;
    maxVolume = 0;
    minVolume = 0;
    sensorVal = 0;
    
    return self;
}

-(void)startFakeBreathingWithFakeUserInhaleRate:(NSNumber*)fakeInhaleRate andFakeUserExhaleRate:(NSNumber*)fakeExhaleRate fakeMaxVolume:(NSNumber*)fakeMaxVolume andFakeUserMinVolume:(NSNumber*)fakeMinVolume{
    
    self.fakeUserExhaleRate = fakeExhaleRate;
    self.fakeUserInhaleRate = fakeInhaleRate;
    self.fakeUserMaxVolume = fakeMaxVolume;
    self.fakeUserMinVolume = fakeMinVolume;
    breathingOn = YES;
    sensorVal = 700;
    [self fakeInhale];
    NSLog(@"fake breathing started with stats with \n fakeInhaleRate:%@ \n fakeExhaleRate:%@ \n fakeMinVolume:%@ \n fakeMaxVolume:%@",fakeInhaleRate,fakeExhaleRate ,fakeMaxVolume,fakeMinVolume);
}
    


-(void)stopFakeBreathing{
    breathingOn = NO;
    breathingRate = 0;
    exhaleRate = 0;
    inhaleRate = 0;
    maxVolume = 0;
    minVolume = 0;
    sensorVal = 0;
    [self printFakeDataToConsole];
    NSLog(@"fake breathing stopped");
}
    
-(void)fakeInhale{
    if(breathingOn == YES){
    
    [NSTimer scheduledTimerWithTimeInterval:(float)inhaleRate.floatValue target:self selector:@selector(fakeExhale) userInfo:nil repeats:NO];
    
    
    }
    NSLog(@"fake_sensorVal: %hu", sensorVal);

}
    
-(void)fakeExhale{
    if(breathingOn == YES){

    [NSTimer scheduledTimerWithTimeInterval:(float)exhaleRate.floatValue target:self selector:@selector(fakeInhale) userInfo:nil repeats:NO];
    
    }
}
    
-(void)printFakeDataToConsole{
    NSLog(@"fake_sensorVal: %hu", sensorVal);
    NSLog(@"fake_inhaleRate: %f", inhaleRate.floatValue);
    NSLog(@"fake_exhaleRate: %f", exhaleRate.floatValue);
}
    
    
@end
