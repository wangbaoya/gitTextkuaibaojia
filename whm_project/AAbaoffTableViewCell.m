//
//  AAbaoffTableViewCell.m
//  whm_project
//
//  Created by apple on 17/4/14.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "AAbaoffTableViewCell.h"

@implementation AAbaoffTableViewCell
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
    CGFloat hh = self.bounds.size.height;
//    CGFloat hh1 = 10;
//    CGFloat hh2 = hh - hh1 * 2;
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, wScreenW-20, hh)];
    
    _nameLabel.numberOfLines = 0;
    
    _nameLabel.font  = Font(14);
    [self addSubview:_nameLabel];
    
}


-(void)setModel:(WBYInsured *)model
{
//     CGFloat testHeight = [self sizeWithFont:[UIFont systemFontOfSize:17.0] maxW:wScreenW withContent:[NSString stringWithFormat:@"   %@", myMod.content]] + 20;
    _model = model;
    _nameLabel.text = [NSString stringWithFormat:@"    %@",_model.content.length>=1?_model.content:@"暂无"];
    
    CGFloat height = [WBYRequest getAutoHeightForString:[NSString stringWithFormat:@"   %@", model.content] withWidth:wScreenW-20 withFontSize:14]+20;
    CGRect rect = _nameLabel.frame;
    
    rect.size.height = height;
    
    _nameLabel.frame = rect;
    
    
    
    
    
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
