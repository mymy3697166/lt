//
//  LTBannerCell.m
//  lt
//
//  Created by zjz on 17/2/18.
//  Copyright © 2017年 zjz. All rights reserved.
//

#import "LTBannerCell.h"
#import "LTCommon.h"

@implementation LTBannerCell {
  __weak IBOutlet UIView *vBg;
  __weak IBOutlet NSLayoutConstraint *lcBgWidth;
  __weak IBOutlet NSLayoutConstraint *lcBgLeft;
  __weak IBOutlet UIPageControl *pc;
}

- (void)awakeFromNib {
  [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
}

- (void)setData:(Guide *)guide {
  NSArray *images = @[@"https://dn-tibriwg5.qbox.me/72339767b2aaf8ae231e.jpg", @"https://dn-tibriwg5.qbox.me/0e521023c723bbd8105b.jpg", @"https://dn-tibriwg5.qbox.me/a0946fa741867f2f84ee.jpg", @"https://dn-tibriwg5.qbox.me/5b538c6c05c48549e44e.jpg", @"https://dn-tibriwg5.qbox.me/34707af0e70e40cac39c.jpg"];
  lcBgWidth.constant = images.count * SW;
  [images enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(idx * SW, 0, SW, SW / 2)];
    image.image = [UIImage imageNamed:@"placeholder_image"];
    AVFile *f = [AVFile fileWithURL:obj];
    if ([f isDataAvailable]) image.image = [UIImage imageWithData:[f getData]];
    else [f getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
      image.image = [UIImage imageWithData:data];
    }];
    [vBg addSubview:image];
  }];
  pc.numberOfPages = images.count;
}

- touch
@end
