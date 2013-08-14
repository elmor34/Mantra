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
@property (strong, nonatomic) NSNumber *userCurrentRawSensorDelta;//Change in raw sensor delta
@property (strong, nonatomic) NSNumber *dataBuffer;

@property int userBreathCount;
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


//Bluetooth Low Energy delegate methods
-(void) bleDidConnect;
-(void) bleDidDisconnect;
-(void) bleDidUpdateRSSI:(NSNumber *) rssi;
-(void) bleDidReceiveData:(unsigned char *) data length:(int) length;
- (void)scanForPeripherals:(id)sender;
- (void)scanForPeripherals;

//Breathing rate calculation
-(void)calculateBreathingRateWithPastValue:(CGFloat)pastValue;
-(int)calculateBreathCoherence;
-(void)calculateBreathCount;

+ (id)shared;
- (BOOL) isFirstRun;


@end
