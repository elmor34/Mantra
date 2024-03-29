#import "ConnectionViewController.h"


@interface ConnectionViewController ()
{
    bool editingRow;
    bool loadService;
}
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
    
    
    //scanviewstart
    int numberOfLines = 3;
    self.tableView.rowHeight = (44.0 + (numberOfLines - 1) * 19.0);
    
    UIColor *start = [UIColor colorWithRed:58/255.0 green:108/255.0 blue:183/255.0 alpha:0.15];
    UIColor *stop = [UIColor colorWithRed:58/255.0 green:108/255.0 blue:183/255.0 alpha:0.45];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    // gradient.frame = [self.view bounds];
    gradient.frame = CGRectMake(0.0, 0.0, 1024.0, 1024.0);
    gradient.colors = [NSArray arrayWithObjects:(id)start.CGColor, (id)stop.CGColor, nil];
    [self.tableView.layer insertSublayer:gradient atIndex:0];
    //scanviewend
    
    
    //RFduino manager notifications from User singleton
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(didDiscoverRFduino)
     name:@"didDiscoverRFduino"
     object:nil];
                        
    
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(didUpdateDiscoveredRFduino)
     name:@"didUpdateDiscoveredRFduino"
     object:nil];
    
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(didConnectRFduino)
     name:@"didConnectRFduino"
     object:nil];
    
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(didLoadServiceRFduino)
     name:@"didLoadServiceRFduino"
     object:nil];
    
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(didDisconnectRFduino)
     name:@"didDisconnectRFduino"
     object:nil];
    
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableView addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;
    
   // [self updateConnectionButtonState];
   
   
}

- (void)hideKeyboard{
    [self.view endEditing:YES];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //Iterate through your subviews, or some other custom array of views
    for (UIView *view in self.view.subviews)
        [view resignFirstResponder];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - RFDuino Manager notifications via User
- (void)didDiscoverRFduino
{
    NSLog(@"didDiscoverRFduino");
    if (! editingRow) {
        NSLog(@"reloadData");
        [self.tableView reloadData];
    }
}
- (void)didUpdateDiscoveredRFduino
{
    // NSLog(@"didUpdateRFduino");
    if (! editingRow) {
        [self.tableView reloadData];
    }
}
- (void)didConnectRFduino
{
    NSLog(@"didConnectRFduino");
    
    [[[User shared] rfduinoManager] stopScan];
    
    loadService = false;
}
- (void)didLoadServiceRFduino
{
    //    AppViewController *viewController = [[AppViewController alloc] init];
    //    viewController.rfduino = rfduino;
    //
    //    loadService = true;
    //    [[self navigationController] pushViewController:viewController animated:YES];
}
- (void)didDisconnectRFduino
{
    NSLog(@"didDisconnectRFduino");
    
    if (loadService) {
        [[self navigationController] popViewControllerAnimated:YES];
    }
    
    [[[User shared] rfduinoManager] startScan];
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[[User shared] rfduinoManager] rfduinos] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSMutableArray *signalStrength = nil;
    if (! signalStrength) {
        signalStrength = [[NSMutableArray alloc] init];
    }
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        
        UIProgressView *view = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleBar];
        view.frame = CGRectMake(0.0, 0.0, 150.0, 0.0);
        view.center = CGPointMake(225,14);
        view.progressViewStyle = UIProgressViewStyleDefault;
        view.progressTintColor = [UIColor colorWithRed:0.0 green:0.5 blue:0.0 alpha:1.0];
        
        [cell addSubview:view];
        
        [signalStrength setObject:view atIndexedSubscript:indexPath.row];
    }
    
    RFduino *rfduino = [[[User shared] rfduinoManager].rfduinos objectAtIndex:[indexPath row]];
    
    UIColor *start;
    UIColor *stop;
    if (rfduino.outOfRange) {
        start = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:0.8];
        stop = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:0.2];
    } else if (! rfduino.UUID.length) {
        start = [UIColor colorWithRed:224/255.0 green:242/255.0 blue:224/255.0 alpha: 1.0];
        stop = [UIColor colorWithRed:224/255.0 green:242/255.0 blue:224/255.0 alpha: 0.7];
    } else {
        start = [UIColor colorWithRed:253/255.0 green:255/255.0 blue:255/255.0 alpha: 1.0];
        stop = [UIColor colorWithRed:253/255.0 green:255/255.0 blue:255/255.0 alpha: 0.7];
    }
    
    CustomCellBackground *ccb = [[CustomCellBackground alloc] init];
    ccb.startColor = start;
    ccb.stopColor = stop;
    cell.backgroundView = ccb;
    
    NSString *text = [[NSString alloc] initWithFormat:@"%@", rfduino.name];
    
    NSString *uuid = rfduino.UUID;
    
    int rssi = rfduino.advertisementRSSI.intValue;
    
    NSString *advertising = @"";
    if (rfduino.advertisementData) {
        advertising = [[NSString alloc] initWithData:rfduino.advertisementData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableString *detail = [NSMutableString stringWithCapacity:100];
    [detail appendFormat:@"RSSI: %d dBm", rssi];
    while ([detail length] < 25)
        [detail appendString:@" "];
    [detail appendFormat:@"Packets: %d\n", rfduino.advertisementPackets];
    [detail appendFormat:@"Advertising: %@\n", advertising];
    [detail appendFormat:@"%@", uuid];
    
    cell.textLabel.text = text;
    cell.detailTextLabel.text = detail;
    cell.detailTextLabel.numberOfLines = 3;
    
    if (indexPath.row < signalStrength.count) {
        UIProgressView *view = [signalStrength objectAtIndex:indexPath.row];
        if (view) {
            int value = rssi;
            
            // only interested in graphing the rssi range between -75 and -103
            if (value > -75) {
                value = -75;
            }
            if (value < -103) {
                value = -103;
            }
            
            // translate rssi to signal strength between 0 and 28
            value += 103;
            
            // calculate ratio
            float ratio = (float)value / (-75 - -103);
            
            // moving average over 20 samples
            int samples = 20;
            if ([advertising hasPrefix:@"-"]) {
                // device using non-default avertising (switch the instaneous sampling)
                samples = 1;
            }
            
            if (view.progress == 0.0) {
                // use the instantaneous value for the first sample
                view.progress = ratio;
            } else {
                view.progress = (ratio * 1.0/samples) + (view.progress * (samples - 1.0)/samples);
            }
        }
    }
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    RFduino *rfduino = [[[User shared] rfduinoManager].rfduinos objectAtIndex:[indexPath row]];
    // Return NO if you do not want the specified item to be editable.
    return (rfduino.outOfRange ? YES : NO);
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    editingRow = true;
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    editingRow = false;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [[[User shared] rfduinoManager].rfduinos removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    /*
     else if (editingStyle == UITableViewCellEditingStyleInsert) {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     */
}

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RFduino *rfduino = [[[[User shared] rfduinoManager] rfduinos] objectAtIndex:[indexPath row]];
    
    if (! rfduino.outOfRange) {
        [[[User shared] rfduinoManager] connectRFduino:rfduino];
    } else {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}


- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
