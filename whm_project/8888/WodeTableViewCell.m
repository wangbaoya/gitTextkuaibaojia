//
//  WodeTableViewCell.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WodeTableViewCell.h"

@implementation WodeTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.bounds = CGRectMake(0, 0, wScreenW, HANGGAO);
        [self creatMyView];
    }
    return self;
}

-(void)creatMyView
{
    CGFloat ww = wScreenW;
    CGFloat hh = self.bounds.size.height;
    
//    CGFloat hh1 = (self.bounds.size.height-10*2)/2;

    
    self.myImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 30, 30)];
    [self addSubview:self.myImg];
    
    self.lefLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.myImg.frame)+10, 0, ww/3, hh)];
   
    [self addSubview:self.lefLab];
       
    
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
