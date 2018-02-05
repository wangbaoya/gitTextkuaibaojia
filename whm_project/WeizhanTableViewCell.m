//
//  WeizhanTableViewCell.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WeizhanTableViewCell.h"

@implementation WeizhanTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.bounds = CGRectMake(0, 0, wScreenW,90);
        
        [self creatMyView];
    }
    return self;
}

-(void)creatMyView
{
    CGFloat hh1 = 10;
    
    self.companyImage =[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 70)];
    [self addSubview:self.companyImage];
    
    
    self.titLaber = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.companyImage.frame)+10, hh1,wScreenW-80-20-10, 30)];
    self.titLaber.textColor = wBlackColor;
    self.titLaber.font = zhongFont;
    
    [self addSubview:self.titLaber];
    
    
    self.ageLaber = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.companyImage.frame)+10, CGRectGetMaxY(self.titLaber.frame),CGRectGetWidth(self.titLaber.frame) , 20)];
    self.ageLaber.textColor = QIANZITIcolor;
    self.ageLaber.font = xiaoFont;
    [self addSubview:self.ageLaber];
    
    self.chanpin = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.companyImage.frame)+10,  CGRectGetMaxY(self.ageLaber.frame), CGRectGetWidth(self.titLaber.frame), 20)];
    self.chanpin.textColor = QIANZITIcolor;
    self.chanpin.font = xiaoFont;
    
    [self addSubview:self.chanpin];
    
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
