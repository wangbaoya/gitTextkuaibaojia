//
//  DingdianyiyuanTableViewCell.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DingdianyiyuanTableViewCell.h"

@implementation DingdianyiyuanTableViewCell
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
    
    CGFloat lithhh =(hh-20)/3;
    
    self.imgBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.imgBut.frame = CGRectMake(hh1, hh1, hh2, hh2);
    self.imgBut.layer.masksToBounds = YES;
    self.imgBut.layer.cornerRadius = hh2/2;
    [self addSubview:self.imgBut];
    
    self.titLaber = [[UILabel alloc] init];
    self.titLaber.frame = CGRectMake(CGRectGetMaxX(self.imgBut.frame)+10, hh1,wScreenW-20-hh2, lithhh);
    self.titLaber.font = zhongFont;
    self.titLaber.textColor = wBlackColor;
    
    [self addSubview:_titLaber];
    
    self.addressLaber = [[UILabel alloc]init];
    self.addressLaber.frame = CGRectMake(CGRectGetMinX(self.titLaber.frame), CGRectGetMaxY(self.titLaber.frame), CGRectGetWidth(self.titLaber.frame), lithhh);
    self.addressLaber.textColor = QIANZITIcolor;
    self.addressLaber.font = xiaoFont;
    [self addSubview:_addressLaber];
    
    
    self.mapImg = [[UIImageView alloc]init];
    self.mapImg.frame = CGRectMake(CGRectGetMinX(self.addressLaber.frame), CGRectGetMaxY(self.addressLaber.frame)+4, lithhh-8, lithhh-8);
    self.mapImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e60f", 25, Wqingse)];
    
    [self addSubview:_mapImg];
    
    self.mapLaber = [[UILabel alloc]init];
    self.mapLaber.frame = CGRectMake(CGRectGetMaxX(self.mapImg.frame)+5, CGRectGetMaxY(self.addressLaber.frame),70, lithhh);
//    self.mapLaber.textColor = QIANZITIcolor;
    
    self.mapLaber.font = xiaoFont;
    [self addSubview:_mapLaber];
    
    self.telImg =  [[UIImageView alloc]init];
    self.telImg.frame = CGRectMake(CGRectGetMaxX(self.mapLaber.frame)+5, CGRectGetMinY(self.mapImg.frame), CGRectGetWidth(self.mapImg.frame), CGRectGetHeight(self.mapImg.frame));
    self.telImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e628",25,DianhuaColor)];
    [self addSubview:_telImg];
    
    
    
    self.telBut = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.telBut.frame = CGRectMake(CGRectGetMaxX(self.telImg.frame)+5, CGRectGetMaxY(self.addressLaber.frame),wScreenW- CGRectGetMaxX(self.telImg.frame)-10 ,lithhh);
    [self.telBut setTitleColor:DianhuaColor forState:UIControlStateNormal];
    self.telBut.titleLabel.font = xiaoFont;
    self.telBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
    [self addSubview:_telBut];
    
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
