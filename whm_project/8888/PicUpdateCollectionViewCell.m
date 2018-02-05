//
//  PicUpdateCollectionViewCell.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PicUpdateCollectionViewCell.h"

@implementation PicUpdateCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.picImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (wScreenW - 60) / 3, (wScreenW - 60) /3)];
//        self.picImage.backgroundColor = [UIColor blueColor];
        self.picImage.layer.cornerRadius = 5;
        [self addSubview:_picImage];
        
        
        
    }
    return self;
}

@end
