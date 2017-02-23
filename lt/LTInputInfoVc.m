//
//  LTInputInfoVc.m
//  lt
//
//  Created by zjz on 17/2/10.
//  Copyright © 2017年 zjz. All rights reserved.
//

#import "LTInputInfoVc.h"

@interface LTInputInfoVc () <UIPickerViewDelegate, UIPickerViewDataSource> {
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
  AVFile *avatar;
  NSInteger days;
}
@end

@implementation LTInputInfoVc
- (void)viewDidLoad {
  [super viewDidLoad];
  btnNext.layer.cornerRadius = 20;
  btnAvatar.layer.cornerRadius = btnAvatar.bounds.size.width / 2;
  
  days = 31;
  // 测试
  //[self performSegueWithIdentifier:@"inputinfo_selecttags" sender:nil];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  // 选择头像菜单
  [self initImagePickerWithBlock:^(UIImage *image, NSString *name) {
    NSData *data = [Cm compressAvatar:image];
    [Cm showLoading];
    NSString *fn = [NSString stringWithFormat:@"user_avatar_image_%@.jpg", [[NSDate date] toStringWithFormat:@"yyyyMMddhhmmssSSS"] ];
    avatar = [AVFile fileWithName:fn data:data];
    [avatar saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
      [Cm hideLoading];
      if (error) {
        NSLog(@"%@", error);
        return;
      }
      [btnAvatar setBackgroundImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
    }];
  }];
  // 选择性别菜单
  genderAlert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
  [genderAlert addAction:[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    tfGender.text = @"男";
    gender = @"M";
  }]];
  [genderAlert addAction:[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    tfGender.text = @"女";
    gender = @"F";
  }]];
  [genderAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    [genderAlert dismissViewControllerAnimated:YES completion:nil];
  }]];
  // 选择生日菜单
  dobAlert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
  picker = [[UIPickerView alloc] initWithFrame:CGRectMake(16, 8, dobAlert.view.bounds.size.width - 52, 140)];
  picker.delegate = self;
  [dobAlert.view addSubview:picker];
  [picker selectRow:74 inComponent:0 animated:NO];
  [picker selectRow:6 inComponent:1 animated:NO];
  [picker selectRow:14 inComponent:2 animated:NO];
  [dobAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    NSInteger nowYear = [[NSDate date] year];
    NSInteger year = nowYear - 99 + [picker selectedRowInComponent:0];
    NSInteger month = [picker selectedRowInComponent:1] + 1;
    NSInteger day = [picker selectedRowInComponent:2] + 1;
    dob = [[NSString stringWithFormat:@"%ld-%02ld-%02ld", (long)year, (long)month, (long)day] toDateWithFormat:@"yyyy-MM-dd"];
    tfDob.text = [dob toStringWithFormat:@"yyyy年MM月dd日"];
  }]];
  [dobAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    [dobAlert dismissViewControllerAnimated:YES completion:nil];
  }]];
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

- (IBAction)nextClick:(UIButton *)sender {
  if (avatar == nil) {
    [Cm info:@"请选择头像"];
    return;
  }
  if ([tfNickname.text isEqualToString:@""]) {
    [Cm info:@"请输入昵称"];
    return;
  }
  if (gender == nil) {
    [Cm info:@"请选择性别"];
    return;
  }
  if (dob == nil) {
    [Cm info:@"请选择出生日期"];
    return;
  }
  U.dob = dob;
  U.avatar = avatar;
  U.gender = gender;
  U.nickName = tfNickname.text;
  [U saveEventually];
  [self performSegueWithIdentifier:@"inputinfo_selecttags" sender:nil];
}
@end
