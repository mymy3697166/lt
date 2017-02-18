//
//  LTForgetPwdVc.m
//  lt
//
//  Created by zjz on 17/2/17.
//  Copyright © 2017年 zjz. All rights reserved.
//

#import "LTForgetPwdVc.h"

@interface LTForgetPwdVc () {
  __weak IBOutlet UITextField *tfUid;
  __weak IBOutlet UITextField *tfCode;
  __weak IBOutlet UIButton *btnCode;
  __weak IBOutlet UITextField *tfPwd;
  __weak IBOutlet UIButton *btnReset;
}

@end

@implementation LTForgetPwdVc

- (void)viewDidLoad {
  [super viewDidLoad];
  btnReset.layer.cornerRadius = 20;
}

- (IBAction)codeClick:(UIButton *)sender {
  if (![tfUid.text testByRegular:@"^1\\d{10}$"]) {
    [Cm info:@"请输入有效手机号"];
    return;
  }
  AVQuery *query = [AVQuery queryWithClassName:@"_User"];
  [query whereKey:@"mobilePhoneNumber" equalTo:tfUid.text];
  [Cm showLoading];
  [query countObjectsInBackgroundWithBlock:^(NSInteger number, NSError *error) {
    if (number == 0) {
      [Cm hideLoading];
      [Cm info:@"该手机号未注册"];
      return;
    }
    [User requestPasswordResetWithPhoneNumber:tfUid.text block:^(BOOL succeeded, NSError *error) {
      [Cm hideLoading];
      if (error) {
        [Cm info:@"网络异常，请稍后重试"];
        NSLog(@"%@", error);
        return;
      }
      [self startCount];
    }];
  }];
}

- (void)startCount {
  btnCode.enabled = NO;
  [btnCode setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
  __block int s = 60;
  __block NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer *t) {
    s--;
    if (s == 0) {
      [timer invalidate];
      timer = nil;
      btnCode.titleLabel.text = @"重新获取";
      btnCode.enabled = YES;
      [btnCode setTitle:@"重新获取" forState:UIControlStateNormal];
      [btnCode setTitleColor:RGB(102, 204, 255) forState:UIControlStateNormal];
      return;
    }
    NSString *ss = [NSString stringWithFormat:@"重新获取(%d)", s];
    btnCode.titleLabel.text = ss;
    [btnCode setTitle:ss forState:UIControlStateNormal];
  }];
  [timer fire];
}

- (IBAction)resetClick:(UIButton *)sender {
  if (![tfUid.text testByRegular:@"^1\\d{10}$"]) {
    [Cm info:@"请输入有效手机号"];
    return;
  }
  if ([tfCode.text isEqualToString:@""]) {
    [Cm info:@"请输入验证码"];
    return;
  }
  if (![tfPwd.text testByRegular:@".{6,20}"]) {
    [Cm info:@"请输入6-20位密码"];
    return;
  }
  [Cm showLoading];
  [User resetPasswordWithSmsCode:tfCode.text newPassword:tfPwd.text block:^(BOOL succeeded, NSError *error) {
    [Cm hideLoading];
    if (error) {
      if (error.code == 603) [Cm info:@"验证码无效"];
      else [Cm info:@"网络异常，请稍后重试"];
      NSLog(@"%@", error);
      return;
    }
    [self.navigationController popViewControllerAnimated:YES];
  }];
}

- (IBAction)bgClick:(UITapGestureRecognizer *)sender {
  [tfUid resignFirstResponder];
  [tfPwd resignFirstResponder];
  [tfCode resignFirstResponder];
}
@end
