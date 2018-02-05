//
//  WBYbaofeiTableViewCell.m
//  whm_project
//
//  Created by apple on 17/3/7.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WBYbaofeiTableViewCell.h"

@implementation WBYbaofeiTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.bounds = CGRectMake(0, 0, wScreenW, HANGGAO);

        [self creatMyView];
    }
    return self;
}

-(void)creatMyView
{
    CGFloat hh = self.bounds.size.height;
    CGFloat hh1 = 0;
    CGFloat hh2 = hh - hh1 * 2;
    
    self.lLab = [UILabel new];
    self.lLab.frame = CGRectMake(10, hh1, wScreenW/3, hh2);
    [self addSubview:self.lLab];
   
    self.Rlab = [UITextField new];
    self.Rlab.frame = CGRectMake(CGRectGetMaxX(self.lLab.frame), hh1,wScreenW-wScreenW/3-10-30, hh2);
    
//    [self.Rlab setValue:[UIFont systemFontOfSize:10.0f] forKeyPath:@"_placeholderLabel.font"];
    
    [self addSubview:self.Rlab];
    
//    self.downTf = [UITextField new];    
//    
//    [self addSubview:self.downTf];
//    
//    self.myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    [self addSubview:self.myBtn];
//    
//    self.rBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    [self addSubview:self.rBtn];

    
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
