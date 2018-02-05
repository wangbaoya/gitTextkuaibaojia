//
//  WangShouyeTableViewCell.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WangShouyeTableViewCell.h"
#define kuan (wScreenW-85-20-10-5)/3

@implementation WangShouyeTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.bounds = CGRectMake(0, 0, wScreenW, 80);
        [self creatMyView];
    }
    return self;
}

-(void)creatMyView
{
    CGFloat hh = self.bounds.size.height;
    CGFloat hh1 = 10;
    CGFloat hh2 = hh - hh1 * 2;
    
    self.myImg = [[UIImageView alloc] init];
    self.myImg.frame = CGRectMake(10,hh1,85, hh2);
    [self.contentView addSubview:_myImg];
    
    self.myTit =[[UILabel alloc] init];
    self.myTit.frame = CGRectMake(CGRectGetMaxX(self.myImg.frame)+10, 10, wScreenW-85-20-10-5, 40);
    self.myTit.font = zhongFont;
    self.myTit.textColor = wBlackColor;
    self.myTit.numberOfLines = 0;
    [self.contentView addSubview:_myTit];
    
    self.readNum = [[UILabel alloc]init];
    self.readNum.frame = CGRectMake(CGRectGetMinX(self.myTit.frame), CGRectGetMaxY(self.myTit.frame), kuan-15, 20);
    self.readNum.textColor = QIANZITIcolor;
    self.readNum.font = xiaoFont;
    [self.contentView addSubview:_readNum];
    
    self.styLaber = [[UILabel alloc]init];
    self.styLaber.frame = CGRectMake(CGRectGetMaxX(self.readNum.frame), CGRectGetMinY(self.readNum.frame), kuan+15, 20);
    self.styLaber.textColor = QIANZITIcolor;
    self.styLaber.font = xiaoFont;
    [self.contentView addSubview:_styLaber];
    
    self.timeLaber = [[UILabel alloc]init];
    self.timeLaber.frame = CGRectMake(wScreenW-kuan-10, CGRectGetMinY(self.readNum.frame), kuan, 20);
    self.timeLaber.font = xiaoFont;
    self.timeLaber.textColor = QIANZITIcolor;
    self.timeLaber.textAlignment =2;
    [self.contentView addSubview:_timeLaber];
    
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
