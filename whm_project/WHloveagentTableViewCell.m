//
//  WHloveagentTableViewCell.m
//  whm_project
//
//  Created by 王义国 on 16/11/18.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHloveagentTableViewCell.h"

@implementation WHloveagentTableViewCell
-(UIImageView *)myImage
{
    if (_myImage == nil)
    {
        self.myImage = [[UIImageView alloc]init];
        self.myImage.frame = CGRectMake(15,8,33,33);
        self.myImage.layer.masksToBounds = YES;
        self.myImage.layer.cornerRadius = 15;
        [self.contentView addSubview:_myImage];
    }
    return _myImage;
}

-(UILabel *)nameLaber
{
    if (_nameLaber == nil) {
        self.nameLaber = [[UILabel alloc]init];
        self.nameLaber.frame = CGRectMake(CGRectGetMaxX(self.myImage.frame)+10, 10, 80, 15);
        
        [self.contentView addSubview:_nameLaber];
    }
    return _nameLaber;
}

-(UIImageView * )sexImg
{
    if (_sexImg == nil) {
        self.sexImg = [[UIImageView alloc]init];
        self.sexImg.frame = CGRectMake(CGRectGetMaxX(self.nameLaber.frame)+5, CGRectGetMinY(self.nameLaber.frame), 15, 15);
        [self.contentView addSubview:_sexImg];
    }
    return _sexImg;
}

-(UILabel*)ageLaber
{
    if (_ageLaber == nil) {
        self.ageLaber = [[UILabel alloc]init];
        self.ageLaber.frame = CGRectMake(CGRectGetMaxX(self.sexImg.frame)+5, CGRectGetMinY(self.sexImg.frame), 40, 15);
        self.ageLaber.textColor = QIANZITIcolor;
        [self.contentView addSubview:_ageLaber];
    }
    return _ageLaber;
}

-(UILabel *)professLaber
{
    if (_professLaber == nil) {
        self.professLaber = [[UILabel alloc]init];
        self.professLaber.frame = CGRectMake(CGRectGetMinX(self.nameLaber.frame), CGRectGetMaxY(self.nameLaber.frame), wScreenW * 0.6, 15);
        self.professLaber.textColor = QIANZITIcolor;
        [self.contentView addSubview:_professLaber];
    }
    return _professLaber;
}


-(UIButton *)telBut
{
    if (_telBut == nil)
    {
        self.telBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.telBut.frame = CGRectMake(wScreenW-30-30,10 ,30, 30);
        [self.contentView addSubview:_telBut];
        
    }
    return _telBut;
}

-(void)setModel:(DataModel *)model
{
    _model = model;
    
   [self.myImage sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.nameLaber.text = model.name;
    self.nameLaber.font = zhongFont;
    self.nameLaber.textColor = wBlackColor;
    
    
    NSInteger sexM = [model.sex integerValue];
    if (sexM==1)
    {
       self.sexImg.image = [UIImage imageNamed:@"nande"];
    }else
    {
      self.sexImg.image = [UIImage imageNamed:@"nvde"];
        
    }
  
     self.ageLaber.text = [NSString stringWithFormat:@"%ld岁",[WBYRequest getAge:model.birthday]];
    
    self.ageLaber.font = xiaoFont;
    self.professLaber.text = model.oname?model.oname:@"暂无";
    
    self.professLaber.font = xiaoFont;
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
