//
//  WCPQTableViewCell.m
//  whm_project
//
//  Created by Stephy_xue on 16/12/27.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WCPQTableViewCell.h"
@implementation WCPQTableViewCell
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
    
    self.lefLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, hh)];
    self.lefLab.textColor = QIANZITIcolor;
    self.lefLab.textAlignment = 1;
    self.lefLab.font = ZT16;
    [self addSubview:self.lefLab];
    
    self.rigLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.lefLab.frame), 0,wScreenW-20-100-10, hh)];
    self.rigLab.textAlignment = 2;
    self.rigLab.textColor = QIANZITIcolor;
    self.rigLab.font = ZT16;
    [self addSubview:self.rigLab];
    
    UIView*vv = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.rigLab.frame), 0, 10, hh)];
    vv.backgroundColor = wWhiteColor;
    [self addSubview:vv];
    
    UIView*aaa = [[UIView alloc] initWithFrame:CGRectMake(10, hh-1, wScreenW-20, 1)];
    aaa.backgroundColor = FENGEXIANcolor;
    [self addSubview:aaa];
    
    
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
