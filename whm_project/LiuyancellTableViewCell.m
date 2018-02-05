//
//  LiuyancellTableViewCell.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "LiuyancellTableViewCell.h"

@implementation LiuyancellTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.bounds = CGRectMake(0, 0, wScreenW, 50);
        
        [self creatMyView];
    }
    return self;
}

-(void)creatMyView
{
    CGFloat hh1 = 5;
    self.oneLab = [[UILabel alloc] initWithFrame:CGRectMake(10, hh1, wScreenW, 20)];
    self.oneLab.textColor = wBlackColor;
    self.oneLab.font = ZT14;
    [self addSubview:self.oneLab];
    
    
    self.twoLab = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.oneLab.frame), 95, 20)];
    self.twoLab.textColor = QIANZITIcolor;
    self.twoLab.font = ZT12;
    
    [self addSubview:self.twoLab];
    
    self.huifuLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.twoLab.frame), CGRectGetMaxY(self.oneLab.frame), 50, 20)];
    self.huifuLab.textColor = wWhiteColor;
    self.huifuLab.backgroundColor = SHENLANSEcolor;
    self.huifuLab.textAlignment = 1;
    self.huifuLab.font = ZT12;
    
    [self addSubview:self.huifuLab];
    
    self.threeLab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW-wScreenW/3-10,  CGRectGetMaxY(self.oneLab.frame), wScreenW/3, 20)];
    self.threeLab.textColor = QIANZITIcolor;
    self.threeLab.font = ZT12;
    self.threeLab.textAlignment = 2;
    
    [self addSubview:self.threeLab];
    
    
    
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
