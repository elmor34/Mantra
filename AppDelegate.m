//
//  AppDelegate.m
//  MantraV1.2
//
//  Created by David Crow on 6/12/13.
//  Copyright (c) 2013 David Crow. All rights reserved.
//

#import "AppDelegate.h"
#import "UAInboxDefaultJSDelegate.h"
#import "UAInboxPushHandler.h"
#import "UAInboxNavUI.h"
#import "UAInboxUI.h"
#import "UAAnalytics.h"
#import "UAirship.h"
#import "UAPush.h"
#import "UAInbox.h"
#import "UAUser.h"
#import "UAInboxMessageList.h"
#import "DeveloperSettingsViewController.h"

@implementation AppDelegate

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

    
    
    
    // Display a UIAlertView warning developers that push notifications do not work in the simulator
    // You should remove this in your app.
    [self failIfSimulator];
    
    // This prevents the UA Library from registering with UIApplcation by default when
    // registerForRemoteNotifications is called. This will allow you to prompt your
    // users at a later time. This gives your app the opportunity to explain the benefits
    // of push or allows users to turn it on explicitly in a settings screen.
    // If you just want everyone to immediately be prompted for push, you can
    // leave this line out.
    [UAPush setDefaultPushEnabledValue:NO];
    
    //Set customHandler as the UAPush delegate
   // CustomPushHandler *customHandler = [[CustomPushHandler alloc] init];
   // [UAPush shared].delegate = customHandler;
    
    //Create Airship options dictionary and add the required UIApplication launchOptions
    NSMutableDictionary *takeOffOptions = [NSMutableDictionary dictionary];
    [takeOffOptions setValue:launchOptions forKey:UAirshipTakeOffOptionsLaunchOptionsKey];
    
    // Call takeOff (which creates the UAirship singleton), passing in the launch options so the
    // library can properly record when the app is launched from a push notification. This call is
    // required.
    //
    // Populate AirshipConfig.plist with your app's info from https://go.urbanairship.com
    [UAirship takeOff:takeOffOptions];
    
    // Set the icon badge to zero on startup (optional)
    [[UAPush shared] resetBadge];
    
    // Register for remote notfications with the UA Library. With the default value of push set to no,
    // UAPush will record the desired remote notifcation types, but not register for
    // push notfications as mentioned above. When push is enabled at a later time, the registration
    // will occur normally. This call is required.
    [[UAPush shared] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                         UIRemoteNotificationTypeSound |
                                                         UIRemoteNotificationTypeAlert)];
    
    
    // Handle any incoming incoming push notifications.
    // This will invoke `handleBackgroundNotification` on your UAPushNotificationDelegate.
    [[UAPush shared] handleNotification:[launchOptions valueForKey:UIApplicationLaunchOptionsRemoteNotificationKey]
                       applicationState:application.applicationState];
    

    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    UA_LDEBUG(@"Application did become active.");
    
    // Set the icon badge to zero on resume (optional)
    [[UAPush shared] resetBadge];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    UA_LINFO(@"APNS device token: %@", deviceToken);
    
    // Updates the device token and registers the token with UA. This won't occur until
    // push is enabled if the outlined process is followed. This call is required.
    [[UAPush shared] registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *) error {
    UA_LERR(@"Failed To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    UA_LINFO(@"Received remote notification: %@", userInfo);
    
    
    
    // Send the alert to UA so that it can be handled and tracked as a direct response. This call
    // is required.
    [[UAPush shared] handleNotification:userInfo applicationState:application.applicationState];
    
    // Reset the badge after a push received (optional)
    [[UAPush shared] resetBadge];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    // Tear down UA services
    [UAirship land];
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
