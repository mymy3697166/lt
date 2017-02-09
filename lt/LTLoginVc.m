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
}
@end

@implementation LTLoginVc

- (void)viewDidLoad {
  [super viewDidLoad];
  UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
  UIVisualEffectView *glassView = [[UIVisualEffectView alloc] initWithEffect:effect];
  [ivBg addSubview:glassView];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
}
@end
