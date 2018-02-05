//
//  AAtijiantuOneTableViewCell.m
//  whm_project
//
//  Created by apple on 17/3/22.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "AAtijiantuOneTableViewCell.h"

@implementation AAtijiantuOneTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.bounds = CGRectMake(0, 0, wScreenW, 160+10);
        [self creatMyView];
    }
    return self;
}

-(void)creatMyView
{
//    CGFloat weight = wScreenW/3;
    self.lImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
    
    [self addSubview:self.lImg];
    
    self.rLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.lImg.frame)+3, 0, wScreenW-30-10-10, 40)];

    self.rLab.font = daFont;
    [self addSubview:self.rLab];
    
    
    
    NSArray * onearr = @[@"年交保费",@"总保额"];
    for (NSInteger i = 0; i<2; i++)
    {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(wScreenW/2*i, CGRectGetMaxY(self.rLab.frame)+65, wScreenW/2, 45+20)];
        view.layer.borderColor = wBaseColor.CGColor;
        view.layer.borderWidth = 0.6;
        [self addSubview:view];
        
        UILabel * alab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW/2*i, CGRectGetMaxY(self.rLab.frame)+65, wScreenW/2, 30)];
        alab.textAlignment = 1;
        alab.font = zhongFont;
        alab.textColor = ZTCOlor;
        alab.text = onearr[i];
        [self addSubview:alab];
        
        
        
    }
  
    self.fourLab = [[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.rLab.frame)+30+5+ 65, wScreenW/2,30)];
    self.fourLab.textAlignment = 1;
    self.fourLab.font = zhongFont;
    self.fourLab.textColor = wRedColor;
    [self addSubview:self.fourLab];
    
    
    self.fiveLab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW/2,CGRectGetMaxY(self.rLab.frame)+30+5+ 65, wScreenW/2, 30)];
    self.fiveLab.textAlignment = 1;
    self.fiveLab.font = zhongFont;
    self.fiveLab.textColor = wRedColor;
    [self addSubview:self.fiveLab];
  
    
    
//    self.oneLab = [[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.rLab.frame)+30+5, weight, 20+10)];
//    self.oneLab.textAlignment = 1;
//    self.oneLab.font = ZT14;
//    [self addSubview:self.oneLab];
//    
//    self.twoLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.oneLab.frame), CGRectGetMinY(self.oneLab.frame), weight, CGRectGetHeight(self.oneLab.frame))];
//    self.twoLab.textAlignment = 1;
//    self.twoLab.font = ZT14;
//    [self addSubview:self.twoLab];
//  
//    self.threeLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.twoLab.frame),CGRectGetMinY(self.oneLab.frame), weight,CGRectGetHeight(self.oneLab.frame))];
//    self.threeLab.textAlignment = 1;
//    self.threeLab.font = ZT14;
//    [self addSubview:self.threeLab];
// 
  //
//    
    
}

-(void)setModel:(AAwprosModel *)model
{
    
//    [_oneLab removeFromSuperview];
//    [_twoLab removeFromSuperview];
    
    if (model.params.count>=1)
    {
        
        CGFloat weight = wScreenW/model.params.count;
        
        
        for (NSInteger i = 0; i<model.params.count; i++)
        {
            WBYparamsModel * amodel = model.params[i];
            _oneView = [[UIView alloc] initWithFrame:CGRectMake(weight*i, CGRectGetMaxY(self.rLab.frame), weight, 45+20)];
            _oneView.layer.borderColor = wBaseColor.CGColor;
            _oneView.layer.borderWidth = 0.6;
            [self addSubview:_oneView];
            
            _oneLab = [[UILabel alloc] initWithFrame:CGRectMake(weight*i, CGRectGetMaxY(self.rLab.frame)+5, weight, 30)];
            _oneLab.textAlignment = 1;
            _oneLab.font = zhongFont;
            _oneLab.textColor = ZTCOlor;
            _oneLab.text = amodel.name;
            [self addSubview:_oneLab];
            
           _twoLab = [[UILabel alloc] initWithFrame:CGRectMake(weight*i, CGRectGetMaxY(self.rLab.frame)+5+30, weight, 30)];
            _twoLab.textAlignment = 1;
            _twoLab.font = zhongFont;
            _twoLab.textColor = ZTCOlor;
            _twoLab.text = amodel.val;
            [self addSubview:_twoLab];
            
        }
        
    }
  
    
   
    
    
    
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
