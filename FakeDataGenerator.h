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

@property CGFloat fakeUserCurrentMaxSensorValue;
@property CGFloat fakeUserCurrentMinSensorValue;
@property CGFloat fakeUserCurrentMaxVolumeValue;
@property CGFloat fakeUserCurrentMinVolumeValue;

@property CGFloat sampleTime;
@property CGFloat deltaSize;


//calibrated global metrics (the global values are the highest and lowest recorded in per app run)
@property CGFloat fakeUserGlobalMaxSensorValue; //value between 0 and 9999 (usually 700-800)
@property CGFloat fakeUserGlobalMinSensorValue; //value between 0 and 9999 (usually 700-800)
@property CGFloat fakeUserGlobalMaxVolume;//value between 0 and 1
@property CGFloat fakeUserGlobalMinVolume;//value between 0 and 1



//Timers for inhale stroke and exhale stroke
@property NSTimer *inhaleTimer;
@property NSTimer *exhaleTimer;


@property BOOL fakeUserBreathingOn;
@property CGFloat lungVal;//sensor value between 0 and 1 representing lung volume
@property UInt16 sensorVal; //raw sensor value as received from BLE
    
+ (id)shared;

//This method is ridiculous, refactor
-(void)startFakeBreathingWithFakeInhaleTime:(NSNumber*)fakeInhaleTime fakeExhaleTime:(NSNumber*)fakeExhaleTime fakeMaxSens:(NSNumber*)fakeMaxSens fakeMinSens:(NSNumber*)fakeMinSens fakeMaxVol:(NSNumber *) fakeMaxVol fakeMinVol:(NSNumber *) fakeMinVol;
-(void)stopFakeBreathing;
-(void)fakeInhale;
-(void)fakeExhale;
-(void)printFakeDataToConsole;
-(void)loadFakeLungValIntoMantraUser;

    
@end
