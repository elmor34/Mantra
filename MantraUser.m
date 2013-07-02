//
//  MantraUser.m
//  MantraV1.2
//
//  Created by David Crow on 6/16/13.
//  Copyright (c) 2013 David Crow. All rights reserved.
//

#import "MantraUser.h"


@implementation MantraUser

@synthesize breathingRate, exhaleRate, inhaleRate, maxVolume, minVolume, sensorVal, ble, bleConnected, connectionStrength;


+ (MantraUser *)shared
{
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
    
   
    
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
            [[ble CM] cancelPeripheralConnection:[ble activePeripheral]];
            return;
        }
    
    if (ble.peripherals)
        ble.peripherals = nil;
    
    [ble findBLEPeripherals:2];
    
    [NSTimer scheduledTimerWithTimeInterval:(float)2.0 target:self selector:@selector(connectionTimer:) userInfo:nil repeats:NO];
}

- (void)scanForPeripherals{

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
    bleConnected = YES;
}

-(void) bleDidDisconnect{
    NSLog(@"BLE->Disconnected");
    bleConnected = NO;
}

-(void) bleDidUpdateRSSI:(NSNumber *) rssi{
    connectionStrength = rssi;
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
             object:[MantraUser shared]];
            
            //Filter out outliers outside absolute min and max
            if (Value > 100 && Value < 700){
                self.sensorVal = Value;
            }
            
            
            //plot value mapping (these values are a little counter intuitive because the min is high and the max is low
            CGFloat refInMax = 300.0;//reference max determined by experimentation with sensor bands (this will calibrate dynamically)
            CGFloat refInMin = 530.0;//reference min determined by experimentation with sensor bands (this will calibrate dynamically)
            
            
            //dynamic calibration block
            
            CGFloat outMax = 1.0;
            CGFloat outMin = 0;
            CGFloat in = self.sensorVal;
            CGFloat out = outMax + (outMin - outMax) * (in - refInMax) / (refInMin - refInMax);
            self.lungVal = out;
            
        }
    }
}


@end
