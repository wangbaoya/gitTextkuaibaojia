//
//  WodebaodanceTableViewCell.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WodebaodanceTableViewCell.h"

@implementation WodebaodanceTableViewCell
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
    CGFloat hh2 = hh-2*hh1;
    CGFloat h = hh2/2;
    
    
    self.myImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 50, 50)];
    self.myImg.layer.masksToBounds = YES;
    self.myImg.layer.cornerRadius = 50/2;
    
    [self.contentView addSubview:self.myImg];
    
    
    self.upLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.myImg.frame)+10, hh1, wScreenW/3, h)];
    _upLab.textColor = wBlackColor;
    _upLab.font = daFont;
    [self.contentView addSubview:self.upLab];
    
    self.downLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.myImg.frame)+10, CGRectGetMaxY(self.upLab.frame), wScreenW/3, h)];
    
    _downLab.textColor = QIANZITIcolor;
    _downLab.font = zhongFont;
    [self.contentView addSubview:_downLab];
    
    self.sexLab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW-105-20-20, 25, 30, 30)];
    _sexLab.textColor = QIANZITIcolor;
    _sexLab.font = zhongFont;
    _sexLab.textAlignment = 1;
    [self.contentView addSubview:self.sexLab];
    
   _akehu = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.sexLab.frame),10+ 22.5, 1, 15)];
    _akehu.backgroundColor = QIANZITIcolor;
    
    [self.contentView addSubview:_akehu];
    
    _kehu = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_akehu.frame), 25, 60, 30)];
    
    _kehu.textColor = QIANZITIcolor;
    _kehu.textAlignment =1;
    _kehu.font = zhongFont;
    
    [self.contentView addSubview:_kehu];
    
   _bkehu = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.kehu.frame),10+ 22.5, 1, 15)];
    _bkehu.backgroundColor = QIANZITIcolor;
    
    [self.contentView addSubview:_bkehu];
    
    
    
    _jiantou = [UIImageView new];
    _jiantou.frame = CGRectMake(CGRectGetMaxX(_bkehu.frame)+5+2, 25+2.5, 25, 25);
    
    _jiantou.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e62f", 20, QIANZITIcolor)];
    
    [self.contentView addSubview:_jiantou];
    
    
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
