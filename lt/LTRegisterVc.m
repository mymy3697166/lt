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
}

- (IBAction)codeClick:(UIButton *)sender {
  
}

- (IBAction)registerClick:(UIButton *)sender {
  
}

- (IBAction)bgClick:(UITapGestureRecognizer *)sender {
  [tfUid resignFirstResponder];
  [tfPwd resignFirstResponder];
  [tfCode resignFirstResponder];
}
@end
