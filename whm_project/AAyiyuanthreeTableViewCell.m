//
//  AAyiyuanthreeTableViewCell.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AAyiyuanthreeTableViewCell.h"

@implementation AAyiyuanthreeTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.bounds = CGRectMake(0, 0, wScreenW,100);
        
        [self creatMyView];
    }
    return self;
}

-(void)creatMyView
{
    CGFloat hh = self.bounds.size.height;
    //    CGFloat hh1 = 6;
    
    self.upLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, wScreenW-20, 30)];
    self.upLab.font = daFont;
    self.upLab.textColor = wBlackColor;
    
    [self addSubview:self.upLab];
    
    self.downLab = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.upLab.frame), wScreenW-20, hh-30)];
    self.downLab.numberOfLines = 0;
    self.downLab.textColor = ZTCOlor;
    self.downLab.font = zhongFont;
    
    [self addSubview:self.downLab];
    
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
