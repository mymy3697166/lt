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
  guide.title = @"黄山一日游";
  guide.content = @"明代旅行家徐霞客曾经说过：五岳归来不看山，黄山归来不看岳。[img http://www.baidu.com/2989sfwef89se89we8.jpg]这应该是对黄山的最高评价了。文中照片大多用手机拍摄，未经过任何后期加工，和实景相比差了十万八千里。";
  guide.cover = [AVFile fileWithURL:@"https://dn-tibriwg5.qbox.me/7cbd789da18633e31cba.jpg"];
  Tag *t1 = [Tag objectWithObjectId:@"3658a4581dda2f6025d82d7453"];
  [t1 fetch];
  [guide.tags addObject:t1];
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
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 16)];
  view.backgroundColor = [UIColor whiteColor];
  return view;
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
      static NSString *guideCell = @"LTGuideCell";
      LTGuideCell *cell = [tableView dequeueReusableCellWithIdentifier:guideCell];
      if (cell == nil) {
        // 注册tableview重用cell
        UINib *guideNib = [UINib nibWithNibName:guideCell bundle:nil];
        [tvGuide registerNib:guideNib forCellReuseIdentifier:guideCell];
        cell = [tableView dequeueReusableCellWithIdentifier:guideCell];
        [cell setData:guides[indexPath.row]];
      }
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
