//
//  LTDiscoverVc.m
//  lt
//
//  Created by zjz on 17/2/17.
//  Copyright © 2017年 zjz. All rights reserved.
//

#import "LTDiscoverVc.h"
#import "LTBannerCell.h"
#import "LTGuideCell.h"

@interface LTDiscoverVc () <UITableViewDelegate, UITableViewDataSource> {
  
  __weak IBOutlet UIButton *btnTabGuide;
  __weak IBOutlet UIButton *btnTabTravels;
  __weak IBOutlet NSLayoutConstraint *lcSelectedLeft;
  __weak IBOutlet UITableView *tvGuide;
  
  NSArray *banners;
  NSArray *guides;
  NSArray *travels;
}

@end

@implementation LTDiscoverVc

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // 测试数据
  Guide *guide = [Guide object];
  guide.author = U;
  guide.title = @"黄三一日游";
  guide.content = @"明代旅行家徐霞客曾经说过：五岳归来不看山，黄山归来不看岳。这应该是对黄山的最高评价了。文中照片大多用手机拍摄，未经过任何后期加工，和实景相比差了十万八千里。";
  guide.cover = [AVFile fileWithURL:@"https://dn-tibriwg5.qbox.me/7cbd789da18633e31cba.jpg"];
  guides = @[guide, guide];
}

- (IBAction)tabGuideClick:(UIButton *)sender {
  [btnTabGuide setTitleColor:RGB(102, 204, 255) forState:UIControlStateNormal];
  [btnTabTravels setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
  lcSelectedLeft.constant = 0;
  [UIView animateWithDuration:0.3 animations:^{
    [self.navigationItem.titleView layoutIfNeeded];
  }];
}

- (IBAction)tabTravelsClick:(UIButton *)sender {
  [btnTabGuide setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
  [btnTabTravels setTitleColor:RGB(102, 204, 255) forState:UIControlStateNormal];
  lcSelectedLeft.constant = 100 - btnTabGuide.bounds.size.width;
  [UIView animateWithDuration:0.3 animations:^{
    [self.navigationItem.titleView layoutIfNeeded];
  }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  if ([tableView isEqual:tvGuide]) return 2;
  else return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if ([tableView isEqual:tvGuide]) {
    if (section == 0) return 1;
    else return guides.count;
  } else return travels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  if ([tableView isEqual:tvGuide]) {
    if (section == 0) return 0.0001;
    else return 4;
  } else return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  if ([tableView isEqual:tvGuide]) {
    if (section == 0) return 4;
    else return 4;
  } else return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if ([tableView isEqual:tvGuide]) {
    if (indexPath.section == 0) return tableView.bounds.size.width / 2;
    else return 120;
  } else return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if ([tableView isEqual:tvGuide]) {
    if (indexPath.section == 0) {
      LTBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LTBannerCell"];
      if (cell == nil) {
        cell = (LTBannerCell *)[[NSBundle mainBundle] loadNibNamed:@"LTBannerCell" owner:nil options:nil][0];
        [cell setData:nil];
      }
      return cell;
    } else {
      LTGuideCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LTGuideCell"];
      if (cell == nil) {
        cell = (LTGuideCell *)[[NSBundle mainBundle] loadNibNamed:@"LTGuideCell" owner:nil options:nil][0];
        [cell setData:guides[indexPath.row]];
      }
      return cell;
    }
  } else return [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
}
@end
