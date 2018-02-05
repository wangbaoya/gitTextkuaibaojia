//
//  WBYduibiiiTableViewCell.m
//  whm_project
//
//  Created by apple on 17/3/10.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WBYduibiiiTableViewCell.h"

@implementation WBYduibiiiTableViewCell
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
//    CGFloat hh = self.bounds.size.height;
//    CGFloat hh1 = 10;
//    CGFloat hh2 = hh - hh1 * 2;
    
    self.selBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.selBut.frame = CGRectMake(10, 10, 30, 30);
//    self.selBut.layer.masksToBounds = YES;
//    self.selBut.layer.cornerRadius = 10;
    [self addSubview:_selBut];

    
    
    self.myTitlaber = [[UILabel alloc]init];
    self.myTitlaber.frame = CGRectMake(CGRectGetMaxX(self.selBut.frame)+10, 0, wScreenW-30-20-10, 50);
    self.myTitlaber.textColor = QIANZITIcolor;
    self.myTitlaber.font = daFont;
    [self addSubview:_myTitlaber];

    
    
    
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
