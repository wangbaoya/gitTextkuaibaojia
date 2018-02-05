//
//  WBYxzxzTableViewCell.m
//  whm_project
//
//  Created by apple on 17/2/6.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WBYxzxzTableViewCell.h"

@implementation WBYxzxzTableViewCell
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
    CGFloat hh = self.bounds.size.height;
    CGFloat hh1 = 15;
    CGFloat hh2 = hh - hh1 * 2;
    
    self.img = [[UIImageView alloc] initWithFrame:CGRectMake(15, hh1, hh2, hh2)];
    self.img.layer.masksToBounds = YES;
    self.img.layer.cornerRadius = hh2/2;
    [self addSubview:self.img];
    
    
    self.myLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.img.frame)+8, 0, wScreenW-hh2-15-8-15, hh)];
    self.myLab.numberOfLines = 0;
    
    [self addSubview:self.myLab];
    
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
