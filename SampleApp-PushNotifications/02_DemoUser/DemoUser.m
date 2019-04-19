//
//  DemoUser.m
//  SampleApp-PushNotifications
//
//  Created by Budhabhooshan Patil on 04/04/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "DemoUser.h"

@interface DemoUser()
@end


@implementation DemoUser
-(id)initDemoUserWithUserName:(NSString *)userName userUID:(NSString *)uid andImage:(UIImage *)profileImage{
    
    self = [super init];
    if(self)
    {
        self.userName = userName;
        self.uid = uid;
        self.profileImage = profileImage;
    }
    return self;
}
+(void)Present:(UIViewController *)viewController on:(id)target{
    
    [target presentViewController:viewController animated:YES completion:nil];
}
@end
