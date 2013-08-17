//
//  MantraUser.m
//  MantraV1.2
//
//  Created by David Crow on 6/16/13.
//  Copyright (c) 2013 David Crow. All rights reserved.
//

#import "User.h"


@implementation User {
    CGFloat inhaleCheck;
    CGFloat exhaleCheck;
}

@synthesize userCurrentBreathingRate, userCurrentExhaleTime, userCurrentInhaleTime, userCalibratedMaxSensorValue, userCalibratedMinSensorValue, rawStretchSensorValue, ble, bleIsConnected, connectionStrength, meterGravityEnabled, fakeDataIsOn, userCurrentLungVolume, userTargetExhaleTime, userTargetInhaleTime, userTargetDepth, userBreathCount;


+ (User *)shared
{
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}

-(User *)init{

    self = [super init];
    
//    //init with values to avoid calibration on nil properties (these will quickly be cleared with real values)
//    userCalibratedMaxSensorValue = [NSNumber numberWithFloat: 800];
//    userCalibratedMinSensorValue = [NSNumber numberWithFloat: 700];
//    userCurrentLungVolume = 750;
//    
    
    
    //set the defaults or load MantraUser from storage
    userBreathCount = 0;
    meterGravityEnabled = YES;
    fakeDataIsOn = NO;
    //set up the BLE
    ble = [[BLE alloc] init];
    [ble controlSetup:1];
    ble.delegate = self;
    
    return self;
}

-(void)loadDefaults{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *key = [NSString stringWithFormat:@"userCurrentInhaleTime"];
    [userDefaults setObject:userCurrentInhaleTime forKey:key];
    
}


- (BOOL) isFirstRun
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"isFirstRun"])
    {
        return NO;
    }
    
    [defaults setObject:[NSDate date] forKey:@"isFirstRun"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return YES;
}

- (void)scanForPeripherals:(id)sender
{
    
    if (ble.activePeripheral)
        if(ble.activePeripheral.isConnected)
        {
            [[ble centralManager] cancelPeripheralConnection:[ble activePeripheral]];
            return;
        }
    
    if (ble.peripherals)
        ble.peripherals = nil;
    
    [ble findBLEPeripherals:2];
    
    [NSTimer scheduledTimerWithTimeInterval:(float)2.0 target:self selector:@selector(connectionTimer:) userInfo:nil repeats:NO];
}

- (void)scanForPeripherals
{
    if (ble.activePeripheral)
        if(ble.activePeripheral.isConnected)
        {
            [[ble centralManager] cancelPeripheralConnection:[ble activePeripheral]];
            return;
        }
    
    if (ble.peripherals)
        ble.peripherals = nil;
    
    [ble findBLEPeripherals:2];

}

-(void) connectionTimer:(NSTimer *)timer
{
//    [btnConnect setEnabled:true];
//    [btnConnect setTitle:@"Disconnect" forState:UIControlStateNormal];
//    
    if (ble.peripherals.count > 0)
    {
        [ble connectPeripheral:[ble.peripherals objectAtIndex:0]];
    }
//    else
//    {
//        [btnConnect setTitle:@"Connect" forState:UIControlStateNormal];
//        [indConnecting stopAnimating];
//    }
}

// When connected, this will be called
-(void) bleDidConnect
{
    NSLog(@"BLE->Connected");
    self.bleIsConnected = YES;
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"bleConnected"
     object:[User shared]];
}

-(void) bleDidDisconnect{
    NSLog(@"BLE->Disconnected");
    self.bleIsConnected = NO;
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"bleDisconnected"
     object:[User shared]];
}

-(void) bleDidUpdateRSSI:(NSNumber *) rssi{
    connectionStrength = rssi;
    //Post notification that sensor value changed
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"connectionStrengthChanged"
     object:[User shared]];
}

//not sure if this is required to start analog input
-(void)sendAnalogIn:(BOOL)swAnalogIn
{
    UInt8 buf[3] = {0xA0, 0x00, 0x00};
    
    if (swAnalogIn == YES)
        buf[1] = 0x01;
    else
        buf[1] = 0x00;
    
    NSData *data = [[NSData alloc] initWithBytes:buf length:3];
    [ble write:data];
}


// When data is coming, this will be called
-(void) bleDidReceiveData:(unsigned char *)data length:(int)length
{
    NSLog(@"Length: %d", length);
    
    // parse data, all commands are in 3-byte
    for (int i = 0; i < length; i+=3)
    {
        NSLog(@"0x%02X, 0x%02X, 0x%02X", data[i], data[i+1], data[i+2]);
        
        if (data[i] == 0x0A)
        {
            if (data[i+1] == 0x01)
                NSLog(@"coo");
            //   swDigitalIn.on = true;
            else
                NSLog(@"lol");
            //   swDigitalIn.on = false;
        }
        else if (data[i] == 0x0B)
        {
            UInt16 Value;
            
            Value = data[i+2] | data[i+1] << 8;
            
            //Post notification that sensor value changed
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"sensorValueChanged"
             object:[User shared]];
            
            //Filter out outliers outside absolute min and max
            if (Value > 100 && Value < 700){
                self.rawStretchSensorValue = Value;
            }
            
            
            //plot value mapping (these values are a little counter intuitive because the min is high and the max is low
            CGFloat refInMax = [userCalibratedMaxSensorValue floatValue];//reference max determined by experimentation with sensor bands (this will calibrate dynamically)
            CGFloat refInMin = [userCalibratedMinSensorValue floatValue];//reference min determined by experimentation with sensor bands (this will calibrate dynamically)
            
            
            //dynamic calibration block
            CGFloat pastValue;
            CGFloat outMax = 1.0;
            CGFloat outMin = 0;
            CGFloat in = self.rawStretchSensorValue;
            CGFloat out = outMax + (outMin - outMax) * (in - refInMax) / (refInMin - refInMax);
            self.userCurrentLungVolume = out;
            pastValue = out;
            
            
            double delayInSeconds = 0.5;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                //code to be executed on the main queue after delay
                [self calculateBreathingDeltaWithPastValue:pastValue];
            });
        }
    }
}

//Calculate the delta by comparing the passed in sample from ~0.5 seconds ago to the current sample
-(void)calculateBreathingDeltaWithPastValue: (CGFloat) pastValue{
    CGFloat delta = pastValue - [[User shared] userCurrentLungVolume];
    NSLog(@"\n Delta:%f \n", delta);
    [[User shared] setUserCurrentBreathingDelta:[NSNumber numberWithFloat:delta]];
    
    
    CGFloat pastValue2 = delta;
    //Subsample the fake value for calculating the delta
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //code to be executed on the main queue after delay
        [self calculateBreathingDeltaDeltaWithPastValue:pastValue2];
    });
    
}

-(void)calculateBreathingDeltaDeltaWithPastValue: (CGFloat) pastValue{
    CGFloat deltadelta = pastValue - [[User shared] userCurrentBreathingDelta].floatValue;
    NSLog(@"\n Deltadelta:%f \n", deltadelta);
    [[User shared] setUserCurrentBreathingDeltaDelta:[NSNumber numberWithFloat:deltadelta]];
}


-(void)calculateTotalBreathCoherence{
    CGFloat breathCount = [[User shared] userBreathCount];
    CGFloat userTargetDepth = [[User shared] userTargetDepth].floatValue;
    CGFloat totalCoherence;
    CGFloat currentCoherence;
    CGFloat pastValue;
    
    
    CGFloat targetTotalVolume = breathCount * userTargetDepth;
    //make sure calibratedMaxVolume is getting caluclated first so this isn't nil
    CGFloat currentVolume = breathCount * self.userCalibratedMaxVolume.floatValue;
    
    //Total coherence = target volume vs. volume breathed (check every complete inhale)
    //Current coherence = delta target volume vs. delta volume breathed (check every half complete breath)
    
    //make sure current user calibrated
    totalCoherence = targetTotalVolume/self.userCalibratedMaxVolume.floatValue;
    
    self.userTotalBreathCoherence = [NSNumber numberWithFloat:totalCoherence];
    
    pastValue = totalCoherence;
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //code to be executed on the main queue after delay
        [self calculateBreathCoherenceDeltaWithPastValue:pastValue];
    });
}

-(void)calculateBreathCoherenceDeltaWithPastValue:(CGFloat)pastValue{
    CGFloat coherenceDelta = pastValue - self.userTotalBreathCoherence.floatValue;
    self.userTotalBreathCoherenceDelta = [NSNumber numberWithFloat:coherenceDelta];
        NSLog(@"coherence delta = %f" , coherenceDelta);
}

//gets called when calculateBreathCount hits a peak in lung volume
-(void)calibrateMaxVolume{
    [self setUserCalibratedMaxSensorValue:[NSNumber numberWithFloat:self.rawStretchSensorValue]];
    [self setUserCalibratedMaxVolume:[NSNumber numberWithFloat:self.userCurrentLungVolume]];
    NSLog(@"Max volume = %1.0f" , self.userCurrentLungVolume);
    NSLog(@"Max sensor = %hu" , self.rawStretchSensorValue);
    //calling calculate here ensures this is the peak inhale volume (max volume)
    [self calculateTotalBreathCoherence];

}
//gets called when calculateBreathCount hits a dip in lung volume
-(void)calibrateMinVolume{
    [self setUserCalibratedMinSensorValue:[NSNumber numberWithFloat:self.rawStretchSensorValue]];
    [self setUserCalibratedMinVolume:[NSNumber numberWithFloat:self.userCurrentLungVolume]];
    NSLog(@"Min volume = %1.0f" , self.userCurrentLungVolume);
    NSLog(@"Min sensor = %hu" , self.rawStretchSensorValue);
}



//number of breaths taken with some target breathing pattern
-(void)calculateBreathCount{
    double tmpBreathCount = [[User shared] userBreathCount];
    
    if (inhaleCheck == 0) {
        if ([[User shared] userCurrentBreathingDeltaDelta].floatValue >= 0.05){
            NSLog(@"Max inhale");
            tmpBreathCount = tmpBreathCount + 0.5;
            inhaleCheck++;//increment to prevent re-counting inhale
            exhaleCheck = 0;//set to zero to allow counting of exhale
            [self calibrateMaxVolume];
        }
        
    }
    
    if (exhaleCheck == 0){
        if ([[User shared] userCurrentBreathingDeltaDelta].floatValue <= -0.05){
            NSLog(@"Max Exhale");
            tmpBreathCount = tmpBreathCount + 0.5;
            exhaleCheck++;//increment to prevent re-counting exhale
            inhaleCheck = 0;//set to zero to allow counting of exhale
            [self calibrateMinVolume];
        }
        
    }
    
    
    [[User shared] setUserBreathCount:tmpBreathCount];
    NSLog(@"\nbreath count = %f\n", [[User shared] userBreathCount]);
}


@end
