//
//  DemoUser.h
//  SampleApp-PushNotifications
//
//  Created by Budhabhooshan Patil on 04/04/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DemoUser : NSObject
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) UIImage  *profileImage;
-(id)initDemoUserWithUserName:(NSString*)userName userUID:(NSString*)uid andImage:(UIImage*)profileImage;
+(void)Present:(UIViewController *)viewController on:(id)target;

@end

NS_ASSUME_NONNULL_END

