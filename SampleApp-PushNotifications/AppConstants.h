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


#define API_KEY             "YOUR_API_KEY"
#define APP_ID              "YOUR_APP_ID"

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
