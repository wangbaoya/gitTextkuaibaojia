//
//  ShangchengTwoTableViewCell.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/7/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ShangchengTwoTableViewCell.h"

@implementation ShangchengTwoTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.bounds = CGRectMake(0, 0, wScreenW, (wScreenW-20)/2+70);
        [self creatMyView];
    }
    return self;
}

-(void)creatMyView
{
//    CGFloat hh = self.bounds.size.height;
//    CGFloat hh1 = 10;
//    CGFloat hh2 = hh - hh1 * 2;
    
    self.myImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, wScreenW-20, (wScreenW-20)/2)];
    
    [self addSubview:self.myImg];
    
    self.upLab = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.myImg.frame)+10, wScreenW-20-80, 20)];
    self.upLab.textColor = [UIColor blackColor];
    self.upLab.font = zhongFont;
    [self addSubview:self.upLab];
    
    
    self.midLab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW-80-10, CGRectGetMaxY(self.myImg.frame)+10, 80, 20)];
    self.midLab.textColor = wRedColor;
    
    self.midLab.textAlignment = 2;
    self.midLab.font = zhongFont;
    [self addSubview:self.midLab];
    
    
    self.downLab = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.upLab.frame), wScreenW-20, 20)];
    
    self.downLab.textColor = SHENZITIcolor;
    self.downLab.font = xiaoFont;    
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
