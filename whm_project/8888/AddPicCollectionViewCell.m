//
//  AddPicCollectionViewCell.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AddPicCollectionViewCell.h"

@implementation AddPicCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.addBtn.frame = CGRectMake(0, 0, (wScreenW - 60) / 3, (wScreenW - 60) / 3);
        [self addSubview:_addBtn];
        
    }
    return self;
}

@end
