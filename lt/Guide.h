//
//  Guide.h
//  lt
//
//  Created by zjz on 17/2/18.
//  Copyright © 2017年 zjz. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>
#import "User.h"

@interface Guide : AVObject <AVSubclassing>
@property (strong, nonatomic)User *author;
@property (strong, nonatomic)NSString *title;
@property (strong, nonatomic)NSString *content;
@property (strong, nonatomic)AVFile *cover;
@property (strong, nonatomic)AVRelation *tags;
@property (assign, nonatomic)NSInteger browse_times;
@property (assign, nonatomic)NSInteger comment_times;
@end
