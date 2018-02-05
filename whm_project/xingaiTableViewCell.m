//
//  xingaiTableViewCell.m
//  whm_project
//
//  Created by apple on 17/1/14.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "xingaiTableViewCell.h"

@implementation xingaiTableViewCell

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
    
    self.midLab = [[UILabel alloc] initWithFrame:CGRectMake(15,0,120, hh)];
    self.midLab.font = zhongFont;
    self.midLab.textColor = QIANZITIcolor;
    [self addSubview:self.midLab];
    
    self.rText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.midLab.frame), 0, wScreenW - 120-15-35, hh)];
    self.rText.font = zhongFont;
    self.rText.textAlignment = NSTextAlignmentRight;
    self.rText.textColor = wBlackColor;
    [self addSubview:self.rText];
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
