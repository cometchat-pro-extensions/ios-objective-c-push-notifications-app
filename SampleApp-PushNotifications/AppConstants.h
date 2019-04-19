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


#define UID                 "3"
#define API_KEY             "5c4d759dd3b084b88b0541cdffa77c018b25dded"//3de4f1672b44a43f1593ea03a27e3b3202a3869b//083e6894e7cd4b75348a607f254166b1f41462ef//
#define APP_ID              "2138954385ae5e"//6e13b23d7a3//337beda0759d2//

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
