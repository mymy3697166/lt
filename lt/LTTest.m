//
//  LTTest.m
//  lt
//
//  Created by zjz on 17/2/21.
//  Copyright © 2017年 zjz. All rights reserved.
//

#import "LTTest.h"

@implementation LTTest
+ (NSArray *)getGuides {
  Tag *t1 = [Tag objectWithObjectId:@"58a4581dda2f6025d82d7453"];
  [t1 fetch];
  Tag *t2 = [Tag objectWithObjectId:@"58a3cf88128fe10058c5b0d1"];
  [t2 fetch];
  
  Guide *guide1 = [Guide object];
  guide1.author = U;
  guide1.title = @"黄山五日游";
  guide1.content = @"明代旅行家徐霞客曾经说过：五岳归来不看山，黄山归来不看岳。[img http://www.baidu.com/2989sfwef89se89we8.jpg]这应该是对黄山的最高评价了。文中照片大多用手机拍摄，未经过任何后期加工，和实景相比差了十万八千里。";
  guide1.cover = [AVFile fileWithURL:@"https://dn-tibriwg5.qbox.me/7cbd789da18633e31cba.jpg"];
  [guide1.tags addObject:t1];
  
  Guide *guide2 = [Guide object];
  guide2.author = U;
  guide2.title = @"八达岭长城一日游";
  guide2.content = @"阿萨德联发科。[img http://www.baidu.com/2989sfwef89se89we8.jpg]这应该是对黄山的最高评价了。文中照片大多用手机拍摄，未经过任何后期加工，和实景相比差了十万八千里。";
  guide2.cover = [AVFile fileWithURL:@"https://dn-tibriwg5.qbox.me/fb69c384c86c46e28f95.jpg"];
  [guide2.tags addObject:t1];
  [guide2.tags addObject:t2];
  return @[guide1, guide2];
}
@end
