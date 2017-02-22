//
//  LTPublishGuideVc.m
//  lt
//
//  Created by zjz on 17/2/21.
//  Copyright © 2017年 zjz. All rights reserved.
//

#import "LTPublishGuideVc.h"

@interface LTPublishGuideVc () <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
  __weak IBOutlet NSLayoutConstraint *lcBottom;
  __weak IBOutlet UITextView *tvContent;
  
  UIAlertController *imageAlert;
  UIImagePickerController *ipc;
}

@end

@implementation LTPublishGuideVc

- (void)viewDidLoad {
  [super viewDidLoad];
  [N addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
  [N addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  imageAlert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
  ipc = [[UIImagePickerController alloc] init];
  ipc.delegate = self;
  [imageAlert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:ipc animated:YES completion:nil];
  }]];
  [imageAlert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:ipc animated:YES completion:nil];
  }]];
  [imageAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    [imageAlert dismissViewControllerAnimated:YES completion:nil];
  }]];
}

- (void)keyboardWillShow:(NSNotification *)nc {
  CGFloat height = [nc.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
  if (height > 0) {
    CGFloat duration = [nc.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSInteger curve = [nc.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    lcBottom.constant = height;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [self.view layoutIfNeeded];
    [UIView commitAnimations];
  }
}

- (void)keyboardWillHide:(NSNotification *)nc {
  CGFloat duration = [nc.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
  NSInteger curve = [nc.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
  lcBottom.constant = 0;
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:duration];
  [UIView setAnimationCurve:curve];
  [self.view layoutIfNeeded];
  [UIView commitAnimations];
}

- (IBAction)insertImageClick:(UIButton *)sender {
  [self presentViewController:imageAlert animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
  UIImage *image = info[UIImagePickerControllerOriginalImage];
  NSData *data = [Cm compressImage:image];
  NSString *fn = [NSString stringWithFormat:@"guide_content_image_%@.jpg", [[NSDate date] toStringWithFormat:@"yyyyMMddhhmmssSSS"]];
  AVFile *file = [AVFile fileWithName:fn data:data];
  [Cm showLoading];
  [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    [Cm hideLoading];
    if (error) {
      NSLog(@"%@", error);
      return;
    }
    tvContent.text = [tvContent.text stringByAppendingString:[NSString stringWithFormat:@"\n[img %@]\n", file.url]];
  }];
  [ipc dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [ipc dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)previewClick:(UIButton *)sender {
  NSArray *stringParts = [tvContent.text componentsSeparatedByString:@"\n"];
  NSLog(@"%@", stringParts);
}

- (IBAction)publishClick:(UIBarButtonItem *)sender {
  
}

- (IBAction)cancelClick:(UIBarButtonItem *)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}
@end
