//
//  myScrollView.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "myScrollView.h"

@implementation myScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (gestureRecognizer.state != 0)
    {
        return YES;
    } else {
        return NO;
    }
}
@end
