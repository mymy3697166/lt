//
//  LTPublishGuideVc.m
//  lt
//
//  Created by zjz on 17/2/21.
//  Copyright © 2017年 zjz. All rights reserved.
//

#import "LTPublishGuideVc.h"

@interface LTPublishGuideVc () {
  __weak IBOutlet UIButton *btnCover;
  __weak IBOutlet NSLayoutConstraint *lcBottom;
  __weak IBOutlet NSLayoutConstraint *lcLeft;
  __weak IBOutlet UITextView *tvContent;
  __weak IBOutlet UITextField *tfTitle;
  __weak IBOutlet UILabel *labSelectTagsPlaceHolder;
  __weak IBOutlet UIView *vSelectTags;
  
  UIAlertController *tagAlert;
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
  
  [self initImagePickerWithBlock:^(UIImage *image, NSString *name) {
    NSData *data = [Cm compressImage:image];
    NSString *prefix;
    if ([name isEqualToString:@"insert_image"]) prefix = @"guide_content_image";
    else prefix = @"guide_cover_image";
    NSString *fn = [NSString stringWithFormat:@"%@_%@.jpg", prefix, [[NSDate date] toStringWithFormat:@"yyyyMMddhhmmssSSS"]];
    AVFile *file = [AVFile fileWithName:fn data:data];
    [Cm showLoading];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
      [Cm hideLoading];
      if (error) {
        NSLog(@"%@", error);
        return;
      }
      if ([name isEqualToString:@"insert_image"]) {
        NSString *imageTag = [NSString stringWithFormat:@"\n[img %@]\n", file.url];
        tvContent.text = [tvContent.text stringByReplacingCharactersInRange:tvContent.selectedRange withString:imageTag];
      }
      else [btnCover setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
    }];
  }];
  
  tagAlert = [UIAlertController alertControllerWithTitle:@"所有标签" message:@"\n\n\n\n\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleActionSheet];
  [tagAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    
  }]];
  [tagAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    
  }]];
}

- (IBAction)segmentedClick:(UISegmentedControl *)sender {
  if (sender.selectedSegmentIndex == 0) {
    lcLeft.constant = 0;
    [tvContent resignFirstResponder];
  }
  else {
    lcLeft.constant = -SW;
    [tvContent becomeFirstResponder];
  }
  [UIView animateWithDuration:0.25 animations:^{
    [self.view layoutIfNeeded];
  }];
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

- (IBAction)coverImageClick:(UIButton *)sender {
  [self showImagePickerAllowsEditing:YES withName:@"cover_image"];
}

- (IBAction)selectTagsClick:(UITapGestureRecognizer *)sender {
  [self presentViewController:tagAlert animated:YES completion:nil];
}

- (IBAction)leftViewClick:(UITapGestureRecognizer *)sender {
  [tfTitle resignFirstResponder];
}

- (IBAction)insertImageClick:(UIButton *)sender {
  [self showImagePickerAllowsEditing:NO withName:@"insert_image"];
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
