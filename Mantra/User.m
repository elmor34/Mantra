#import "User.h"

#define kPastValueDelay 0.1 //delay between the current sample and past sample

@implementation User {
    CGFloat inhaleCheck;
    CGFloat exhaleCheck;
    BOOL wasScanning;
}


#pragma Initialization


+ (User *)shared
{
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}


-(User *)init{

    self = [super init];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.userSettings = userDefaults;
    
    [self loadUserSettings];

    [self setUserGlobalMaxStretchValue:[NSNumber numberWithFloat:0]];
    [self setUserGlobalMinStretchValue:[NSNumber numberWithFloat:0]];
    
    self.fakeDataIsOn = NO;
    
    //set up RFduino
    self.rfduinoManager = [RFduinoManager sharedRFduinoManager];
    self.rfduinoManager.delegate = self;
    
    
    return self;
}


- (BOOL) isFirstRun
{
    //set the first run User defaults
    self.userBreathCount = 0;
    self.targetBreathingIsOn = NO;
    self.userTargetVolume = [NSNumber numberWithFloat:1];
    self.userTargetExhaleTime = [NSNumber numberWithFloat:4];
    self.userTargetInhaleTime = [NSNumber numberWithFloat:4];
    self.meterGravityIsOn = YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"isFirstRun"])
    {
        return NO;
    }
    
    [defaults setObject:[NSDate date] forKey:@"isFirstRun"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return YES;
}




#pragma User Settings

-(void)saveUserSettings{

    [self.userSettings setBool:self.targetBreathingIsOn forKey:@"targetBreathingIsOn"];
    [self.userSettings setObject:self.userTargetExhaleTime forKey:@"userTargetExhaleTime"];
    [self.userSettings setObject:self.userTargetInhaleTime forKey:@"userTargetInhaleTime"];
    [self.userSettings setObject:self.userTargetVolume forKey:@"userTargetVolume"];
    
}

-(void)loadUserSettings{
    [self.userSettings synchronize];
    [self setTargetBreathingIsOn:[[self userSettings] boolForKey:@"targetBreathingIsOn"]];
    [self setUserTargetExhaleTime:[[self userSettings] objectForKey:@"userTargetExhaleTime"]];
    [self setUserTargetInhaleTime:[[self userSettings] objectForKey:@"userTargetInhaleTime"]];
    [self.userSettings setObject:self.userTargetVolume forKey:@"userTargetVolume"];
    
    
}

#pragma Bluetooth Low Energy module

- (void)didReceive:(NSData *)data {
    self.rawStretchSensorValue = dataFloat(data);
}

- (void)didDiscoverRFduino:(RFduino *)rfduino
{
    
    self.rfduino = rfduino;
    NSLog(@"did Discover RFduino");
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"didDiscoverRFduino"
     object:[User shared]];
}

- (void)didUpdateDiscoveredRFduino:(RFduino *)rfduino
{
    self.rfduino = rfduino;
    NSLog(@"did Update Discovered RFduino");
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"didUpdateDiscoveredRFduino"
     object:[User shared]];
}

- (void)didConnectRFduino:(RFduino *)rfduino
{
    self.rfduino = rfduino;
    NSLog(@"did Connect RFduino");
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"didConnectRFduino"
     object:[User shared]];
}

- (void)didLoadServiceRFduino:(RFduino *)rfduino
{
    self.rfduino = rfduino;
    NSLog(@"did Load Service RFduino");
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"didLoadServiceRFduino"
     object:[User shared]];
}

- (void)didDisconnectRFduino:(RFduino *)rfduino
{
    self.rfduino = rfduino;
    NSLog(@"did Disconnect RFduino");
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"didDisconnectRFduino"
     object:[User shared]];
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
                NSLog(@"digital in on");
            //   swDigitalIn.on = true;
            else
                NSLog(@"digital in off");
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

            /*value mapping for volume calculation (these values are a little counter intuitive because the min stretch 
            results in a high value and the max stretch results in a low value)
            */
             CGFloat refInMax = [self.userGlobalMinStretchValue floatValue];//reference max determined by experimentation with sensor bands (this will calibrate dynamically)
            /*value mapping for volume calculation (these values are a little counter intuitive because the min stretch
             results in a high value and the max stretch results in a low value)
             */
            CGFloat refInMin = [self.userGlobalMaxStretchValue floatValue];//reference min determined by experimentation with sensor bands (this will calibrate dynamically)
            CGFloat pastValue;
//            CGFloat outMax = 1.0;
//            CGFloat outMin = 0;
//            CGFloat input = self.rawStretchSensorValue;
//            CGFloat output = outMax + (outMin - outMax) * (in - refInMax) / (refInMin - refInMax);
            CGFloat output = [self mapValuesForInput:self.rawStretchSensorValue withInputRangeMin:refInMin andMax:refInMax andOutputRangeMin:0 andMax:1.0];
            self.userCurrentLungVolume = 1 - output;//inverting this value because high volume = low sensor value

            pastValue = output;
            [self calculateTotalBreathCoherence];
            double delayInSeconds = kPastValueDelay;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                //code to be executed on the main queue after delay
                [self calculateBreathingDeltaWithPastValue:pastValue];
            });
        }
    }
}

-(CGFloat)mapValuesForInput:(CGFloat) input withInputRangeMin:(CGFloat)inMin andMax:(CGFloat)inMax andOutputRangeMin:(CGFloat)outMin andMax:(CGFloat) outMax{
    CGFloat output = outMax + (outMin - outMax) * (input - inMax) / (inMin - inMax);;
    return output;
}




#pragma Breath Calculations

//Calculate the delta by comparing the passed in sample from ~kPastValueDelay seconds ago to the current sample
-(void)calculateBreathingDeltaWithPastValue: (CGFloat) pastValue{
    CGFloat delta = pastValue - [[User shared] userCurrentLungVolume];
    NSLog(@"\n Delta:%f \n", delta);
    [[User shared] setUserCurrentBreathingDelta:[NSNumber numberWithFloat:delta]];
    
    
    CGFloat pastValueDelta = delta;
    //Subsample the fake value for calculating the delta
    double delayInSeconds = kPastValueDelay;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //code to be executed on the main queue after delay
        [self calculateBreathingDeltaDeltaWithPastValue:pastValueDelta];
    });
    
}

-(void)calculateBreathingDeltaDeltaWithPastValue: (CGFloat) pastValue{
    CGFloat deltadelta = pastValue - [[User shared] userCurrentBreathingDelta].floatValue;
    CGFloat coherenceDelta = pastValue - self.userTotalBreathCoherence.floatValue;
    self.userTotalBreathCoherenceDelta = [NSNumber numberWithFloat:coherenceDelta];
    self.userCurrentBreathingDeltaDelta = [NSNumber numberWithFloat:deltadelta];
    NSLog(@"coherence delta = %f" , coherenceDelta);
    NSLog(@"\n Deltadelta:%f \n", deltadelta);
}


-(void)calculateTotalBreathCoherence{
    CGFloat pastValue;
    CGFloat breathCount = [[User shared] userBreathCount];
    CGFloat userTargetMaxVolume = [[User shared] userTargetVolume].floatValue;
    CGFloat userCurrentMaxVolume = self.userCurrentMaxVolume.floatValue;
    CGFloat userCurrentMinVolume = self.userCurrentMinVolume.floatValue;
    CGFloat userGlobalMaxVolume = self.userGlobalMaxVolume.floatValue;

    
    CGFloat userTargetTotalVolume = breathCount * userTargetMaxVolume;
    CGFloat userCurrentTotalVolume = breathCount * userCurrentMaxVolume;
    
    //totalCoherence = target volume vs. volume breathed (check every complete inhale)
    CGFloat totalCoherence = userCurrentTotalVolume/userTargetTotalVolume;
    
   

    
    self.userTotalBreathCoherence = [NSNumber numberWithFloat:totalCoherence];
    
    
//    pastValue = totalCoherence;
//    double delayInSeconds = kPastValueDelay;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        //code to be executed on the main queue after delay
//        [self calculateBreathCoherenceDeltaWithPastValue:pastValue];
//    });
}

//-(void)calculateBreathCoherenceDeltaWithPastValue:(CGFloat)pastValue{
//    CGFloat coherenceDelta = pastValue - self.userTotalBreathCoherence.floatValue;
//    self.userTotalBreathCoherenceDelta = [NSNumber numberWithFloat:coherenceDelta];
//        NSLog(@"coherence delta = %f" , coherenceDelta);
//}

//gets called when calculateBreathCount hits a peak in lung volume (when the stretch sensor value is smallest)
-(void)calibrateMaxVolume{
    [self setUserCurrentMaxStretchValue:[NSNumber numberWithFloat:self.rawStretchSensorValue]];
    [self setUserCurrentMaxVolume:[NSNumber numberWithFloat:self.userCurrentLungVolume]];
    
    //the global max stretch should always be <= current max stretch is low
    if (self.rawStretchSensorValue < self.userGlobalMaxStretchValue.floatValue || self.userGlobalMaxStretchValue.floatValue == 0){
        [self setUserGlobalMaxStretchValue:[NSNumber numberWithFloat:self.rawStretchSensorValue]];
    }
    //the global max volume should always be >= current max volume
    if (self.userCurrentLungVolume > self.userGlobalMaxVolume.floatValue || self.userGlobalMaxVolume.floatValue == 0){
        [self setUserGlobalMaxVolume:[NSNumber numberWithFloat:self.userCurrentLungVolume]];
    }
    
    NSLog(@"Max volume = %1.0f" , self.userCurrentLungVolume);
    NSLog(@"Max sensor = %hu" , self.rawStretchSensorValue);
    //calling calculate here ensures this is the peak inhale volume (max volume)
    //[self calculateTotalBreathCoherence];

}
//gets called when calculateBreathCount hits a dip in lung volume (when the stretch sensor value is largest)

-(void)calibrateMinVolume{
    [self setUserCurrentMinStretchValue:[NSNumber numberWithFloat:self.rawStretchSensorValue]];
    [self setUserCurrentMinVolume:[NSNumber numberWithFloat:self.userCurrentLungVolume]];
    
    //the global min stretch should always be >= currentMin min stretch is high
    if (self.rawStretchSensorValue > self.userGlobalMinStretchValue.floatValue || self.userGlobalMinStretchValue.floatValue == 0){
        [self setUserGlobalMinStretchValue:[NSNumber numberWithFloat:self.rawStretchSensorValue]];
    }
    //the global min volume should always be <= current min volume
     if (self.userCurrentLungVolume < self.userGlobalMinVolume.floatValue || self.userGlobalMinVolume == 0){
        [self setUserGlobalMinVolume:[NSNumber numberWithFloat:self.userCurrentLungVolume]];
    }
    
    NSLog(@"Min volume = %1.0f" , self.userCurrentLungVolume);
    NSLog(@"Min sensor = %hu" , self.rawStretchSensorValue);
}

//number of breaths taken with some target breathing pattern
-(void)calculateBreathCount{
    double tmpBreathCount = [[User shared] userBreathCount];
    
    if (exhaleCheck == 0) {
        //change in the rate of the rate of breathing will be positive and non-zero peak Inhale
        if ([[User shared] userCurrentBreathingDeltaDelta].floatValue > 0){
            NSLog(@"Max Inhale");
            //increment breath count by a half breath
            tmpBreathCount = tmpBreathCount + 0.5;
            exhaleCheck++;//increment to prevent re-counting inhale
            inhaleCheck = 0;//set to zero to allow counting of exhale
            [self calibrateMinVolume];
        }
    }
    if (inhaleCheck == 0){
        //change in the rate of the rate of breathing will be negative and non-zero peak exhale
        if ([[User shared] userCurrentBreathingDeltaDelta].floatValue < 0){
            NSLog(@"Max Exhale");
            //increment breath count by a half breath
            tmpBreathCount = tmpBreathCount + 0.5;
            inhaleCheck++;//increment to prevent re-counting exhale
            exhaleCheck = 0;//set to zero to allow counting of exhale
            [self calibrateMaxVolume];
        }
    }
    
    [[User shared] setUserBreathCount:tmpBreathCount];
    NSLog(@"\nbreath count = %f\n", [[User shared] userBreathCount]);
}

@end
