#import <Foundation/Foundation.h>


#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t pred = 0; \
__strong static id _sharedObject = nil; \
dispatch_once(&pred, ^{ \
_sharedObject = block(); \
}); \
return _sharedObject; \


@interface DataGenerator : NSObject {
    int inhaleCheck;
    int exhaleCheck;
}
    
    
//Fake user data
@property CGFloat generatedBreathingRate;
@property CGFloat generatedInhaleTime;
@property CGFloat generatedExhaleTime;

@property CGFloat generatedCurrentVolume;//number from 0 to 1
@property CGFloat generatedCurrentSensorValue;//raw sensor value (usually between 700 and 900)

@property CGFloat generatedCurrentMaxStretchValue;
@property CGFloat generatedCurrentMinStretchValue;
@property CGFloat generatedCurrentMaxVolumeValue;
@property CGFloat generatedCurrentMinVolumeValue;

@property CGFloat sampleTime;
@property CGFloat deltaSize;


//calibrated global metrics (the global values are the highest and lowest recorded in per app run)
@property CGFloat generatedGlobalMaxStretchValue; //value between 0 and 9999 (usually 700-800)
@property CGFloat generatedGlobalMinStretchValue; //value between 0 and 9999 (usually 700-800)
@property CGFloat generatedGlobalMaxVolume;//value between 0 and 1
@property CGFloat generatedGlobalMinVolume;//value between 0 and 1



//Timers for inhale stroke and exhale stroke
@property NSTimer *inhaleTimer;
@property NSTimer *exhaleTimer;


@property BOOL generatedBreathingOn;
@property CGFloat lungVal;//sensor value between 0 and 1 representing lung volume
@property UInt16 sensorVal; //raw sensor value as received from BLE
    
+ (id)shared;

//This method is ridiculous, refactor
-(void)startFakeBreathing;
-(void)stopFakeBreathing;
-(void)fakeInhale;
-(void)fakeExhale;
-(void)printFakeDataToConsole;
-(void)loadGeneratedDataIntoUser;

    
@end
