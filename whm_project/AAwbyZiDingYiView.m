//
//  AAwbyZiDingYiView.m
//  whm_project
//
//  Created by apple on 17/4/27.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "AAwbyZiDingYiView.h"

#import "YWActionPaopaoView.h"

@interface AAwbyZiDingYiView()
//{
//    UILabel                     *_titleLable;
//    UIView                      *_contentView;
//    YWActionPaopaoView          *_CalloutView;
//}
@end

@implementation AAwbyZiDingYiView

-(instancetype)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self=[super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier])
    {
       
        [self initMakeSubViews];
        
    }
    
    return self;
}


-(void)initMakeSubViews
{
    //需要根据字数的长度计算宽度
    
    UIView *contentView=[[ UIView alloc] init];
    [contentView setBackgroundColor:[UIColor clearColor]];
    
//    contentView.layer.masksToBounds = YES;
    contentView.layer.borderColor = wBlackColor.CGColor;
    contentView.layer.borderWidth = 0.5;
    

//    contentView.layer.cornerRadius = 10;
    _contentView=contentView;
    
    UILabel *lable=[[ UILabel alloc] init];
    lable.textColor=ZTCOlor;
    lable.font=Font(16);
    lable.textAlignment = 1;
    lable.numberOfLines = 0;
    _titleLable=lable;
    
    [contentView addSubview:lable];
    [self addSubview:contentView];
    
}
-(void)setTitleText:(NSString *)titleText{
    
    _titleLable.text=titleText;
    //计算高度
    
//    NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = Font(14);
//    
//   CGFloat Width  =  [titleText boundingRectWithSize:CGSizeMake(wScreenW-40,42) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
//    
//    
//    [_contentView setFrame:CGRectMake(0, 0, Width+20, 52)];
//    [_titleLable setFrame:CGRectMake(10,5, Width, 42)];
//    
    
//        NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
//        attrs[NSFontAttributeName] = Font(14);
//    
//       CGFloat Width  =  [titleText boundingRectWithSize:CGSizeMake(wScreenW-40,42) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
//    
    
    
    if (_titleLable.text.length>5)
    {
        [_contentView setFrame:CGRectMake(0, 0, 180+20, 52)];
        [_titleLable setFrame:CGRectMake(5,0, 180+10, 52)];
 
        
    }else
    {
        [_contentView setFrame:CGRectMake(0, 0, 80, 40)];
        [_titleLable setFrame:CGRectMake(0,0,80,40)];
  
        
    }

    
    CGRect rect = _contentView.bounds;
    //创建Path
    CGMutablePathRef layerpath = CGPathCreateMutable();
    CGPathMoveToPoint(layerpath, NULL, 0, 0);
    CGPathAddLineToPoint(layerpath, NULL, CGRectGetMaxX(rect), 0);
    CGPathAddLineToPoint(layerpath, NULL, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGPathAddLineToPoint(layerpath, NULL, 45, CGRectGetMaxY(rect));
    CGPathAddLineToPoint(layerpath, NULL, 37.5, CGRectGetMaxY(rect)+10);
    CGPathAddLineToPoint(layerpath, NULL, 30, CGRectGetMaxY(rect));
    CGPathAddLineToPoint(layerpath, NULL, 0, CGRectGetMaxY(rect));    
    
    
    CAShapeLayer *shapelayer=[CAShapeLayer  layer];
    UIBezierPath *path=[ UIBezierPath  bezierPathWithCGPath:layerpath];
    shapelayer.path=path.CGPath;
    shapelayer.fillColor=[UIColor whiteColor].CGColor;
    
    shapelayer.cornerRadius=5;
    
    
    [_contentView.layer addSublayer:shapelayer];
    [_contentView bringSubviewToFront:_titleLable];
    self.bounds=_contentView.bounds;
    
    //销毁Path
    CGPathRelease(layerpath);
    
    [ self layoutIfNeeded];
    [self setNeedsDisplay];
}
-(void)layoutSubviews{
    
    [ super layoutSubviews];
}


@end
