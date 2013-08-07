#import "ConnectionViewController.h"


@interface ConnectionViewController ()

@end

@implementation ConnectionViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;    
}


- (void)viewDidLoad
{
     self.view.userInteractionEnabled = TRUE;
    
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(sensorValueChanged)
     name:@"sensorValueChanged"
     object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(connectionStrengthChanged)
     name:@"connectionStrengthChanged"
     object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(bleConnected)
     name:@"bleConnected"
     object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(bleDisconnected)
     name:@"bleDisconnected"
     object:nil];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableView addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;
    
    [self updateConnectionButtonState];
   
   
}

- (void)hideKeyboard{
    [self.view endEditing:YES];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //Iterate through your subviews, or some other custom array of views
    for (UIView *view in self.view.subviews)
        [view resignFirstResponder];
}


-(void)updateConnectionButtonState{
    if ([[MantraUser shared] bleIsConnected] == false){
        [btnConnect setTitle:@"Connect" forState:UIControlStateNormal];
    }
    else {
        [btnConnect setTitle:@"Disconnect" forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - BLE delegate
-(void)sensorValueChanged
{
    NSLog(@"sensor value changed!");
}
    
-(void)connectionStrengthChanged{
    NSLog(@"connection strength changed!");
    lblRSSI.text = [[MantraUser shared] connectionStrength].stringValue;
}

// When disconnected, this will be called
- (void)bleDisconnected
{
    NSLog(@"->Disconnected");

    [btnConnect setTitle:@"Connect" forState:UIControlStateNormal];
    [indConnecting stopAnimating];
    
    lblAnalogIn.enabled = false;
    swDigitalOut.enabled = false;
    swDigitalIn.enabled = false;
    swAnalogIn.enabled = false;
    sldPWM.enabled = false;
    sldServo.enabled = false;
    
    lblRSSI.text = @"---";
    lblAnalogIn.text = @"----";
}

// When Connected, this will be called
-(void) bleConnected
{
    NSLog(@"->Connected");

    [indConnecting stopAnimating];
    
    lblAnalogIn.enabled = true;
    swDigitalOut.enabled = true;
    swDigitalIn.enabled = true;
    swAnalogIn.enabled = true;
    sldPWM.enabled = true;
    sldServo.enabled = true;
    
    swDigitalOut.on = false;
    swDigitalIn.on = false;
    swAnalogIn.on = false;
    sldPWM.value = 0;
    sldServo.value = 0;
}


#pragma mark - Actions

// Connect button will call to this
- (IBAction)btnScanForPeripherals:(id)sender
{
  
    [btnConnect setEnabled:false];

    
    [[MantraUser shared] scanForPeripherals];
        
    
    //make the call to MantraUser's scanForPeripherals here
   
    
    [NSTimer scheduledTimerWithTimeInterval:(float)2.0 target:self selector:@selector(connectionTimer:) userInfo:nil repeats:NO];
   
    [indConnecting startAnimating];
}

-(void) connectionTimer:(NSTimer *)timer
{
    
    [btnConnect setTitle:@"Disconnect" forState:UIControlStateNormal];
    [btnConnect setEnabled:true];
    
    if ([[MantraUser shared] ble].peripherals.count > 0)
    {
        [[[MantraUser shared] ble] connectPeripheral:[[[MantraUser shared] ble].peripherals objectAtIndex:0]];
    }
    else
    {
        [btnConnect setTitle:@"Connect" forState:UIControlStateNormal];
        [indConnecting stopAnimating];
    }
}

-(IBAction)sendDigitalOut:(id)sender
{
    UInt8 buf[3] = {0x01, 0x00, 0x00};
    
    
    if (swDigitalOut.on)
        buf[1] = 0x01;
    else
        buf[1] = 0x00;
    
    NSData *data = [[NSData alloc] initWithBytes:buf length:3];
    [[[MantraUser shared] ble] write:data];
}

/* Send command to Arduino to enable analog reading */
-(IBAction)sendAnalogIn:(id)sender
{
    UInt8 buf[3] = {0xA0, 0x00, 0x00};
    
    NSLog(@"you touched the switch");
    if (swAnalogIn.on){
        buf[1] = 0x01;
        NSLog(@"wrote data");}
    else{
        buf[1] = 0x00;
        NSLog(@"wrote no data");}
    
    NSData *data = [[NSData alloc] initWithBytes:buf length:3];
    [[[MantraUser shared] ble] write:data];
}

// PWM slide will call this to send its value to Arduino
-(IBAction)sendPWM:(id)sender
{
    UInt8 buf[3] = {0x02, 0x00, 0x00};
    
    buf[1] = sldPWM.value;
    buf[2] = (int)sldPWM.value >> 8;
    
    NSData *data = [[NSData alloc] initWithBytes:buf length:3];
    [[[MantraUser shared] ble] write:data];
}

// Servo slider will call this to send its value to Arduino
-(IBAction)sendServo:(id)sender
{
    UInt8 buf[3] = {0x03, 0x00, 0x00};
    
    buf[1] = sldServo.value;
    buf[2] = (int)sldServo.value >> 8;
    
    NSData *data = [[NSData alloc] initWithBytes:buf length:3];
    [[[MantraUser shared] ble] write:data];
}

@end
