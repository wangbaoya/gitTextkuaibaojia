//
//  ZhanghuxiangqingTableViewCell.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ZhanghuxiangqingTableViewCell.h"

@implementation ZhanghuxiangqingTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.bounds = CGRectMake(0, 0,wScreenW, HANGGAO);
        [self creatMyView];
    }
    return self;
}

-(void)creatMyView
{
    CGFloat hh = self.bounds.size.height;
    CGFloat hh1 = 5;
    CGFloat hh2 = hh - hh1 * 2;
    
    self.rLab = [UILabel new];
    self.rLab.font = daFont;
    [self addSubview:self.rLab];
    
    
    self.llab = [[UILabel alloc] initWithFrame:CGRectMake(10, hh1, 90, hh2)];
    self.llab.font = daFont;
    [self addSubview:self.llab];
    
    self.rTf  = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.llab.frame), hh1, wScreenW-90-20-10-8-5, hh2)];
    self.rTf.font = daFont;
    [self addSubview:self.rTf];
    
    _myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self addSubview:_myBtn];
    
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
