#import "DataGenerator.h"
#import "User.h"


@implementation DataGenerator {}


    
+ (DataGenerator *)shared
    {
        DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
            return [[self alloc] init];
        });
    }
    
-(DataGenerator *)init{
    self = [super init];
    
    self.fakeUserBreathingOn = NO;
    self.fakeUserBreathingRate = 0;
    self.fakeUserExhaleTime = 0;
    self.fakeUserInhaleTime = 0;
    self.fakeUserCurrentMaxStretchValue = 0;
    self.fakeUserCurrentMinStretchValue = 0;
    self.sensorVal = 0;

    return self;
}

-(void)startFakeBreathing{
    
    self.sensorVal = 770;
    self.fakeUserCurrentSensorValue = self.sensorVal;
    self.fakeUserBreathingOn = YES;
    self.sampleTime = .05; //sample rate for the fake sensor is 100 ms
    
    /*incrementSize needs to be calculated because the volume needs to increment at a more natural rate.  You must get to the maxVolume in inhaleTime - so the natural increment size is determined by taking (the amount you need to increment) / (the number of samples you will take)
     */
    //set initial inhale delta size
    self.deltaSize  = (self.fakeUserCurrentMaxStretchValue-self.fakeUserCurrentSensorValue)/(self.fakeUserInhaleTime/self.sampleTime);
    [self fakeInhale];
}


-(void)stopFakeBreathing{
    //this might be a problem later, might not want to set these to 0
    [self.inhaleTimer invalidate];
    self.inhaleTimer = nil;
    [self.exhaleTimer invalidate];
    self.exhaleTimer = nil;
    self.fakeUserBreathingOn = NO;
    [self printFakeDataToConsole];
    NSLog(@"fake breathing stopped");
}
    
-(void)fakeInhale{
    //Fake inhale will increment sensorval and continue to call itself until the total elapsed sampling time = the inhale rate
    
    if(self.fakeUserBreathingOn == YES){
        
        
        if (self.fakeUserCurrentSensorValue < self.fakeUserCurrentMaxStretchValue) {
            if (self.inhaleTimer == nil){
            //set a timer to call self until the above condition is no longer true
            self.inhaleTimer = [[NSTimer alloc] init];
            self.inhaleTimer = [NSTimer scheduledTimerWithTimeInterval:self.sampleTime target:self selector:@selector(fakeInhale) userInfo:nil repeats:YES];
            }
            self.fakeUserCurrentSensorValue = self.fakeUserCurrentSensorValue + self.deltaSize;
            [self printFakeDataToConsole];
            [self loadFakeLungValIntoMantraUser];
        }
        else{
            //set exhale delta size
            self.deltaSize  = (self.fakeUserCurrentMinStretchValue-self.fakeUserCurrentSensorValue)/(self.fakeUserExhaleTime/self.sampleTime);
            
            //invalidate the secondary timer and call fakeExhale
            [self.inhaleTimer invalidate];
            self.inhaleTimer = nil;
            [self fakeExhale];
        }

    }
}
    
-(void)fakeExhale{

    if(self.fakeUserBreathingOn == YES){
        
        if (self.fakeUserCurrentSensorValue > self.fakeUserCurrentMinStretchValue) {
            
            //set a timer to call self until the above condition is no longer true
            if (self.exhaleTimer == nil){
                //set a timer to call self until the above condition is no longer true
                self.exhaleTimer = [[NSTimer alloc] init];
                self.exhaleTimer = [NSTimer scheduledTimerWithTimeInterval:self.sampleTime target:self selector:@selector(fakeExhale) userInfo:nil repeats:YES];
            }
                        
            self.fakeUserCurrentSensorValue = self.fakeUserCurrentSensorValue + self.deltaSize;
            [self printFakeDataToConsole];
            [self loadFakeLungValIntoMantraUser];

        }
        else{
            //set inhale delta size
            self.deltaSize  = (self.fakeUserCurrentMaxStretchValue-self.fakeUserCurrentSensorValue)/(self.fakeUserInhaleTime/self.sampleTime);
            //invalidate the secondary timer and call fakeExhale
            [self.exhaleTimer invalidate];
            self.exhaleTimer = nil;
            [self fakeInhale];
        }
        
    }

}
    
-(void)printFakeDataToConsole{
   //NSLog(@"fake_sensorVal: %hu", self.sensorVal);
    NSLog(@"fakeUserCurrentVolume: %f", self.fakeUserCurrentSensorValue);
    NSLog(@"fake_inhaleRate: %f", self.fakeUserInhaleTime);
   
    NSLog(@"fake_exhaleRate: %f", self.fakeUserExhaleTime);
    NSLog(@"deltaSize: %f", self.deltaSize);
}


-(void)loadFakeLungValIntoMantraUser{//refactor, this is not lungVal anymore
    //Post notification that sensor value changed
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"fakeSensorValueChanged"
     object:[DataGenerator shared]];
    
    CGFloat refInMax = 800;//self.fakeUserGlobalMaxSensorValue;
    CGFloat refInMin = 760;//self.fakeUserGlobalMinSensorValue;
    

    CGFloat pastValue;
    CGFloat outMax = 1.0;
    CGFloat outMin = 0;
    CGFloat in = self.fakeUserCurrentSensorValue;
    [[User shared] setRawStretchSensorValue:self.fakeUserCurrentSensorValue];
    CGFloat out = outMax + (outMin - outMax) * (in - refInMax) / (refInMin - refInMax);
  
    self.fakeUserCurrentVolume = 1 - out;//inverting this value because high volume = low sensor value
    [[User shared] setUserCurrentLungVolume:self.fakeUserCurrentVolume];
    [[User shared] calculateBreathCount];
    //Store a value to compare to the subsample ~0.5 seconds later
    pastValue = out;
    //Subsample the fake value for calculating the delta
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //code to be executed on the main queue after delay
        [[User shared] calculateBreathingDeltaWithPastValue:pastValue];
    });
}



@end