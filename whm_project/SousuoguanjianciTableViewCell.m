//
//  SousuoguanjianciTableViewCell.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SousuoguanjianciTableViewCell.h"

@implementation SousuoguanjianciTableViewCell

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
    CGFloat hh1 = 15;
    CGFloat hh2 = hh - hh1 * 2;
    
    self.lImg = [[UIImageView alloc] initWithFrame: CGRectMake(8, 20, 20, 20)];
    [self addSubview:self.lImg];
    
    self.myLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.lImg.frame)+ 8, 0,wScreenW-8-hh2-8-10-60, hh)];
    self.myLab.textColor = wBlackColor;
    self.myLab.font = Font(16);
    self.myLab.numberOfLines = 0;
    [self addSubview:self.myLab];
    
    self.rLab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW-60-10, 15, 60, 30)];
    
    self.rLab.backgroundColor = JIANGEcolor;
    self.rLab.layer.masksToBounds = YES;
    self.rLab.layer.cornerRadius = 12;
    self.rLab.textColor = wBlackColor;
    self.rLab.textAlignment = 1;
    self.rLab.font = Font(12);
    [self addSubview:self.rLab];
    
    
    
}





@end
