//
//  AAgsxqTableViewCell.m
//  whm_project
//
//  Created by apple on 17/3/24.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "AAgsxqTableViewCell.h"

@implementation AAgsxqTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.bounds = CGRectMake(0, 0, wScreenW, wScreenH-40-64);
        [self creatMyView];
    }
    return self;
}

-(void)creatMyView
{
    CGFloat hh = self.bounds.size.height;
    
    
    _myview = [[UIView alloc] initWithFrame:CGRectMake(10, 10, wScreenW-20, hh-20)];
    
    _myview.backgroundColor = wWhiteColor;
    
    [self addSubview:_myview];

    
    _myweb = [[UIWebView alloc]initWithFrame:CGRectMake(10,10, wScreenW-40, hh-40)];
    
    [_myview addSubview:_myweb];

    
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
