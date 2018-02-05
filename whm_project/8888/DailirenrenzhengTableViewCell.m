//
//  DailirenrenzhengTableViewCell.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DailirenrenzhengTableViewCell.h"

@implementation DailirenrenzhengTableViewCell
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
//    CGFloat hh1 = 10;
//    CGFloat hh2 = hh - hh1 * 2;
    
    self.aLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 90, hh)];
    self.aLab.font = daFont;
    self.aLab.textColor = wBlackColor;
    
    [self addSubview:self.aLab];
    
    self.aTf = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.aLab.frame), 0, wScreenW-20-90-10-8, hh)];
    self.aTf.textAlignment = 2;
    self.aTf.textColor = QIANZITIcolor;
    self.aTf.font = zhongFont;
    
    [self addSubview:self.aTf];
    
    
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
