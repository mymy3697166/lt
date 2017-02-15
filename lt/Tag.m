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
//- (UIImage *)icon {
//  AVFile *file = [self objectForKey:@"icon"];
//  __block UIImage *img = [UIImage imageNamed:@"placeholder_image"];
//  [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
//    img = [UIImage imageWithData:data];
//  }];
//  return img;
//}
//- (UIColor *)color {
//  NSArray *colorArray = [self objectForKey:@"color"];
//  return RGB([colorArray[0] integerValue], [colorArray[1] integerValue], [colorArray[2] integerValue]);
//}

+ (void)findAllInBackgroundWithBlock:(void (^)(NSArray *))block {
  AVQuery *query = [AVQuery queryWithClassName:[Tag parseClassName]];
  query.cachePolicy = kAVCachePolicyCacheElseNetwork;
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    block(objects);
  }];
}
@end
