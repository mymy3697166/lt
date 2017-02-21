//
//  LTGuideCell.m
//  lt
//
//  Created by zjz on 2017/2/20.
//  Copyright © 2017年 zjz. All rights reserved.
//

#import "LTGuideCell.h"
#import "LTCommon.h"

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
  self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
}

- (void)setData:(Guide *)data {
  NSLog(@"%@", data);
  [ivCover loadAVFile:data.cover];
  
  labTitle.text = data.title;
  
  NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:@"\\[img [^\\[\\]]+\\]" options:NSRegularExpressionCaseInsensitive error:nil];
  NSRange range = NSMakeRange(0, data.content.length);
  NSString *content = [reg stringByReplacingMatchesInString:data.content options:0 range:range withTemplate:@""];
  NSMutableAttributedString *maContent = [[NSMutableAttributedString alloc] initWithString:content];
  NSMutableParagraphStyle * ps = [[NSMutableParagraphStyle alloc] init];
  ps.lineSpacing = 4;
  ps.lineBreakMode = NSLineBreakByTruncatingTail;
  [maContent addAttribute:NSParagraphStyleAttributeName value:ps range:NSMakeRange(0, content.length)];
  labContent.attributedText = maContent;
  
  NSArray *tags = [data.tags.query findObjects];
  [tags enumerateObjectsUsingBlock:^(Tag *item, NSUInteger idx, BOOL *stop) {
    if (idx == 0) [labTags.text stringByAppendingString:item.name];
    else [labTags.text stringByAppendingString:[NSString stringWithFormat:@" %@", item.name]];
  }];
}
@end
