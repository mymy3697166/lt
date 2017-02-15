//
//  Tag.h
//  lt
//
//  Created by zjz on 17/2/14.
//  Copyright © 2017年 zjz. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface Tag : AVObject<AVSubclassing>
@property (strong, nonatomic)NSString *name;
@property (strong, nonatomic)AVFile *icon;
@property (strong, nonatomic)NSArray *color;

+ (void)findAllInBackgroundWithBlock:(void(^)(NSArray *))block;
@end
