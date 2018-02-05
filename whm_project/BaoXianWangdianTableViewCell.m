//
//  BaoXianWangdianTableViewCell.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BaoXianWangdianTableViewCell.h"

@implementation BaoXianWangdianTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.bounds = CGRectMake(0, 0, wScreenW, 100);
        [self creatMyView];
    }
    return self;
}

-(void)creatMyView
{
    CGFloat hh = self.bounds.size.height;
    CGFloat hh1 = 10;
    CGFloat hh2 = hh - hh1 * 2;
    CGFloat lithhh =(hh-20)/4;
    
    self.imgBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.imgBut.frame = CGRectMake(hh1, hh1, hh2, hh2);
//    self.imgBut.layer.masksToBounds = YES;
//    self.imgBut.layer.cornerRadius = hh2/2;
    [self addSubview:self.imgBut];
    
    self.titLaber = [[UILabel alloc] init];
    self.titLaber.frame = CGRectMake(CGRectGetMaxX(self.imgBut.frame)+10, hh1,wScreenW-30-hh2, lithhh*2);
    self.titLaber.font = zhongFont;
    self.titLaber.numberOfLines = 0;
    [self addSubview:_titLaber];
    
    self.addressLaber = [[UILabel alloc]init];
    self.addressLaber.frame = CGRectMake(CGRectGetMinX(self.titLaber.frame), CGRectGetMaxY(self.titLaber.frame), CGRectGetWidth(self.titLaber.frame), lithhh);
    self.addressLaber.font = xiaoFont;
    [self addSubview:_addressLaber];
    
    self.mapImg = [[UIImageView alloc]init];
    self.mapImg.frame = CGRectMake(CGRectGetMinX(self.addressLaber.frame), CGRectGetMaxY(self.addressLaber.frame)+2, lithhh-4, lithhh-4);
    self.mapImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e60f", 25, Wqingse)];
    [self addSubview:_mapImg];
    
    self.mapLaber = [[UILabel alloc]init];
    self.mapLaber.frame = CGRectMake(CGRectGetMaxX(self.mapImg.frame)+5, CGRectGetMaxY(self.addressLaber.frame),60, lithhh);
//    self.mapLaber.textColor = [UIColor greenColor];
    self.mapLaber.font = XIAOZITI;
    [self addSubview:_mapLaber];
    
    self.telImg =  [[UIImageView alloc]init];
    self.telImg.frame = CGRectMake(CGRectGetMaxX(self.mapLaber.frame)+10, CGRectGetMinY(self.mapImg.frame), CGRectGetWidth(self.mapImg.frame), CGRectGetHeight(self.mapImg.frame));
    self.telImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e628",25,DianhuaColor)];

    [self addSubview:_telImg];
    
    
    
    self.telBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.telBut.frame = CGRectMake(CGRectGetMaxX(self.telImg.frame)+5, CGRectGetMaxY(self.addressLaber.frame),150 ,lithhh);
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
