//
//  AAduibiTableViewCell.m
//  whm_project
//
//  Created by apple on 17/4/12.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "AAduibiTableViewCell.h"

@implementation AAduibiTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.bounds = CGRectMake(0, 0, wScreenW, 50);
        [self creatMyView];
    }
    return self;
}

-(void)creatMyView
{
    CGFloat hh = self.bounds.size.height;
    CGFloat hh1 = 10;
    CGFloat hh2 = hh - hh1 * 2;
    
    self.myImg = [[UIImageView alloc] initWithFrame:CGRectMake(hh1, hh1, hh2, hh2)];
    [self addSubview:self.myImg];
    
    self.midLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.myImg.frame)+5, 0, 60, hh)];
    
    [self addSubview:self.midLab];
    
    self.rLab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW-80, 0, 60, hh)];
    
    [self addSubview:self.rLab];
    
    
    
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
