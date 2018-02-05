//
//  AAtijianTwoTableViewCell.m
//  whm_project
//
//  Created by apple on 17/3/29.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "AAtijianTwoTableViewCell.h"

@implementation AAtijianTwoTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
//        self.bounds = CGRectMake(0, 0, wScreenW, HANGGAO);
        
        [self creatMyView];
    }
    return self;
}

-(void)creatMyView
{
     CGFloat hh = HANGGAO;
//    self.lBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.lBtn.frame = CGRectMake(0,0,160, hh);
//    self.lBtn.titleLabel.font = ZT14;
//    [self addSubview:self.lBtn];
//    
//    self.rBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.rBtn.frame = CGRectMake(CGRectGetMaxX(self.lBtn.frame),0, wScreenW - CGRectGetWidth(self.lBtn.frame)-30, hh);
//    self.rBtn.titleLabel.font = ZT12;
//   
//    [self addSubview:self.rBtn];
 
    self.lLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, hh)];
    self.lLab.textColor = wBlackColor;
    self.lLab.font = Font(18);
    
    self.lLab.backgroundColor = wWhiteColor;
    [self addSubview:self.lLab];
    
    
    self.rLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.lLab.frame), 0, wScreenW - CGRectGetWidth(self.lLab.frame)-30, hh)];
    self.rLab.textColor = wRedColor;
    self.rLab.backgroundColor = wWhiteColor;
    self.rLab.font = Font(17);
    [self addSubview:self.rLab];
    
    
    self.downlab = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.rLab.frame), wScreenW-20, 0)];
//    self.downlab = [UILabel new];
    
    self.downlab.textColor = QIANZITIcolor;
    self.downlab.font = Font(16);
    self.downlab.numberOfLines = 0;
    self.downlab.hidden = YES;
    [self addSubview:self.downlab];
    
}

-(void)setAModel:(WBYinterestsModel *)aModel
{
    
    _aModel = aModel;
    
  self.downlab.text = [NSString stringWithFormat:@"    %@",_aModel.content.length>=1?_aModel.content:@"暂无"];
    
   CGFloat height = [WBYRequest getAutoHeightForString:[NSString stringWithFormat:@"   %@", _aModel.content] withWidth:wScreenW-20 withFontSize:16.0]+20;
    
    CGRect litRect = self.downlab.frame;
    
    litRect.size.height = height;
    
    self.downlab.frame = litRect;
    
//     self.downlab.text = [NSString stringWithFormat:@"    %@",_aModel.content.length>=1?_aModel.content:@"暂无"];
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
