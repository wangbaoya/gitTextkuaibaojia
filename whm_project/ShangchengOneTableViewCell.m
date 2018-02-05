//
//  ShangchengOneTableViewCell.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/7/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ShangchengOneTableViewCell.h"

@implementation ShangchengOneTableViewCell
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
    CGFloat ww = wScreenW -100-20;
    
    CGFloat gao = (hh -20)/3;

    self.myImg = [[UIImageView alloc] initWithFrame:CGRectMake(wScreenW-110, hh1, 100, hh2)];
    
    [self addSubview:self.myImg];
    
    self.upLab = [[UILabel alloc] initWithFrame:CGRectMake(10, hh1, ww, gao)];
    self.upLab.textColor = [UIColor blackColor];
    self.upLab.font = zhongFont;
    [self addSubview:self.upLab];
    
    
    self.midLab = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.upLab.frame), ww, gao)];
    self.midLab.textColor = SHENZITIcolor;
    
    self.midLab.font = xiaoFont;
    [self addSubview:self.midLab];
    
    
    self.downLab = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.midLab.frame), ww, gao)];
    
    self.downLab.textColor = wRedColor;
    self.downLab.font =xiaoFont;
    
    
    [self addSubview:self.downLab];
    
    
    
    
    
    
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
