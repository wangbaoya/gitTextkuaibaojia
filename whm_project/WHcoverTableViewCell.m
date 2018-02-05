//
//  WHcoverTableViewCell.m
//  whm_project
//
//  Created by 王义国 on 16/11/17.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHcoverTableViewCell.h"
@implementation WHcoverTableViewCell
-(UIImageView *)companyImage
{
    if (_companyImage == nil) {
        self.companyImage = [[UIImageView alloc]init];
        self.companyImage.frame = CGRectMake(15, 15, 70, 70);
        [self.contentView addSubview:_companyImage];
    }
    return _companyImage;
}

-(UILabel*)titLaber
{
    if (_titLaber == nil) {
        self.titLaber = [[UILabel alloc]init];
        self.titLaber.frame = CGRectMake(CGRectGetMaxX(self.companyImage.frame)+10, 10, wScreenW*0.6, 30);
        
//        _titLaber.font = ZT14;
        [self.contentView addSubview:_titLaber];
    }
    return _titLaber;
}

-(UIImageView *)myImg
{
    if (_myImg == nil) {
        self.myImg = [[UIImageView alloc]init];
        self.myImg.frame = CGRectMake(wScreenW * 0.9, CGRectGetMinY(self.titLaber.frame), 30, 30);
        [self.contentView addSubview:_myImg];
        
    }
    return _myImg;
}
-(UILabel *)ageLaber
{
    if (_ageLaber == nil) {
        self.ageLaber = [[UILabel alloc]init];
        self.ageLaber.frame = CGRectMake(CGRectGetMinX(self.titLaber.frame), CGRectGetMaxY(self.titLaber.frame)+5, wScreenW*0.2, 20);
        self.ageLaber.text = @"投保年龄:";

        self.ageLaber.textColor = QIANZITIcolor;
        self.ageLaber.font = xiaoFont;
        [self.contentView addSubview:_ageLaber];
    }
    return _ageLaber;
}

-(UILabel *)ageTitle
{
    if (_ageTitle == nil) {
        self.ageTitle = [[UILabel alloc]init];
        self.ageTitle.frame = CGRectMake(CGRectGetMaxX(self.ageLaber.frame)+5, CGRectGetMinY(self.ageLaber.frame), CGRectGetWidth(self.ageLaber.frame), CGRectGetHeight(self.ageLaber.frame));
        self.ageTitle.textColor = QIANZITIcolor;
        self.ageTitle.font = xiaoFont;
        
        [self.contentView addSubview:_ageTitle];
    }
    return _ageTitle;
}

-(UILabel *)styLaber
{
    if (_styLaber == nil) {
        self.styLaber = [[UILabel alloc]init];
        self.styLaber.frame = CGRectMake(CGRectGetMinX(self.ageLaber.frame), CGRectGetMaxY(self.ageLaber.frame)+5, CGRectGetWidth(self.ageLaber.frame), CGRectGetHeight(self.ageLaber.frame));
        self.styLaber.textColor = QIANZITIcolor;
//        self.styLaber.font = [UIFont systemFontOfSize:12.0];
        self.styLaber.text = @"产品类型:";
        self.styLaber.font = xiaoFont;
        [self.contentView addSubview:_styLaber];
        
    }
    
    return _styLaber;
}

-(UILabel *)seyTitle
{
    if (_seyTitle == nil) {
        self.seyTitle = [[UILabel alloc]init];
        self.seyTitle.frame = CGRectMake(CGRectGetMinX(self.ageTitle.frame), CGRectGetMinY(self.styLaber.frame), 100, CGRectGetHeight(self.styLaber.frame));
        
        self.seyTitle.textColor = QIANZITIcolor;
        self.seyTitle.font = xiaoFont;
        [self.contentView addSubview:_seyTitle];
        
    }
    return _seyTitle;
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
