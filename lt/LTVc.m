//
//  LTViewController.m
//  lt
//
//  Created by zjz on 2017/2/9.
//  Copyright © 2017年 zjz. All rights reserved.
//

#import "LTVc.h"
typedef void(^UIImagePickerDidFinishBlock)(UIImage *);

@interface LTVc () <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
  UIAlertController *photoAlert;
  UIImagePickerController *ipc;
  UIImagePickerDidFinishBlock imagePickerDidFinishBlock;
}

@end

@implementation LTVc
- (void)viewDidLoad {
  [super viewDidLoad];
  UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
  temporaryBarButtonItem.title = @"";
  self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
}

- (void)initImagePickerAllowsEditing:(BOOL)allowsEditing withBlock:(UIImagePickerDidFinishBlock)block {
  imagePickerDidFinishBlock = block;
  
  ipc = [[UIImagePickerController alloc] init];
  ipc.allowsEditing = allowsEditing;
  ipc.delegate = self;
  
  [photoAlert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:ipc animated:YES completion:nil];
  }]];
  [photoAlert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:ipc animated:YES completion:nil];
  }]];
  [photoAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    [photoAlert dismissViewControllerAnimated:YES completion:nil];
  }]];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
  if (ipc.allowsEditing) imagePickerDidFinishBlock(info[UIImagePickerControllerEditedImage]);
  else imagePickerDidFinishBlock(info[UIImagePickerControllerOriginalImage]);
}

- (void)showImagePicker {
  if (photoAlert) [self presentViewController:photoAlert animated:YES completion:nil];
  else @throw [[NSException alloc] initWithName:@"未初始化ImagePicker。" reason:@"调用showImagePicker前请先调用initImagePickerAllowsEditing。" userInfo:nil];
}
@end
