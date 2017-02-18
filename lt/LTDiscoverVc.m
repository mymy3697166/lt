//
//  LTDiscoverVc.m
//  lt
//
//  Created by zjz on 17/2/17.
//  Copyright © 2017年 zjz. All rights reserved.
//

#import "LTDiscoverVc.h"
#import "LTBannerCell.h"

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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if ([tableView isEqual:tvGuide]) {
    if (indexPath.section == 0) return tableView.bounds.size.width / 2;
    else return 30;
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
    } else return [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
  } else return [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
}
@end
