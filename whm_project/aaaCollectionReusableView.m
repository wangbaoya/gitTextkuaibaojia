//
//  aaaCollectionReusableView.m
//  SearchHistory
//
//  Created by apple on 17/5/23.
//  Copyright © 2017年 机智的新手. All rights reserved.
//

#import "aaaCollectionReusableView.h"

@implementation aaaCollectionReusableView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        
//        self.backgroundColor = ji;

        _title = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, frame.size.width, frame.size.height-10)];
        _title.font = daFont;
        _title.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_title];
     
        _qingchuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _qingchuBtn.frame = CGRectMake(wScreenW-60, 10, 50, frame.size.height-10);
        [_qingchuBtn setTitle:@"清空" forState:UIControlStateNormal];
        [_qingchuBtn setTitleColor:QIANZITIcolor forState:UIControlStateNormal];
        _qingchuBtn.backgroundColor = wWhiteColor;
        
        [self addSubview:_qingchuBtn];
        
        _aLab = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-0.5, wScreenW, 0.5)];
        
        _aLab.backgroundColor = FENGEXIANcolor;
        
        [self addSubview:_aLab];
        
        
    }
    return self;
}

@end
