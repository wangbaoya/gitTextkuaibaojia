//
//  WeizhanTwoTableViewCell.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WeizhanTwoTableViewCell.h"

@implementation WeizhanTwoTableViewCell


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
//    CGFloat hh = self.bounds.size.height;
    CGFloat hh1 = 10;
    
    self.oneLab = [[UILabel alloc] initWithFrame:CGRectMake(10, hh1, wScreenW, 20)];
    self.oneLab.textColor = wBlackColor;
    self.oneLab.font = ZT14;
    [self addSubview:self.oneLab];
    
    
    self.twoLab = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.oneLab.frame), 90, 10)];
    self.twoLab.textColor = QIANZITIcolor;
    self.twoLab.font = ZT12;
    
    [self addSubview:self.twoLab];
    
    self.threeLab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW-wScreenW/3-10,  CGRectGetMaxY(self.oneLab.frame), wScreenW/3, 10)];
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
