//
//  AACollectionViewCell.h
//  SearchHistory
//
//  Created by apple on 17/5/23.
//  Copyright © 2017年 机智的新手. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AACollectionViewCell : UICollectionViewCell
@property (nonatomic, copy) NSString *keyword;

@property(nonatomic,strong)UILabel * aLab;


- (CGSize)sizeForCell;

@end
