//
//  LTSelectTagsVc.m
//  lt
//
//  Created by zjz on 17/2/14.
//  Copyright © 2017年 zjz. All rights reserved.
//

#import "LTSelectTagsVc.h"
#import "Tag.h"

@interface LTSelectTagsVc ()

@end

@implementation LTSelectTagsVc

- (void)viewDidLoad {
  [super viewDidLoad];
  [Tag fetchAllWithBlock:^(NSArray *data) {
    NSLog(@"%@", data);
  }];
}
@end
