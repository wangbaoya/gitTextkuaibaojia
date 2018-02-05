//
//  GuanzhuxiangzhongTableViewCell.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "GuanzhuxiangzhongTableViewCell.h"

@implementation GuanzhuxiangzhongTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.bounds = CGRectMake(0, 0, wScreenW,90);
        [self creatMyView];
    }
    return self;
}

-(void)creatMyView
{
    CGFloat hh = self.bounds.size.height;
    CGFloat hh1 = 10;
    CGFloat hh2 = hh - hh1 * 2;
    CGFloat hh3 =hh2/3;
    
    CGFloat midww = (wScreenW-hh2-hh1-10-10)/2;
    
    self.lImg = [[UIImageView alloc] initWithFrame:CGRectMake(hh1, hh1,hh2, hh2)];
    [self.contentView addSubview:self.lImg];
    
    self.upLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.lImg.frame)+10, hh1, wScreenW-hh1-hh2-10-10,2*hh3)];
    self.upLab.numberOfLines = 0;
    self.upLab.textColor = wBlackColor;
    self.upLab.font = zhongFont;
    [self.contentView addSubview:self.upLab];
    
    self.midL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.lImg.frame)+10, CGRectGetMaxY(self.upLab.frame), midww-10, hh3)];
    self.midL.textColor = QIANZITIcolor;
    self.midL.font = xiaoFont;
    [self.contentView addSubview:self.midL];
    
    self.midR = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.midL.frame), CGRectGetMaxY(self.upLab.frame), midww+10, hh3)];
    self.midR.textColor = QIANZITIcolor;
    self.midR.font = xiaoFont;
    [self.contentView addSubview:self.midR];
    
    
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
