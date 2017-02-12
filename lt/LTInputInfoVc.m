//
//  LTInputInfoVc.m
//  lt
//
//  Created by zjz on 17/2/10.
//  Copyright © 2017年 zjz. All rights reserved.
//

#import "LTInputInfoVc.h"

@interface LTInputInfoVc () <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
  __weak IBOutlet UIButton *btnSelectAvatar;
  __weak IBOutlet UITextField *tfNickname;
  __weak IBOutlet UITextField *tfGender;
  __weak IBOutlet UITextField *tfDob;
  __weak IBOutlet UIButton *btnNext;
  
  UIAlertController *avatarAlert;
  UIAlertController *genderAlert;
  UIImagePickerController *ipc;
  
  NSString *gender;
}

@end

@implementation LTInputInfoVc

- (void)viewDidLoad {
  [super viewDidLoad];
  btnNext.layer.cornerRadius = 20;
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  avatarAlert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
  ipc = [[UIImagePickerController alloc] init];
  ipc.allowsEditing = YES;
  ipc.delegate = self;
  UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:ipc animated:YES completion:nil];
  }];
  UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:ipc animated:YES completion:nil];
  }];
  [avatarAlert addAction:cameraAction];
  [avatarAlert addAction:albumAction];
  
  genderAlert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
  UIAlertAction *mAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    tfGender.text = @"男";
    gender = @"M";
  }];
  UIAlertAction *fAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    tfGender.text = @"女";
    gender = @"F";
  }];
  [genderAlert addAction:mAction];
  [genderAlert addAction:fAction];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
//  UIImage *image = info[UIImagePickerControllerEditedImage];
//  NSData *data = [Common compressAvatar:image];
//  [Common showLoading];
//  [Common asyncPost:URL_UPLOADAVATAR forms:@{@"images": @[[data toBase64String]]} completion:^(NSDictionary *data) {
//    [Common hideLoading];
//    if (!data) return;
//    if ([data[@"status"] isEqual:@0]) {
//      avatar = data[@"data"][0];
//      [Common cacheImage:[URL_AVATARPATH stringByAppendingString:avatar] completion:^(UIImage *image) {
//        [btnAvatar setBackgroundImage:image forState:UIControlStateNormal];
//      }];
//    }
//  }];
  [ipc dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [ipc dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)selectAvatarClick:(UIButton *)sender {
  [self presentViewController:avatarAlert animated:YES completion:nil];
}

- (IBAction)genderClick:(UITapGestureRecognizer *)sender {
  [self presentViewController:genderAlert animated:YES completion:nil];
}
@end
