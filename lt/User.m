//
//  User.m
//  lt
//
//  Created by zjz on 2017/2/8.
//  Copyright © 2017年 zjz. All rights reserved.
//

#import "User.h"
#import "LTCommon.h"

@implementation User
@dynamic nickName;
@dynamic avatar;
@dynamic gender;
@dynamic dob;
@dynamic tags;

+ (NSString *)parseClassName {return @"_User";}
+ (void)registerWithUid:(NSString *)uid andPwd:(NSString *)pwd andCode:(NSString *)code withBlock:(void (^)())block {
  [Cm showLoading];
  [Cm requestQueue:^{
    NSError *error;
    User *user = [User signUpOrLoginWithMobilePhoneNumber:uid smsCode:code error:&error];
    if (error) {
      NSLog(@"%@", error);
      [Cm hideLoading];
      [Cm info:@"网络异常，请稍后重试"];
      return;
    }
    user.password = pwd;
    [user save:&error];
    if (error) {
      NSLog(@"%@", error);
      [Cm hideLoading];
      [Cm info:@"网络异常，请稍后重试"];
      return;
    }
    [User logInWithMobilePhoneNumber:uid password:pwd error:&error];
    if (error) {
      NSLog(@"%@", error);
      [Cm hideLoading];
      [Cm info:@"网络异常，请稍后重试"];
      return;
    }
    [Cm hideLoading];
    dispatch_sync(dispatch_get_main_queue(), ^{block();});
  }];
}
+ (void)loginWithUid:(NSString *)uid andPwd:(NSString *)pwd {
  [Cm showLoading];
  [User logInWithMobilePhoneNumberInBackground:uid password:pwd block:^(AVUser *user, NSError *error) {
    [Cm hideLoading];
    if (error) {
      NSLog(@"%@", error);
      if (error.code == 210) [Cm info:@"密码错误"];
      else if (error.code == 211) [Cm info:@"手机号未注册"];
      else if (error.code == 219) [Cm info:@"登录失败次数超过限制，请在15分钟后再试"];
      else [Cm info:@"网络不给力，请稍后再试"];
      return;
    }
    [N postNotificationName:@"N_LOGIN_SUCCESS" object:nil];
  }];
}
@end
