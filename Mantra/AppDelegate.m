//
//  AppDelegate.m
//  MantraV1.2
//
//  Created by David Crow on 6/12/13.
//  Copyright (c) 2013 David Crow. All rights reserved.
//

#import "AppDelegate.h"
#import "DeveloperSettingsViewController.h"
#import "User.h"

@implementation AppDelegate {
    bool wasScanning;
}

+ (void)initialize
{
    
    //configure iRate info here:https://github.com/nicklockwood/iRate
    //    [iRate sharedInstance].daysUntilPrompt = 5;
    //    [iRate sharedInstance].usesUntilPrompt = 10;
    //    [iRate sharedInstance].appStoreID = 123123123;
    //    [iRate sharedInstance].appStoreGenreID = 123123123;
    //    [iRate sharedInstance].applicationName = @"Mantra";
    //    [iRate sharedInstance].applicationBundleID = @"com.JDC.MantraV1-1";
    //    [iRate sharedInstance].message = @"You deserve excellent apps - give feedback and help make this one better";
    //    [iRate sharedInstance].messageTitle = @"Rate Mantra";
    //    [iRate sharedInstance].useAllAvailableLanguages = NO; //app not curretly set up for localization
    //    [iRate sharedInstance].disableAlertViewResizing = YES;//only allow in portrait
    //    [iRate sharedInstance].promptAgainForEachNewVersion = YES;
    //    [iRate sharedInstance].onlyPromptIfLatestVersion = YES;
    //    [iRate sharedInstance].verboseLogging = YES;
    //    [iRate sharedInstance].previewMode = NO; //set this OFF when you are done setting it up
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor redColor]];
  
//    //Connect the closest rfduino
//    RFduino *rfduino = [[User shared] rfduino];
//    
//    if (! rfduino.outOfRange) {
//        [[[User shared] rfduinoManager] connectRFduino:rfduino];
//    } else {
//        NSLog(@"no Mantra bands in range");
//    }
    
    //initialize user singleton
    [User shared];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    if ([[User shared ] rfduinoManager].isScanning) {
        wasScanning = false;
        [[[User shared ] rfduinoManager] startScan];
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *) error {
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {

}

- (void)failIfSimulator {
    if ([[[UIDevice currentDevice] model] compare:@"iPhone Simulator"] == NSOrderedSame) {
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:@"Notice"
                                                            message:@"You will not be able to recieve push notifications in the simulator."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        
        [someError show];
    }
}


							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    wasScanning = false;
    
    if ([[User shared ] rfduinoManager].isScanning) {
        wasScanning = true;
        [[[User shared ] rfduinoManager] stopScan];
    }
    
}



- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


@end
