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


@interface FakeMantraUser : NSObject
    
    
    
@property CGFloat breathingRate;
@property CGFloat fakeUserInhaleTime;
@property CGFloat fakeUserExhaleTime;
@property CGFloat fakeUserCurrentVolume;//refactor to fakeUserCurrentVolume for consistency
@property CGFloat fakeUserMaxVolume;
@property CGFloat fakeUserMinVolume;
@property CGFloat sampleTime;
@property CGFloat deltaSize;




@property BOOL breathingOn;
@property CGFloat lungVal;//sensor value between 0 and 1 representing lung volume
@property UInt16 sensorVal; //raw sensor value as received from BLE
    
+ (id)shared;

-(void)startFakeBreathingWithFakeBreathingStats:(CGFloat)fakeUserInhaleRate exhaleRate:(CGFloat)fakeUserExhaleRate fakeUserMaxVolume:(CGFloat)fakeUserMaxVolume fakeUserMinVolume:(CGFloat)fakeUserMinVolume;
    -(void)fakeInhale;
    -(void)fakeExhale;
-(void)printFakeDataToConsole;
    
-(void)setFakeShallowBreathing;
-(void)setFakePerfectBreathing;

    -(void)naturalIncrement;
-(void)naturalDecrement;

    
@end
