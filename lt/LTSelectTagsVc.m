//
//  LTSelectTagsVc.m
//  lt
//
//  Created by zjz on 17/2/14.
//  Copyright © 2017年 zjz. All rights reserved.
//

#import "LTSelectTagsVc.h"
#import "LTSelectTagCell.h"

@interface LTSelectTagsVc () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
  __weak IBOutlet UICollectionView *cvTags;
  
  NSArray *dataSource;
}

@end

@implementation LTSelectTagsVc

- (void)viewDidLoad {
  [super viewDidLoad];
  cvTags.allowsMultipleSelection = YES;
  [Tag findAllInBackgroundWithBlock:^(NSArray *tags) {
    dataSource = tags;
    [cvTags reloadData];
  }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {return 2;}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  if (section == 0) return 1;
  else return dataSource.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) return CGSizeMake(collectionView.bounds.size.width, 50);
  else {
    CGFloat width = (collectionView.bounds.size.width - 3) / 4;
    return CGSizeMake(width, width / 2 + 48);
  }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {return 1;}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"LTSelectTagTitleCell" forIndexPath:indexPath];
  } else {
    LTSelectTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LTSelectTagCell" forIndexPath:indexPath];
    [cell setData:dataSource[indexPath.row]];
    return cell;
  }
}
@end
