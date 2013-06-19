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



@property (assign, nonatomic) NSNumber *breathingRate;
@property (assign, nonatomic) NSNumber *inhaleRate;
@property (assign, nonatomic) NSNumber *exhaleRate;
@property (assign, nonatomic) NSNumber *maxVolume;
@property (assign, nonatomic) NSNumber *minVolume;
@property UInt16 sensorVal;

//BLE Delegate
@property (strong, nonatomic) BLE *ble;
-(void) bleDidConnect;
-(void) bleDidDisconnect;
-(void) bleDidUpdateRSSI:(NSNumber *) rssi;
-(void) bleDidReceiveData:(unsigned char *) data length:(int) length;


+ (id)shared;
- (BOOL) isFirstRun;


@end
