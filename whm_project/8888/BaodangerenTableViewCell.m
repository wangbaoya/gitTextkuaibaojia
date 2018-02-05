//
//  BaodangerenTableViewCell.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BaodangerenTableViewCell.h"

@implementation BaodangerenTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.bounds = CGRectMake(0, 0,wScreenW, 100);
        [self creatMyView];
    }
    return self;
}

-(void)creatMyView
{
    CGFloat hh = self.bounds.size.height;
    CGFloat hh1 = 12;
    CGFloat ww = (wScreenW-70-20-30)/2;

    CGFloat gaodu = (hh-hh1*2)/3;
    
    self.selectBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectBut.frame = CGRectMake(10, 30+5, 30, 30);
    [self.contentView addSubview:_selectBut];
    
    self.titLaber = [[UILabel alloc]init];
    self.titLaber.frame = CGRectMake(CGRectGetMaxX(self.selectBut.frame)+10, hh1,wScreenW-30-20-10, gaodu);
    self.titLaber.textColor = wBlackColor;
    self.titLaber.font = zhongFont;
    [self.contentView addSubview:_titLaber];
    
    
    self.baoeLaber = [[UILabel alloc]init];
    self.baoeLaber.frame = CGRectMake(CGRectGetMaxX(self.selectBut.frame)+10, CGRectGetMaxY(self.titLaber.frame),ww, gaodu);
    self.baoeLaber.textColor = QIANZITIcolor;
    self.baoeLaber.font = xiaoFont;
   
    [self.contentView addSubview:_baoeLaber];

    self.baofeiLaber = [[UILabel alloc] init];
    
    self.baofeiLaber.frame = CGRectMake(CGRectGetMaxX(self.baoeLaber.frame), CGRectGetMaxY(self.titLaber.frame), CGRectGetWidth(self.baoeLaber.frame), CGRectGetHeight(self.baoeLaber.frame));
    self.baofeiLaber.textColor = QIANZITIcolor;
    self.baofeiLaber.font = xiaoFont;
    [self.contentView addSubview:_baofeiLaber];
    
   
            self.scoreLaber = [[UILabel alloc]init];
            self.scoreLaber.frame = CGRectMake(wScreenW-70, CGRectGetMaxY(self.titLaber.frame), 60,gaodu);
            self.scoreLaber.textColor = [UIColor redColor];
            self.scoreLaber.font = xiaoFont;
            self.scoreLaber.textAlignment = 2;
            [self.contentView addSubview:_scoreLaber];
 
            self.delBut = [UIButton buttonWithType:UIButtonTypeCustom];
    
            self.delBut.frame = CGRectMake(0,CGRectGetMaxY(self.scoreLaber.frame)+5, wScreenW/2, gaodu);
            [self.delBut setTitleColor:QIANZITIcolor forState:UIControlStateNormal];
    
            self.delBut.titleLabel.font = xiaoFont;
            [self.delBut setTitle:@"   删除" forState:(UIControlStateNormal)];
    
            [self.delBut setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e63a",20, QIANZITIcolor)] forState:UIControlStateNormal];
            [self.contentView addSubview:_delBut];

    
    _lineView1 = [[UIView alloc] initWithFrame:CGRectMake(wScreenW/2,hh-gaodu, 1, gaodu)];
    
    _lineView1.backgroundColor = QIANZITIcolor;
    
    [self.contentView addSubview:_lineView1];
    self.lookBut = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.lookBut.frame = CGRectMake(wScreenW/2-1,CGRectGetMaxY(self.scoreLaber.frame)+5, wScreenW/2-1, gaodu);
    [self.lookBut setTitleColor:QIANZITIcolor forState:UIControlStateNormal];
    
    [self.lookBut setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e63b", 20, QIANZITIcolor)] forState:UIControlStateNormal];
    
    [self.lookBut setTitle:@"  查看报告" forState:(UIControlStateNormal)];
    self.lookBut.titleLabel.font = xiaoFont;
    [self.contentView addSubview:_lookBut];
    
    
    
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
