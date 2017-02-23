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

@interface LTVc : UIViewController
- (void)initImagePickerAllowsEditing:(BOOL)allowsEditing withBlock:(void(^)(UIImage *))block;
@end
