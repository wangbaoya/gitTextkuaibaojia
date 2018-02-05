//
//  WBYcaiwuTableViewCell.m
//  whm_project
//
//  Created by apple on 17/2/8.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WBYcaiwuTableViewCell.h"

@implementation WBYcaiwuTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.bounds = CGRectMake(0, 0, wScreenW, 70);
        
        [self creatMyView];
    }
    return self;
}

-(void)creatMyView
{

    CGFloat hh2 = 25;    
    self.myView = [[UIView alloc]init];
    self.myView.frame = CGRectMake(10, 5,wScreenW - 20, 60);
    self.myView.layer.cornerRadius = 8;
    self.myView.layer.masksToBounds = YES;
    self.myView.layer.borderWidth = 1 ;
    self.myView.layer.borderColor =UIColorFromHex(0xF5F7F9).CGColor;
    [self addSubview:_myView];
      
    
    self.headImg = [[UIImageView alloc] init];
    self.headImg.frame = CGRectMake(10, 10, 50, 50);
    self.headImg.layer.masksToBounds = YES;
    self.headImg.layer.cornerRadius = 50/2;
    [self addSubview:_headImg];
    
    
    self.nameLaber = [[UILabel alloc]init];
    self.nameLaber.frame = CGRectMake(CGRectGetMaxX(self.headImg.frame)+10,10,100, hh2);
    self.nameLaber.textColor = wBlackColor;
    self.nameLaber.font = zhongFont;
    [self addSubview:_nameLaber];
    
    
    self.tuiJianLaber = [[UILabel alloc]init];
    self.tuiJianLaber.frame = CGRectMake(wScreenW-10-10-40, 15,40,40);
    self.tuiJianLaber.textColor = [UIColor whiteColor];
    self.tuiJianLaber.backgroundColor = SHENLANSEcolor;
    self.tuiJianLaber.layer.masksToBounds = YES;
    self.tuiJianLaber.layer.cornerRadius = 20;
    self.tuiJianLaber.numberOfLines = 2;
    self.tuiJianLaber.font = xiaoFont;
    self.tuiJianLaber.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:_tuiJianLaber];

    
    
        self.dateLaber = [[UILabel alloc]init];
        self.dateLaber.frame = CGRectMake(wScreenW-60-130, CGRectGetMinY(self.nameLaber.frame), 130, CGRectGetHeight(self.nameLaber.frame));
        self.dateLaber.textColor = QIANZITIcolor;
        self.dateLaber.font = zhongFont;
        self.dateLaber.textAlignment = 1;
        [self addSubview:_dateLaber];

    
        self.renzhengLaber = [[UILabel alloc]init];
        self.renzhengLaber.frame = CGRectMake(CGRectGetMinX(self.nameLaber.frame), CGRectGetMaxY(self.nameLaber.frame), CGRectGetWidth(self.nameLaber.frame), CGRectGetHeight(self.nameLaber.frame));
        self.renzhengLaber.textColor = QIANZITIcolor;
        self.renzhengLaber.font = xiaoFont;
        [self addSubview:_renzhengLaber];
    
    
        self.telLaber = [[UILabel alloc]init];
        self.telLaber.frame = CGRectMake(CGRectGetMinX(self.dateLaber.frame), CGRectGetMinY(self.renzhengLaber.frame), CGRectGetWidth(self.dateLaber.frame), CGRectGetHeight(self.dateLaber.frame));
        self.telLaber.textColor = QIANZITIcolor;
        self.telLaber.font = xiaoFont;
        self.telLaber.textAlignment = 1;
        [self addSubview:_telLaber];

    
    
    
    
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
