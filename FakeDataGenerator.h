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


@interface FakeDataGenerator : NSObject {
    int inhaleCheck;
    int exhaleCheck;
}
    
    
//Fake user data
@property CGFloat fakeUserBreathingRate;
@property CGFloat fakeUserInhaleTime;
@property CGFloat fakeUserExhaleTime;
@property CGFloat fakeUserCurrentVolume;//number from 0 to 1
@property CGFloat fakeUserCurrentSensorValue;//raw sensor value (usually between 700 and 900)
@property CGFloat fakeUserMaxSensorValue;
@property CGFloat fakeUserMinSensorValue;
@property CGFloat sampleTime;
@property CGFloat deltaSize;



//Timers for inhale stroke and exhale stroke
@property NSTimer *inhaleTimer;
@property NSTimer *exhaleTimer;


@property BOOL fakeUserBreathingOn;
@property CGFloat lungVal;//sensor value between 0 and 1 representing lung volume
@property UInt16 sensorVal; //raw sensor value as received from BLE
    
+ (id)shared;

-(void)startFakeBreathingWithFakeInhaleTime:(NSNumber*)fakeInhaleTime fakeExhaleTime:(NSNumber*)fakeExhaleTime fakeMaxSens:(NSNumber*)fakeMaxVolume fakeMinSens:(NSNumber*)fakeMinVolume;
-(void)stopFakeBreathing;
-(void)fakeInhale;
-(void)fakeExhale;
-(void)printFakeDataToConsole;
-(void)loadFakeLungValIntoMantraUser;

    
@end
