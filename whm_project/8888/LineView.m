//
//  LineView.m
//  搜索框
//
//  Created by apple on 17/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "LineView.h"

@implementation LineView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)init{
    
    if (self = [super init]) {
        
      

    }
    
    return self;
    
}
//- (void)drawRect:(CGRect)rect
//{
//  /*  // 画直线
//    // 画布
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    //    这条线的起点终点
//    CGContextMoveToPoint(context, 0, 10);
//    CGContextAddLineToPoint(context, self.bounds.size.width, 100);//设置终点。
//    // 设置当前线的宽度
//    CGContextSetLineWidth(context, 1);
//    
//    //    设置当前线的颜色
//    CGContextSetRGBStrokeColor(context, 68.0/255,103.0/255/255,255.0/255,1.0);
//    //     连接这两个点
//    CGContextStrokePath(context);
//  
//    */
//  
//    
//    //写文字
//  
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetRGBStrokeColor(context,68.0/255,103.0/255/255,255.0/255,1.0);
//    CGContextSetLineWidth(context, 2);
//     // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
//    CGContextAddArc(context, self.bounds.size.width/2, self.bounds.size.width/2,self.bounds.size.width/2-2,0,2*M_PI, 0);
////    CGContextDrawPath(context,kCGPathStroke);
//    
//    CGContextStrokePath(context);
//
//    
//        
//    
//    
//}



- (void)drawRect:(CGRect)rect {
//    [self simpleDraw];
    [self drawARCPath];
//    [self drawTrianglePath];
//    [self drawSecondBezierPath];
}

//画圆角矩形
-(void)simpleDraw
{
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, 20, 100, 100) cornerRadius:20];
    path.lineWidth = 5;
    
    //设置填充颜色
    UIColor* fillColor = [UIColor greenColor];
    [fillColor set];
    [path fill];
    
    //设置线的颜色，需要在填充颜色之后设置
    UIColor* lineColor = [UIColor redColor];
    [lineColor set];
    [path stroke];
}


//画圆弧
-(void)drawARCPath
{
    UIBezierPath* path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2,self.bounds.size.width/2) radius:self.bounds.size.width/2-4 startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    //连接处的样式
        path1.lineCapStyle = kCGLineCapSquare;
        //连接方式
        path1.lineJoinStyle = kCGLineCapSquare;
    
        path1.lineWidth = 2;
    
        UIColor* lineColor = [UIColor whiteColor];
        [lineColor set];
        [path1 stroke];
    
    
     CAShapeLayer *   layer = [CAShapeLayer layer];
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.lineWidth =  4.0f;
        layer.lineCap = kCALineCapRound;
        layer.lineJoin = kCALineJoinRound;
        layer.strokeColor = [UIColor colorWithRed:48.0/255 green:109.0/255 blue:211.0/255 alpha:1.0].CGColor;
        [self.layer addSublayer:layer];
    
    CGFloat aa=M_PI*2*_jiaodu/100+1.5*M_PI;
    
    
    UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2,self.bounds.size.width/2) radius:self.bounds.size.width/2-4 startAngle:1.5*M_PI endAngle:aa clockwise:YES];
    
    layer.path = path.CGPath;
    //连接处的样式
//    path.lineCapStyle = kCGLineCapSquare;
//    //连接方式
//    path.lineJoinStyle = kCGLineCapSquare;
//    
//    path.lineWidth = 5;
//    
//    UIColor* lineColor = [UIColor redColor];
//    [lineColor set];
//    [path stroke];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0.0);
    animation.toValue = @(1.0);
    layer.autoreverses = NO;
    animation.duration = 3.0;
    
    // 设置layer的animation
    [layer addAnimation:animation forKey:nil];
    
}

//画三角形
-(void)drawTrianglePath{
    UIBezierPath* path = [UIBezierPath bezierPath];
    //设置起点
    [path moveToPoint:CGPointMake(20, 300)];
    [path addLineToPoint:CGPointMake(150, 400)];
    [path addLineToPoint:CGPointMake(20, 400)];
    [path closePath];
    
    path.lineWidth = 5;
    
    UIColor* fillColor = [UIColor greenColor];
    [fillColor set];
    [path fill];
    
    UIColor* lineColor = [UIColor redColor];
    [lineColor set];
    [path stroke];
    
    
}

//画二次贝尔曲线
-(void)drawSecondBezierPath{
    UIBezierPath* path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(200, 150)];
    [path addQuadCurveToPoint:CGPointMake(200, 300) controlPoint:CGPointMake(50, 50)];
    path.lineWidth = 5;
    
    UIColor* lineColor = [UIColor redColor];
    [lineColor set];
    [path stroke];
}


@end
