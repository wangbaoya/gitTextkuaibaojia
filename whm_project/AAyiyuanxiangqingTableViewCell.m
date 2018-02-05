//
//  AAyiyuanxiangqingTableViewCell.m
//  whm_project
//
//  Created by apple on 17/3/17.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "AAyiyuanxiangqingTableViewCell.h"

@implementation AAyiyuanxiangqingTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.bounds = CGRectMake(0, 0, wScreenW, 49);

        [self creatMyView];
    }
    return self;
}

-(void)creatMyView
{
    CGFloat hh = self.bounds.size.height;
//    CGFloat hh1 = 10;
//    CGFloat hh2 = hh - hh1 * 2;
    
    self.lLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, hh)];
    self.lLab.font = daFont;
    self.lLab.textColor = wBlackColor;
//    self.lLab.textAlignment = 1;
    [self addSubview:self.lLab];
  
    self.rLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.lLab.frame)+5, 0, wScreenW-10-10-80-10, hh)];
//    self.rLab.textAlignment=1;
    self.rLab.font = zhongFont;
    self.rLab.textColor = QIANZITIcolor;
    self.rLab.numberOfLines = 0;
    self.rLab.textAlignment = 2;
    [self addSubview:self.rLab];
    
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
