//
//  LTLoginVc.m
//  lt
//
//  Created by zjz on 2017/2/9.
//  Copyright © 2017年 zjz. All rights reserved.
//

#import "LTLoginVc.h"

@interface LTLoginVc () {
  
  __weak IBOutlet UIImageView *ivBg;
  __weak IBOutlet UITextField *tfUid;
  __weak IBOutlet UITextField *tfPwd;
  __weak IBOutlet UIButton *btnLogin;
}
@end

@implementation LTLoginVc

- (void)viewDidLoad {
  [super viewDidLoad];
  // 增加背景毛玻璃效果
  UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
  UIVisualEffectView *glassView = [[UIVisualEffectView alloc] initWithEffect:effect];
  glassView.frame = ivBg.bounds;
  glassView.alpha = 0.9;
  [ivBg addSubview:glassView];
  // 修改文本框placeholder字体颜色
  tfUid.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
  tfPwd.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"密码" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
  // 登录按钮圆角
  btnLogin.layer.cornerRadius = 20;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (IBAction)bgClick:(UITapGestureRecognizer *)sender {
  [tfUid resignFirstResponder];
  [tfPwd resignFirstResponder];
}

- (IBAction)loginClick:(UIButton *)sender {
  if ([tfUid.text isEqualToString:@""]) {
    [Cm info:@"请输入手机号"];
    return;
  }
  if ([tfPwd.text isEqualToString:@""]) {
    [Cm info:@"请输入密码"];
    return;
  }
  [User loginWithUid:tfUid.text andPwd:tfPwd.text];
}
@end
