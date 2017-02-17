//
//  BTCommon.h
//  bt
//
//  Created by zjz on 17/1/8.
//  Copyright © 2017年 selfdoctor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Model.h"
#import "NSObject+Extension.h"
#import "NSDate+Extension.h"
#import "NSString+Extension.h"
#import "NSData+Extension.h"
#import "UIImageView+Extension.h"
#import "NSArray+Extension.h"

#define Cm [[LTCommon alloc] init]
#define U [User currentUser]
#define N [NSNotificationCenter defaultCenter]

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@interface LTCommon : NSObject
/// 信息提示
- (void)info:(NSString *)message;
/// 显示加载状态
- (void)showLoading;
/// 隐藏加载状态
- (void)hideLoading;
/// 同步发送post请求
- (NSDictionary *)syncPost:(NSString *)url forms:(NSDictionary *)forms;
/// 异步发送post请求
- (void)asyncPost:(NSString *)url forms:(NSDictionary *)forms completion:(void(^)(NSDictionary *data))completion;
/// 开启请求队列
- (void)requestQueue:(void(^)())block;
/// 从日期对象中获取年月日时分秒信息
- (NSInteger)getInfoFromDate:(NSDate *)date byFormat:(NSString *)format;
/// 压缩社区图片
- (NSData *)compressImage:(UIImage *)image;
/// 压缩用户头像
- (NSData *)compressAvatar:(UIImage *)image;
/// 缓存图片
- (void)cacheImage:(NSString *)url completion:(void(^)(UIImage *image))completion;
/// 计算bmi值
- (float)bmiWithHeight:(float)height andWeight:(float)weight;
@end

