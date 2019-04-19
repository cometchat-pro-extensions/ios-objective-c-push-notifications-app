//
//  DemoUsersViewController.h
//  SampleApp-PushNotifications
//
//  Created by Budhabhooshan Patil on 04/04/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"

NS_ASSUME_NONNULL_BEGIN

@protocol demoUserDelegate <NSObject>

@required -(void)selectedUser:(DemoUser *)selectedUSer;

@end


@interface DemoUsersViewController : UIViewController

@property (nonatomic, weak) id<demoUserDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
