//
//  ViewController.m
//  lt
//
//  Created by zjz on 2017/2/8.
//  Copyright © 2017年 zjz. All rights reserved.
//

#import "ViewController.h"
#import "User.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  NSLog(@"%@", [User currentUser]);
  [AVOSCloud requestSmsCodeWithPhoneNumber:@"15010905653" callback:^(BOOL succeeded, NSError *error) {
    NSLog(@"%@", error);
  }];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
@end
