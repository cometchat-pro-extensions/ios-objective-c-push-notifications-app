//
//  AppConstants.h
//  SampleApp-PushNotifications
//
//  Created by Budhabhooshan Patil on 04/04/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#ifndef AppConstants_h
#define AppConstants_h

#import <CometChatPro/CometChatPro-Swift.h>


#define UID                 "sender_uid_here"
#define API_KEY             "api_key_here"
#define APP_ID              "app_id_here"

#define IS_IPAD   ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define IS_IPHONE ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)

#define paddingX                8.0f
#define paddingY                8.0f

#import "LoginViewController.h"
#import "DemoUser.h"
#import "DemoUsersViewController.h"
#import "SendPushViewController.h"
@import Firebase;

#endif /* AppConstants_h */
