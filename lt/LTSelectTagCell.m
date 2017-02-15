//
//  LTSelectTagCell.m
//  lt
//
//  Created by zjz on 2017/2/15.
//  Copyright © 2017年 zjz. All rights reserved.
//

#import "LTSelectTagCell.h"
#import "LTCommon.h"

@implementation LTSelectTagCell {
  __weak IBOutlet UIButton *btnIcon;
  __weak IBOutlet UILabel *labName;
  
  UIColor *color;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  btnIcon.layer.cornerRadius = btnIcon.bounds.size.width / 2;
}

- (void)setData:(Tag *)tag {
  [tag.icon getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
    [btnIcon setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
  }];
  
  labName.text = tag.name;
  
  int r = [tag.color[0] intValue];
  int g = [tag.color[1] intValue];
  int b = [tag.color[2] intValue];
  color = RGB(r, g, b);
}

- (void)setSelected:(BOOL)selected {
  [super setSelected:selected];
  if (selected) {
    [UIView animateWithDuration:0.3 animations:^{
      btnIcon.tintColor = color;
    }];
  } else {
    [UIView animateWithDuration:0.3 animations:^{
      btnIcon.tintColor = [UIColor lightGrayColor];
    }];
  }
}
@end
