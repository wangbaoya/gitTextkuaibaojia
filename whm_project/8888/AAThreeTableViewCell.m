//
//  AAThreeTableViewCell.m
//  whm_project
//
//  Created by apple on 17/4/1.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "AAThreeTableViewCell.h"

@implementation AAThreeTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
//        wScreenH-64-180-6-30
        self.bounds = CGRectMake(0, 0, wScreenW,200);
        [self creatMyView];
    }
    return self;
}

-(void)creatMyView
{
    CGFloat hh = self.bounds.size.height;
//    CGFloat hh1 = 10;
//    CGFloat hh2 = hh - hh1 * 2;
   
    self.myWeb = [[UIWebView alloc] initWithFrame:CGRectMake(10, 0, wScreenW-20, hh)];
    
    [self addSubview:self.myWeb];
    
}


-(void)setMyhtml:(NSString *)myhtml
{
    
    _myhtml = myhtml;
    
    CGFloat height = [WBYRequest getAutoHeightForString:[NSString stringWithFormat:@"   %@",_myhtml] withWidth:wScreenW-20 withFontSize:17];
    CGRect rect = self.myWeb.frame;
    
    rect.size.height = height;
    
    _myWeb.frame = rect;
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
