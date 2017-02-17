//
//  Tag.m
//  lt
//
//  Created by zjz on 17/2/14.
//  Copyright © 2017年 zjz. All rights reserved.
//

#import "Tag.h"
#import "LTCommon.h"

@implementation Tag
@dynamic name;
@dynamic icon;
@dynamic color;

+ (void)findAllInBackgroundWithBlock:(void (^)(NSArray *))block {
  AVQuery *query = [AVQuery queryWithClassName:[Tag parseClassName]];
  query.cachePolicy = kAVCachePolicyCacheElseNetwork;
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    block(objects);
  }];
}
@end
