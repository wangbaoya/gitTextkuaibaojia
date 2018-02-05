//
//  XianzhongliebiaoTableViewCell.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XianzhongliebiaoTableViewCell.h"

@implementation XianzhongliebiaoTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.bounds = CGRectMake(0, 0, wScreenW, 110);
        [self creatMyView];
    }
    return self;
}

-(void)creatMyView
{
    CGFloat hh = self.bounds.size.height;
    CGFloat hh1 = 13;
    CGFloat hh2 = hh - hh1 * 2;
    CGFloat hh3 =hh2/3;
    
    CGFloat midww = (wScreenW-hh2-hh1-10-10)/2;
    
    self.lImg = [[UIImageView alloc] initWithFrame:CGRectMake(hh1, hh1,hh2, hh2)];
    [self addSubview:self.lImg];
    
    self.upLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.lImg.frame)+10, hh1, wScreenW-hh1-hh2-10-10,2*hh3)];
    self.upLab.numberOfLines = 0;
    self.upLab.textColor = wBlackColor;
    self.upLab.font = zhongFont;
    [self addSubview:self.upLab];
    
    self.midL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.lImg.frame)+10, CGRectGetMaxY(self.upLab.frame), midww-8, hh3)];
    self.midL.textColor = QIANZITIcolor;
    self.midL.font = xiaoFont;
    [self addSubview:self.midL];
    
    self.midR = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.midL.frame), CGRectGetMaxY(self.upLab.frame), midww+8, hh3)];
    self.midR.textColor = QIANZITIcolor;
    self.midR.font = xiaoFont;
    [self addSubview:self.midR];
    
//    self.downL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.lImg.frame)+10, CGRectGetMaxY(self.midR.frame), 55, hh3)];
//    self.downL.textColor = QIANZITIcolor;
//    self.downL.font = xiaoFont;
//    
//    self.downL.layer.masksToBounds = YES;
//    self.downL.layer.cornerRadius = hh3/2;
//    
//    self.downL.layer.borderColor = FENGEXIANcolor.CGColor;
//    self.downL.layer.borderWidth = 0.3;
//    
//    [self addSubview:self.downL];
    
   }







- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
