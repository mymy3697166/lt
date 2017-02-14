//
//  Tag.h
//  lt
//
//  Created by zjz on 17/2/14.
//  Copyright © 2017年 zjz. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface Tag : AVObject
@property (strong, nonatomic)NSString *name;

+ (void)fetchAllWithBlock:(void(^)(NSArray *data))block;
@end
