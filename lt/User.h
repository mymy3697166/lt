//
//  User.h
//  lt
//
//  Created by zjz on 2017/2/8.
//  Copyright © 2017年 zjz. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface User : AVUser<AVSubclassing>
@property (strong, nonatomic) AVRelation *tags;
@property (strong, nonatomic) NSString *nickName;
@property (strong, nonatomic) AVFile *avatar;
@property (strong, nonatomic) NSString *gender;
@property (strong, nonatomic) NSDate *dob;

+ (void)registerWithUid:(NSString *)uid andPwd:(NSString *)pwd andCode:(NSString *)code withBlock:(void(^)())block;
+ (void)loginWithUid:(NSString *)uid andPwd:(NSString *)pwd;
@end
