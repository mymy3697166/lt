//
//  UserTags.h
//  lt
//
//  Created by zjz on 2017/2/16.
//  Copyright © 2017年 zjz. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface UserTags : AVObject<AVSubclassing>
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *tagId;
@end
