//
//  LTRegisterVc.m
//  lt
//
//  Created by zjz on 17/2/9.
//  Copyright © 2017年 zjz. All rights reserved.
//

#import "LTRegisterVc.h"

@interface LTRegisterVc () {

  __weak IBOutlet UITextField *tfUid;
  __weak IBOutlet UITextField *tfPwd;
  __weak IBOutlet UITextField *tfCode;
  __weak IBOutlet UIButton *btnCode;
  __weak IBOutlet UIButton *btnRegister;
}

@end

@implementation LTRegisterVc

- (void)viewDidLoad {
  [super viewDidLoad];
  btnRegister.layer.cornerRadius = 20;
  //[self performSegueWithIdentifier:@"register_inputinfo" sender:nil];
}

- (IBAction)codeClick:(UIButton *)sender {
  if (![tfUid.text testByRegular:@"^1\\d{10}$"]) {
    [Cm info:@"请输入11位有效的手机号"];
    return;
  }
  AVQuery *query = [AVQuery queryWithClassName:@"_User"];
  [query whereKey:@"mobilePhoneNumber" equalTo:tfUid.text];
  [Cm showLoading];
  [query getFirstObjectInBackgroundWithBlock:^(AVObject *object, NSError *error) {
    User *user = (User *)[query getFirstObject];
    if (user) {
      [Cm hideLoading];
      [Cm info:@"该手机号已被注册"];
      return;
    }
    [AVOSCloud requestSmsCodeWithPhoneNumber:tfUid.text callback:^(BOOL succeeded, NSError *error) {
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
    NSString *ss = [NSString stringWithFormat:@"重新获取（%dS）", s];
    btnCode.titleLabel.text = ss;
    [btnCode setTitle:ss forState:UIControlStateNormal];
  }];
  [timer fire];
}

- (IBAction)registerClick:(UIButton *)sender {
  if ([tfUid.text isEqualToString:@""]) {
    [Cm info:@"请输入手机号"];
    return;
  }
  if ([tfPwd.text isEqualToString:@""]) {
    [Cm info:@"请输入密码"];
    return;
  }
  if ([tfCode.text isEqualToString:@""]) {
    [Cm info:@"请输入验证码"];
    return;
  }
  [User registerWithUid:tfUid.text andPwd:tfPwd.text andCode:tfCode.text withBlock:^{
    [self performSegueWithIdentifier:@"register_inputinfo" sender:nil];
  }];
}

- (IBAction)bgClick:(UITapGestureRecognizer *)sender {
  [tfUid resignFirstResponder];
  [tfPwd resignFirstResponder];
  [tfCode resignFirstResponder];
}
@end
