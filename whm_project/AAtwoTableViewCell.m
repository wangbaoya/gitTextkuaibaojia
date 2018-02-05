//
//  AAtwoTableViewCell.m
//  whm_project
//
//  Created by apple on 17/3/17.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "AAtwoTableViewCell.h"

@implementation AAtwoTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        self.bounds = CGRectMake(0, 0, wScreenW, 260);
        [self creatMyView];
    }
    return self;
}

-(void)creatMyView
{
    CGFloat hh = self.bounds.size.height;
//    CGFloat hh1 = 10;
//    CGFloat hh2 = hh - hh1 * 2;
    
    self.aLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, wScreenW-10, 30)];
    self.aLab.font = ZT16;
    
    
    [self addSubview:self.aLab];
    
    
    self.myView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.aLab.frame), wScreenW, hh-30)];
    
    [self addSubview:self.myView];
    
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
