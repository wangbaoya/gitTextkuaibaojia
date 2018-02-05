//
//  TijianHeaderview.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TijianHeaderview.h"

@implementation TijianHeaderview

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        
        [self creatView];
        
    }
     return self;
}

-(void)creatView
{
    _listHeaderBtn =[[UIButton alloc]initWithFrame:CGRectMake(0,0 ,wScreenW, HANGGAO)];
    
    _listHeaderBtn.backgroundColor = wWhiteColor;
    [self addSubview:_listHeaderBtn];
    
    _downView = [[UIView alloc] initWithFrame:CGRectMake(0, HANGGAO-1, wScreenW, 1)];
    _downView.backgroundColor = FENGEXIANcolor;
    [self addSubview:_downView];

    self.lImg = [[UIImageView alloc] initWithFrame:CGRectMake(15,15, 30, 30)];
    [self addSubview:_lImg];
    
    
    _midLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_lImg.frame)+10, 0, wScreenW-15-23-10-32-6, HANGGAO)];
    _midLabel.textColor = wBlackColor;
    _midLabel.font = daFont;
    
    
    _midLabel.numberOfLines = 0;
    [self addSubview:_midLabel];
 
    
    self.rimg = [[UIImageView alloc] initWithFrame:CGRectMake(wScreenW - 10 - 22 , (HANGGAO-22)/2, 22, 22)];
    [self addSubview:self.rimg];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
