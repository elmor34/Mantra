//
//  FakeSensor.h
//  MantraV1.2
//
//  Created by David Crow on 7/20/13.
//  Copyright (c) 2013 David Crow. All rights reserved.
//

#import <Foundation/Foundation.h>


#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t pred = 0; \
__strong static id _sharedObject = nil; \
dispatch_once(&pred, ^{ \
_sharedObject = block(); \
}); \
return _sharedObject; \


@interface FakeDataGenerator : NSObject
    
    
//Fake user data
@property CGFloat fakeUserBreathingRate;
@property CGFloat fakeUserInhaleTime;
@property CGFloat fakeUserExhaleTime;
@property CGFloat fakeUserCurrentVolume;
@property CGFloat fakeUserMaxVolume;
@property CGFloat fakeUserMinVolume;
@property CGFloat sampleTime;
@property CGFloat deltaSize;


//Timers for inhale stroke and exhale stroke
@property NSTimer *inhaleTimer;
@property NSTimer *exhaleTimer;


@property BOOL fakeUserBreathingOn;
@property CGFloat lungVal;//sensor value between 0 and 1 representing lung volume
@property UInt16 sensorVal; //raw sensor value as received from BLE
    
+ (id)shared;

-(void)startFakeBreathingWithFakeUserInhaleTime:(NSNumber*)fakeInhaleTime andFakeUserExhaleTime:(NSNumber*)fakeExhaleRate fakeMaxVolume:(NSNumber*)fakeMaxVolume andFakeUserMinVolume:(NSNumber*)fakeMinVolume;
-(void)stopFakeBreathing;
-(void)fakeInhale;
-(void)fakeExhale;
-(void)printFakeDataToConsole;
-(void)loadFakeLungValIntoMantraUser;
-(void)calculateBreathingRateWithPastValue: (CGFloat) pastValue;
    
@end
