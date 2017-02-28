//
//  BTFile.h
//  lt
//
//  Created by zjz on 17/2/28.
//  Copyright © 2017年 zjz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BTImage : NSObject
@property (strong, nonatomic, readonly) NSString *url;
@property (strong, nonatomic, readonly) NSString *name;
@property (assign, readonly) CGSize size;
@property (assign, readonly) NSUInteger length;
@property (assign, readonly) BOOL isDataAvailable;
@property (strong, nonatomic, readonly) NSData *data;
@end
