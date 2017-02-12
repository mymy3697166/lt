//
//  LTViewController.m
//  lt
//
//  Created by zjz on 2017/2/9.
//  Copyright © 2017年 zjz. All rights reserved.
//

#import "LTVc.h"

@interface LTVc ()

@end

@implementation LTVc

- (void)viewDidLoad {
  [super viewDidLoad];
  UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
  temporaryBarButtonItem.title = @"";
  self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
}
@end
