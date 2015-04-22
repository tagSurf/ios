//
//  AppDelegate.m
//  tagSurf
//
//  Refactored by Paul Lacey on 12/01/14.
//  Copyright (c) 2014 tagSurfDev. All rights reserved.
//

#import "AppDelegate.h"
#import "UAConfig.h"
#import "UAirship.h"
#import "UAPush.h"
#import "AGPushNoteView.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Bolts/BFURL.h>
#import "ViewController.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    UAConfig *config = [UAConfig defaultConfig];
    
    [UAirship takeOff:config];
    
    [UAPush shared].userNotificationTypes = (UIUserNotificationTypeAlert |
                                             UIUserNotificationTypeBadge);
    
//    self.viewController = [[ViewController alloc] init];
//    self.window.rootViewController = self.viewController;
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];

}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //self.textView.text = [userInfo description];
    // We can determine whether an application is launched as a result of the user tapping the action
    // button or whether the notification was delivered to the already-running application by examining
    // the application state.
    
    if (application.applicationState == UIApplicationStateActive)
    {
        // Nothing to do if applicationState is Inactive, the iOS already displayed an alert view.
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Did receive a Remote Notification" message:[NSString stringWithFormat:@"Your App name received this notification while it was running:\n%@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]]delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        
//        [alertView show];
        NSString *message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
        if ([message length] != 0)
            [AGPushNoteView showWithNotificationMessage:message];
        
        application.applicationIconBadgeNumber = [[[userInfo objectForKey:@"aps"] objectForKey:@"badge"] integerValue];
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

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    BFURL *parsedUrl = [BFURL URLWithInboundURL:url sourceApplication:sourceApplication];
    ViewController *view = (ViewController *)[[[UIApplication sharedApplication] keyWindow] rootViewController];
    if ([[parsedUrl targetQueryParameters] objectForKey:@"target_url"]) {
        // this is an applink url, handle it here
        NSString *targetUrl = [[parsedUrl targetQueryParameters] objectForKey:@"target_url"];
        self.targetUrl = targetUrl;
        [view loadURL:targetUrl];
    }
    else if ([[url host] isEqualToString:@"card"]) {
        NSString *tag = [[[[url path] componentsSeparatedByString:@"~"] objectAtIndex:0] stringByReplacingOccurrencesOfString:@"/" withString:@""];
        NSString *cardID = [[[url path] componentsSeparatedByString:@"~"] objectAtIndex:1];
        NSLog(@"tag %@", tag);
        [view loadCard:tag cardID:cardID];
    }
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                              openURL:url
                                                    sourceApplication:sourceApplication
                                                           annotation:annotation];
}

@end
