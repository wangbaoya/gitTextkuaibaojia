//
//  AboutmeTableViewCell.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AboutmeTableViewCell.h"

@implementation AboutmeTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {

        [self creatMyView];
    }
    return self;
}

-(void)creatMyView
{    
    _myLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, wScreenW-20, 20)];
    _myLab.textColor = QIANZITIcolor;
    _myLab.numberOfLines = 0;
    _myLab.font = Font(14);
    
    [self addSubview:_myLab];
   
}
- (void)setKeyword:(NSString *)keyword
{
    _keyword = keyword;
    _myLab.text = _keyword;
    CGRect rect = self.myLab.frame;
    
    CGFloat height = [WBYRequest getAutoHeightForString:[NSString stringWithFormat:@"   %@",_keyword] withWidth:wScreenW-20 withFontSize:14];
    
    rect.size.height = height+25;
     self.myLab.frame = rect;
    

  
}

-(void)layoutSubviews
{
    [super layoutSubviews];    
    
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
