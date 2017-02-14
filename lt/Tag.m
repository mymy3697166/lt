//
//  Tag.m
//  lt
//
//  Created by zjz on 17/2/14.
//  Copyright © 2017年 zjz. All rights reserved.
//

#import "Tag.h"

@implementation Tag
- (NSString *)name {
  return [self objectForKey:@"name"];
}
- (void)setName:(NSString *)name {
  [self setObject:name forKey:@"name"];
}

- (instancetype)init {
  self = [super initWithClassName:@"Tags"];
  return self;
}

+ (void)fetchAllWithBlock:(void(^)(NSArray *data))block {
  AVQuery *query = [AVQuery queryWithClassName:@"Tags"];
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    NSMutableArray *tags = [NSMutableArray array];
    [objects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      Tag *tag = (Tag *)obj;
      [tags addObject:tag];
    }];
    block(tags);
  }];
}
@end
