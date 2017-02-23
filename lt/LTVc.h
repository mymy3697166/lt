//
//  LTViewController.h
//  lt
//
//  Created by zjz on 2017/2/9.
//  Copyright © 2017年 zjz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIVisualEffectView.h>
#import "LTCommon.h"

typedef void(^UIImagePickerDidFinishBlock)(UIImage *, NSString *);

@interface LTVc : UIViewController
- (void)initImagePickerWithBlock:(UIImagePickerDidFinishBlock)block;
- (void)showImagePickerAllowsEditing:(BOOL)allowsEditing withName:(NSString *)name;
@end
