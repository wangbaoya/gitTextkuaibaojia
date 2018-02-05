//
//  TianjiaxianzhongTableViewCell.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TianjiaxianzhongTableViewCell.h"

@implementation TianjiaxianzhongTableViewCell

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
//    CGFloat hh = self.bounds.size.height;
//    CGFloat hh1 = 10;
//    CGFloat hh2 = hh - hh1 * 2;
    
//    [cell.selectBut setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61b", 20, QIANZITIcolor)] forState:UIControlStateNormal];
//    [cell.selectBut setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61c", 20, wBlue)] forState:UIControlStateSelected];

    self.mybtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.mybtn.frame = CGRectMake(10, 19, 22, 22);
     [self.mybtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61b", 22, QIANZITIcolor)] forState:UIControlStateNormal];
    
    [self addSubview:self.mybtn];
    
    self.midImg = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.mybtn.frame)+10, 15, 30, 30)];

    [self addSubview:self.midImg];
    
    self.mylab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.midImg.frame)+10, 0, wScreenW-30-20-30-5,HANGGAO)];
    self.mylab.textColor = wBlackColor;
    self.mylab.numberOfLines = 0;
    self.mylab.font = zhongFont;
    [self addSubview:self.mylab];
    
    
    
    
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
