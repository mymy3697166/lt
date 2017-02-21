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
#import "LTTest.h"

@interface LTDiscoverVc () <UITableViewDelegate, UITableViewDataSource> {
  
  __weak IBOutlet UIButton *btnTabGuide;
  __weak IBOutlet UIButton *btnTabTravels;
  __weak IBOutlet NSLayoutConstraint *lcSelectedLeft;
  __weak IBOutlet UITableView *tvGuide;
  
  UIAlertController *alert;
  
  NSArray *banners;
  NSArray *guides;
  NSArray *travels;
}

@end

@implementation LTDiscoverVc

- (void)viewDidLoad {
  [super viewDidLoad];
  guides = [LTTest getGuides];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
  [alert addAction:[UIAlertAction actionWithTitle:@"发表攻略" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    [self performSegueWithIdentifier:@"discover_publishguide" sender:nil];
  }]];
  [alert addAction:[UIAlertAction actionWithTitle:@"发表游记" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    
  }]];
  [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    [alert dismissViewControllerAnimated:YES completion:nil];
  }]];
}

- (IBAction)publishClick:(UIBarButtonItem *)sender {
  [self presentViewController:alert animated:YES completion:nil];
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
    else return 8;
  } else return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  if ([tableView isEqual:tvGuide]) {
    if (section == 0) return 0.0001;
    else return 16;
  } else return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SW, 16)];
  view.backgroundColor = [UIColor whiteColor];
  return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if ([tableView isEqual:tvGuide]) {
    if (indexPath.section == 0) return SW / 2;
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
        // 注册tableview重用cell
        UINib *guideNib = [UINib nibWithNibName:@"LTGuideCell" bundle:nil];
        [tvGuide registerNib:guideNib forCellReuseIdentifier:@"LTGuideCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"LTGuideCell"];
      }
      [cell setData:guides[indexPath.row]];
      return cell;
    }
  } else return [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if ([tableView isEqual:tvGuide]) {
    if (indexPath.section > 0) {
      Guide *guide = guides[indexPath.row];
      [self performSegueWithIdentifier:@"discover_guide" sender:guide];
    }
  } else {
    
  }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"discover_guide"]) {
    Guide *guide = sender;
    
  }
}
@end
