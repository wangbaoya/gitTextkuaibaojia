//
//  ShouYETableViewCell.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ShouYETableViewCell.h"

@implementation ShouYETableViewCell
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
    CGFloat hh1 = (HANGGAO-35)/2;
//    CGFloat hh2 = hh - hh1 * 2;
    
    self.lImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, hh1, 35, 35)];
    
    [self addSubview:self.lImg];
    
    self.midLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.lImg.frame)+10, 0, wScreenW-35-20-30, hh)];
    self.midLab.textColor = wBlackColor;
    [self addSubview:self.midLab];
    
    
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
