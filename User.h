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

@property (strong, nonatomic) NSNumber *userCurrentMaxStretchValue; //value between 0 and 9999 (usually 700-800)
@property (strong, nonatomic) NSNumber *userCurrentMinStretchValue; //value between 0 and 9999 (usually 700-800)
@property (strong, nonatomic) NSNumber *userCurrentMaxVolume;//value between 0 and 1
@property (strong, nonatomic) NSNumber *userCurrentMinVolume;//value between 0 and 1

@property (strong, nonatomic) NSNumber *userTotalBreathCoherence;
@property (strong, nonatomic) NSNumber *userTotalBreathCoherenceDelta;
@property (strong, nonatomic) NSNumber *userCurrentBreathCoherence;


@property double userBreathCount; //number of breaths made under this specific target
@property CGFloat userCurrentLungVolume; // CHANGE TO DEPTH value between 0 and 1 representing 0% to 100% lung volume
@property UInt16 rawStretchSensorValue; //raw sensor value as received from BLE


//calibrated global metrics (the global values are the highest and lowest recorded in per app run)
@property (strong, nonatomic) NSNumber *userGlobalMaxStretchValue; //value between 0 and 9999 (usually 700-800)
@property (strong, nonatomic) NSNumber *userGlobalMinStretchValue; //value between 0 and 9999 (usually 700-800)
@property (strong, nonatomic) NSNumber *userGlobalMaxVolume;//value between 0 and 1
@property (strong, nonatomic) NSNumber *userGlobalMinVolume;//value between 0 and 1



//target user breathing metrics (set in settings view)
@property (strong, nonatomic) NSNumber *userTargetVolume; //breathing depth in percent of total calibrated lung volume
@property (strong, nonatomic) NSNumber *userTargetInhaleTime;
@property (strong, nonatomic) NSNumber *userTargetExhaleTime;


//Bluetooth Low Energy Connection properties
@property (strong, nonatomic) NSNumber *connectionStrength;
@property (strong, nonatomic) BLE *ble;

//User Settings
@property BOOL bleIsConnected;
@property BOOL fakeDataIsOn;
@property (readwrite) BOOL meterGravityEnabled;

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


-(CGFloat)mapValuesForInput:(CGFloat) input withInputRangeMin:(CGFloat)inMin andMax:(CGFloat)inMax andOutputRangeMin:(CGFloat)outMin andMax:(CGFloat)outMax;

//breathing coherence calucations
-(void)calculateTotalBreathCoherence;
//-(void)calculateCurrentBreathCoherence;
-(void)calculateBreathCount;
-(void)calculateBreathCoherenceDeltaWithPastValue:(CGFloat)pastValue;
-(void)calibrateMaxVolume;
-(void)calibrateMinVolume;

+ (id)shared;
- (BOOL) isFirstRun;


@end
