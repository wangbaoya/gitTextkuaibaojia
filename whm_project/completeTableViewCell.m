//
//  completeTableViewCell.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "completeTableViewCell.h"

@implementation completeTableViewCell
//-(UIImageView *)headImage
//{
//    if (_headImage == nil)
//    {
//        self.headImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 28, 28)];
//        
//        //        self.headImage.layer.masksToBounds =YES;
//        //        self.headImage.layer.cornerRadius = 24/2;
//        
//        [self.contentView addSubview:_headImage];
//    }
//    return _headImage;
//}



-(UILabel *)titleLab
{
    if (_titleLab == nil)
    {
        self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0,wScreenW-20, 44)];
        self.titleLab.font = zhongFont;
        self.titleLab.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_titleLab];
        
    }
    return _titleLab;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
