//
//  MantraUser.h
//  MantraV1.2
//
//  Created by David Crow on 6/16/13.
//  Copyright (c) 2013 David Crow. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "BLE.h"


#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t pred = 0; \
__strong static id _sharedObject = nil; \
dispatch_once(&pred, ^{ \
_sharedObject = block(); \
}); \
return _sharedObject; \

@interface User : NSObject <BLEDelegate>


//current user breathing metrics
@property (strong, nonatomic) NSNumber *userCurrentBreathingRate;
@property (strong, nonatomic) NSNumber *userCurrentInhaleTime;
@property (strong, nonatomic) NSNumber *userCurrentExhaleTime;
@property (strong, nonatomic) NSNumber *userCurrentBreathingDelta;//Change breathing rate (0.5s delta)
@property (strong, nonatomic) NSNumber *userCurrentBreathingDeltaDelta;//Change breathing rate rate (0.5s delta of 0.5s delta)




@property double userBreathCount; //number of breaths made under this specific target
@property CGFloat userCurrentLungVolume; // CHANGE TO DEPTH value between 0 and 1 representing 0% to 100% lung volume
@property UInt16 rawStretchSensorValue; //raw sensor value as received from BLE
@property (strong, nonatomic) NSNumber *userCalibratedMaxSensorValue;
@property (strong, nonatomic) NSNumber *userCalibratedMinSensorValue;



//target user breathing metrics (set in settings view)
@property (strong, nonatomic) NSNumber *userTargetDepth; //breathing depth in percent of total calibrated lung volume
@property (strong, nonatomic) NSNumber *userTargetInhaleTime;
@property (strong, nonatomic) NSNumber *userTargetExhaleTime;


//Bluetooth Low Energy Connection properties
@property (strong, nonatomic) NSNumber *connectionStrength;
@property (readwrite) BOOL meterGravityEnabled;
@property (strong, nonatomic) BLE *ble;

//User Settings
@property BOOL bleIsConnected;
@property BOOL fakeDataIsOn;

-(void)loadDefaults;


//Bluetooth Low Energy delegate methods
-(void) bleDidConnect;
-(void) bleDidDisconnect;
-(void) bleDidUpdateRSSI:(NSNumber *) rssi;
-(void) bleDidReceiveData:(unsigned char *) data length:(int) length;
- (void) scanForPeripherals:(id)sender;
- (void) scanForPeripherals;

//Breathing delta and deltadelta calculations
//Delta is change in rate of breathing
-(void)calculateBreathingDeltaWithPastValue:(CGFloat)pastValue;
//Delta is change in rate of rate of breathing
-(void)calculateBreathingDeltaDeltaWithPastValue:(CGFloat)pastValue;

-(void)calculateBreathCount;
-(void)calculateBreathCoherence;


+ (id)shared;
- (BOOL) isFirstRun;


@end
