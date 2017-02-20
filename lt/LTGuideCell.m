//
//  LTGuideCell.m
//  lt
//
//  Created by zjz on 2017/2/20.
//  Copyright © 2017年 zjz. All rights reserved.
//

#import "LTGuideCell.h"

@implementation LTGuideCell {
  __weak IBOutlet UIImageView *ivCover;
  __weak IBOutlet UILabel *labTitle;
  __weak IBOutlet UILabel *labContent;
  __weak IBOutlet UILabel *labTags;
  __weak IBOutlet UILabel *labBrowse;
  __weak IBOutlet UILabel *labComment;
}

- (void)awakeFromNib {
  [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
}

- (void)setData:(Guide *)data {
//  NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:@"\[img [^\[\]]+\]" options:NSRegularExpressionCaseInsensitive error:nil];
//  NSRange range = NSMakeRange(0, [data.content lengthOfBytesUsingEncoding:kCFStringEncodingUTF8]);
//  NSTextCheckingResult *first = [reg matchesInString:data.content options:0 range:range][0];
//  AVFile *image = [AVFile fileWithURL:[[first.replacementString substringFromIndex:5] substringToIndex:first.replacementString.length - 2]];
  if (data.cover.isDataAvailable) ivCover.image = [UIImage imageWithData:[data.cover getData]];
  else {
    [data.cover getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
      ivCover.image = [UIImage imageWithData:data];
    }];
  }
  NSMutableAttributedString *maContent = [[NSMutableAttributedString alloc] initWithString:data.content];
  NSMutableParagraphStyle * ps = [[NSMutableParagraphStyle alloc] init];
  ps.lineSpacing = 4;
  ps.lineBreakMode = NSLineBreakByTruncatingTail;
  [maContent addAttribute:NSParagraphStyleAttributeName value:ps range:NSMakeRange(0, data.content.length)];
  labContent.attributedText = maContent;
}
@end
