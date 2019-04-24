//
//  AppDelegate.m
//  SampleApp-PushNotifications
//
//  Created by Budhabhooshan Patil on 03/04/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "AppDelegate.h"
@import CometChatPro;
@import Firebase;
@import UserNotifications;
@interface AppDelegate ()<FIRMessagingDelegate,UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /**
     * init cometchat
     **/
    [[CometChat alloc]initWithAppId:@APP_ID onSuccess:^(BOOL isSuccess) {
        
        isSuccess? NSLog(@"YES"):NSLog(@"NO");
        
    } onError:^(CometChatException * _Nonnull error) {
        
        NSLog(@"E R R O R  %@",[error errorDescription]);
        
    }];
    
    /**
     * configure firebase
     **/
    [FIRApp configure];
    [FIRMessaging messaging].delegate = self;
    
    /**
     * ask premission from user to show push notifications
     **/
    if ([UNUserNotificationCenter class]) {
        
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
        UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:authOptions completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
            granted? NSLog(@"granted"):NSLog(@"%@",[error localizedDescription]);
            
        }];
    }
    
    /**
     * regiter for remote notifications
     **/
    [application registerForRemoteNotifications];
    
    return YES;
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    
    /**
     * something went wrong , push notification needs physical devices , won't work on simulators
     **/
    NSLog(@"Unable to register for remote notifications: %@", error);
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"APNs device token retrieved: %@", deviceToken);
    [FIRMessaging messaging].APNSToken = deviceToken;
    /**
     * print received notification
     **/
    NSLog(@" TOKEN %@" , [[FIRMessaging messaging] FCMToken]);
    
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    /**
     * print received notification or handle notification tapped in notification center
     **/
    NSLog(@"%@", userInfo);
}
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
    
    /**
     * present notification when app is in forground
     **/
    
    /**
     * print received notification
     **/
    NSDictionary *userInfo = notification.request.content.userInfo;
    NSLog(@"%@", userInfo);
    completionHandler(UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge);
}
@end
