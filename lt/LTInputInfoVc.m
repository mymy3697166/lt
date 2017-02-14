//
//  LTInputInfoVc.m
//  lt
//
//  Created by zjz on 17/2/10.
//  Copyright © 2017年 zjz. All rights reserved.
//

#import "LTInputInfoVc.h"

@interface LTInputInfoVc () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource> {
  __weak IBOutlet UIButton *btnAvatar;
  __weak IBOutlet UITextField *tfNickname;
  __weak IBOutlet UITextField *tfGender;
  __weak IBOutlet UITextField *tfDob;
  __weak IBOutlet UIButton *btnNext;
  
  UIAlertController *avatarAlert;
  UIAlertController *genderAlert;
  UIAlertController *dobAlert;
  UIImagePickerController *ipc;
  UIPickerView *picker;
  
  NSString *gender;
  NSDate *dob;
  NSString *avatar;
  NSInteger days;
}

@end

@implementation LTInputInfoVc

- (void)viewDidLoad {
  [super viewDidLoad];
  btnNext.layer.cornerRadius = 20;
  btnAvatar.layer.cornerRadius = btnAvatar.bounds.size.width / 2;
  
  days = 31;
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  // 选择头像菜单
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
  // 选择性别菜单
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
  // 选择生日菜单
  dobAlert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
  picker = [[UIPickerView alloc] initWithFrame:CGRectMake(16, 8, dobAlert.view.bounds.size.width - 52, 140)];
  picker.delegate = self;
  [dobAlert.view addSubview:picker];
  [picker selectRow:74 inComponent:0 animated:NO];
  [picker selectRow:6 inComponent:1 animated:NO];
  [picker selectRow:14 inComponent:2 animated:NO];
  UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    NSInteger nowYear = [[NSDate date] year];
    NSInteger year = nowYear - 99 + [picker selectedRowInComponent:0];
    NSInteger month = [picker selectedRowInComponent:1] + 1;
    NSInteger day = [picker selectedRowInComponent:2] + 1;
    dob = [[NSString stringWithFormat:@"%ld-%02ld-%02ld", (long)year, (long)month, (long)day] toDateWithFormat:@"yyyy-MM-dd"];
    tfDob.text = [dob toStringWithFormat:@"yyyy年MM月dd日"];
  }];
  [dobAlert addAction:yesAction];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {return 3;}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  if (component == 0) return 100;
  else if (component == 1) return 12;
  else return days;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {return 30;}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
  UILabel *label = [[UILabel alloc] init];
  label.textAlignment = NSTextAlignmentCenter;
  if (component == 0) {
    if (view) return view;
    label.text = [NSString stringWithFormat:@"%ld年", (long)([[NSDate date] year] - 99 + row)];
  }
  else if (component == 1) {
    if (view) return view;
    label.text = [NSString stringWithFormat:@"%ld月", (long)(row + 1)];
  }
  else {
    label.text = [NSString stringWithFormat:@"%ld日", (long)(row + 1)];
  }
  return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
  if (component == 1) {
    if (row == 1) days = 28;
    else if (row == 3 || row == 5 || row == 8 || row == 10) days = 30;
    else days = 31;
    [pickerView reloadComponent:2];
  }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
  UIImage *image = info[UIImagePickerControllerEditedImage];
  NSData *data = [Cm compressAvatar:image];
  [Cm showLoading];
  NSString *fn = [NSString stringWithFormat:@"%@.jpg", [[NSDate date] toStringWithFormat:@"yyyyMMddhhmmssSSS"] ];
  AVFile *file = [AVFile fileWithName:fn data:data];
  [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    [Cm hideLoading];
    if (error) {
      NSLog(@"%@", error);
      return;
    }
    avatar = file.objectId;
    [btnAvatar setBackgroundImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
  }];
  [ipc dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [ipc dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)avatarClick:(UIButton *)sender {
  [self presentViewController:avatarAlert animated:YES completion:nil];
}

- (IBAction)genderClick:(UITapGestureRecognizer *)sender {
  [self presentViewController:genderAlert animated:YES completion:nil];
}

- (IBAction)dobClick:(UITapGestureRecognizer *)sender {
  [self presentViewController:dobAlert animated:YES completion:nil];
}

- (IBAction)bgClick:(UITapGestureRecognizer *)sender {
  [tfNickname resignFirstResponder];
}
@end
