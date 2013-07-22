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
    
    
    
@property (strong, nonatomic) NSNumber *breathingRate;
@property (strong, nonatomic) NSNumber *inhaleRate;
@property (strong, nonatomic) NSNumber *exhaleRate;
@property (strong, nonatomic) NSNumber *fakeUserInhaleRate;
@property (strong, nonatomic) NSNumber *fakeUserExhaleRate;
@property (strong, nonatomic) NSNumber *maxVolume;
@property (strong, nonatomic) NSNumber *minVolume;
@property (strong, nonatomic) NSNumber *fakeUserMaxVolume;
@property (strong, nonatomic) NSNumber *fakeUserMinVolume;
@property BOOL breathingOn;
@property CGFloat lungVal;//sensor value between 0 and 1 representing lung volume
@property UInt16 sensorVal; //raw sensor value as received from BLE
    
+ (id)shared;

-(void)startFakeBreathingWithFakeBreathingStats:(NSNumber*)fakeUserInhaleRate exhaleRate:(NSNumber*)fakeUserExhaleRate fakeUserMaxVolume:(NSNumber*)fakeUserMaxVolume fakeUserMinVolume:(NSNumber*)fakeUserMinVolume;
-(void)fakeInhale;
-(void)fakeExhale;
-(void)printFakeDataToConsole;
    
-(void)setFakeShallowBreathing;
-(void)setFakePerfectBreathing;

    
@end
