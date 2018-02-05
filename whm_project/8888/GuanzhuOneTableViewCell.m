//
//  GuanzhuOneTableViewCell.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "GuanzhuOneTableViewCell.h"

@implementation GuanzhuOneTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.bounds = CGRectMake(0, 0, wScreenW, 60);
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
    
    
    self.myImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, hh1, hh2, hh2)];
    [self.contentView addSubview:self.myImg];
    
    
    self.upLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.myImg.frame)+10, hh1, wScreenW/3, h)];
    _upLab.textColor = wBlackColor;
    _upLab.font = zhongFont;
    [self.contentView addSubview:self.upLab];
    
    self.downLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.myImg.frame)+10, CGRectGetMaxY(self.upLab.frame), wScreenW/2, h)];
    
    _downLab.textColor = QIANZITIcolor;
    _downLab.font = xiaoFont;
    [self.contentView addSubview:_downLab];
    
    self.sexLab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW-10-30-10-10-20-1, 20, 20, 20)];
    _sexLab.textColor = QIANZITIcolor;
    _sexLab.font = zhongFont;
    _sexLab.textAlignment = 2;
    [self.contentView addSubview:self.sexLab];
    
    _shu = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.sexLab.frame)+10, 22.5, 1, 15)];
    _shu.backgroundColor = QIANZITIcolor;
    
    [self.contentView addSubview:_shu];
    
    _telbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _telbtn.frame = CGRectMake(wScreenW-30-10, 15, 30, 30);
    
    [_telbtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e628", 30, SHENLANSEcolor)] forState:UIControlStateNormal];
    
    [self.contentView addSubview:_telbtn];
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
