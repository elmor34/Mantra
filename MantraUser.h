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

@interface MantraUser : NSObject <BLEDelegate>



@property (strong, nonatomic) NSNumber *breathingRate;
@property (strong, nonatomic) NSNumber *inhaleRate;
@property (strong, nonatomic) NSNumber *exhaleRate;
@property (strong, nonatomic) NSNumber *maxVolume;
@property (strong, nonatomic) NSNumber *minVolume;
@property (strong, nonatomic) NSNumber *connectionStrength;
@property BOOL bleConnected;
@property CGFloat lungVal;//sensor value between 0 and 1 representing lung volume
@property UInt16 sensorVal; //raw sensor value as received from BLE


//BLE Delegate
@property (strong, nonatomic) BLE *ble;
-(void) bleDidConnect;
-(void) bleDidDisconnect;
-(void) bleDidUpdateRSSI:(NSNumber *) rssi;
-(void) bleDidReceiveData:(unsigned char *) data length:(int) length;

- (void)scanForPeripherals:(id)sender;
- (void)scanForPeripherals;


+ (id)shared;
- (BOOL) isFirstRun;


@end
