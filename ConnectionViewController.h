//
//  TableViewController.h
//  SimpleControl
//
//  Created by Cheong on 7/11/12.
//  Copyright (c) 2012 RedBearLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLE.h"
#import "MantraUser.h"

@interface ConnectionViewController : UITableViewController
{
    IBOutlet UIButton *btnConnect;
    IBOutlet UISwitch *swDigitalIn;
    IBOutlet UISwitch *swDigitalOut;
    IBOutlet UISwitch *swAnalogIn;
    IBOutlet UILabel *lblAnalogIn;
    IBOutlet UISlider *sldPWM;
    IBOutlet UISlider *sldServo;
    IBOutlet UIActivityIndicatorView *indConnecting;
    IBOutlet UILabel *lblRSSI;
    IBOutlet UISwitch *gravitySwitch;
}

    
-(void)sensorValueChanged;
-(void)connectionStrengthChanged;
-(void)bleConnected;
-(void)bleDisconnected;
- (IBAction)toggleGravity;
-(void)updateConnectionButtonState;
@end
