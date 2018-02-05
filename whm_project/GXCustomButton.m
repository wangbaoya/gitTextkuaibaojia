//
//  GXCustomButton.m
//  iconfont的使用
//
//  Created by apple on 17/5/11.
//  Copyright © 2017年 WOSHIPM. All rights reserved.
//

#import "GXCustomButton.h"

@implementation GXCustomButton


#pragma mark 设置Button内部的image的范围
 - (CGRect)imageRectForContentRect:(CGRect)contentRect
 {
     CGFloat imageW = contentRect.size.width;
     CGFloat imageH = contentRect.size.height * 0.5;
     return CGRectMake(0,3, imageW, imageH);
    }

 #pragma mark 设置Button内部的title的范围
 - (CGRect)titleRectForContentRect:(CGRect)contentRect
 {
       CGFloat titleY = contentRect.size.height *0.5;
      CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    
         return CGRectMake(0, titleY+3, titleW, titleH);
    }
@end
