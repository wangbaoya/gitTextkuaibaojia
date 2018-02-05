//
//  WHjiluTableViewCell.m
//  whm_project
//
//  Created by 王义国 on 17/2/10.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WHjiluTableViewCell.h"


@implementation WHjiluTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self creatMyview];
    }
    return self;
}

-(void)creatMyview
{
    CGFloat hh = self.bounds.size.height + 10;
    CGFloat hh1 = 5;
    CGFloat hh2 = hh - hh1 * 2;
    
    self.headImg = [[UIImageView alloc]init];
    self.headImg.frame = CGRectMake(5, hh1, hh2 , hh2);
    self.headImg.layer.masksToBounds = YES;
    self.headImg.layer.cornerRadius = hh2/2;
    [self addSubview:_headImg];
    
    self.moneyLaber = [[UILabel alloc]init];
    self.moneyLaber.frame = CGRectMake(CGRectGetMaxX(self.headImg.frame)+5, CGRectGetMinY(self.headImg.frame),wScreenW/4, 20);
    self.moneyLaber.font = zhongFont;
    self.moneyLaber.textColor = wBlackColor;
    self.moneyLaber.textAlignment = NSTextAlignmentRight;
    [self addSubview:_moneyLaber];
    
    
    self.myTitLaber = [[UILabel alloc]init];
    self.myTitLaber.frame = CGRectMake(CGRectGetMaxX(self.moneyLaber.frame), CGRectGetMinY(self.moneyLaber.frame), wScreenW-wScreenW/4-hh2-5-10, 20);
    self.myTitLaber.textColor = QIANZITIcolor;
    self.myTitLaber.font = xiaoFont;
    [self addSubview:_myTitLaber];
    
    self.daiLiLaber = [[UILabel alloc]init];
    self.daiLiLaber.frame = CGRectMake(CGRectGetMinX(self.moneyLaber.frame), CGRectGetMaxY(self.moneyLaber.frame)+3, CGRectGetWidth(self.moneyLaber.frame), 20);
//    self.daiLiLaber.textColor = [UIColor colorWithHex:0x666666];
    self.daiLiLaber.font = xiaoFont;
    [self addSubview:_daiLiLaber];
    
    self.timeLaber = [[UILabel alloc]init];
    self.timeLaber.frame = CGRectMake(CGRectGetMinX(self.myTitLaber.frame), CGRectGetMinY(self.daiLiLaber.frame), CGRectGetWidth(self.myTitLaber.frame), CGRectGetHeight(self.myTitLaber.frame));
    self.timeLaber.textColor = QIANZITIcolor;
    self.timeLaber.font = xiaoFont;
    [self addSubview:_timeLaber];
    
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
