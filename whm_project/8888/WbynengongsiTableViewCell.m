//
//  WbynengongsiTableViewCell.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WbynengongsiTableViewCell.h"

@implementation WbynengongsiTableViewCell
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
    CGFloat hh1 = 5;
    CGFloat hh2 = hh - hh1 * 2;
    
    self.myimg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    
    self.myimg.layer.masksToBounds = YES;
    self.myimg.layer.cornerRadius = 40/2;
    
    [self addSubview:self.myimg];
    
    self.aLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.myimg.frame)+10, 0, wScreenW-hh2-10-10-10, hh)];
    self.aLab.textColor = wBlackColor;
    self.aLab.numberOfLines = 0;
    self.aLab.font = daFont;
    [self addSubview:self.aLab];
    
    
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
