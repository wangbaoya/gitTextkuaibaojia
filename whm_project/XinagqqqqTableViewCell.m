//
//  XinagqqqqTableViewCell.m
//  whm_project
//
//  Created by apple on 17/3/2.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "XinagqqqqTableViewCell.h"

@implementation XinagqqqqTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
    
        self.bounds = CGRectMake(0, 0, wScreenW, wScreenH-64-50-49);
        [self creatMyView];
    }
    return self;
}

-(void)creatMyView
{
    CGFloat hh = self.bounds.size.height;
//    CGFloat hh1 = 10;
//    CGFloat hh2 = hh - hh1 * 2;
    
    _myWebview = [[UIWebView alloc]initWithFrame:CGRectMake(10,0, wScreenW-20, hh)];
    _myWebview.userInteractionEnabled = YES;
    _myWebview.backgroundColor = wWhiteColor;
    [self addSubview:_myWebview];

    _myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_myBtn setImage:[UIImage imageNamed:@"aafenxiang"] forState:UIControlStateNormal];
    _myBtn.frame = CGRectMake(20,5+10,80,40);
    
    [self.myWebview addSubview:_myBtn];
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
