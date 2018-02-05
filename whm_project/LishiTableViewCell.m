
//
//  LishiTableViewCell.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "LishiTableViewCell.h"

@implementation LishiTableViewCell
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
//    CGFloat hh = self.bounds.size.height;
//    CGFloat hh1 = 10;
//    CGFloat hh2 = hh - hh1 * 2;
    
    self.myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, self.bounds.size.height)];
    
    [self addSubview:self.myView];
    

    
}

-(void)zidonghuan:(NSArray*)tarr onee:(NSInteger)abc indes:(NSIndexPath *)path
{
    CGFloat aaa = 0.0;
//
//    for (NSInteger i=0; i<50; i++)
//    {
//        UIButton * abtn =[cell viewWithTag:60*path.section + 500 + i];
//        
//        [abtn removeFromSuperview];
//    }
//    
//    [cell.abtn removeFromSuperview];
//    
//    while ([cell.contentView.subviews lastObject] != nil)
//    {
//        [(UIButton*)[cell.contentView.subviews lastObject] removeFromSuperview];
//    }
//    
    
    
    float butX = 15;
    float butY = 10;
    for(int i = 0; i < tarr.count; i++)
    {
        //宽度自适应
        NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
        
        CGRect frame_W;
        
        if (abc==0)
        {
            DataModel * mod = tarr[i];
            
            frame_W = [mod.name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
            
        }else if (abc==1)
        {
            WwordsModel * mod = tarr[i];
            
            frame_W = [mod.name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
            
            
        }else if (abc==2)
        {
            childModel * mod = tarr[i];
            
            frame_W = [mod.name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
            
        }else if(abc==6)
        {
            frame_W = [tarr[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
            
        }
        
        if (butX+frame_W.size.width+20>wScreenW-15)
        {
            butX = 15;
            butY += 55;
        }
        
        UIButton * abtn = [[UIButton alloc]initWithFrame:CGRectMake(butX, butY, frame_W.size.width+20, 40)];
        
        //        cell.abtn.frame = CGRectMake(butX, butY, frame_W.size.width+20, 40);
        
        if (abc==0)
        {
            DataModel * mod = tarr[i];
            
            [abtn setTitle:mod.name forState:UIControlStateNormal];
            
        }else if (abc==1)
        {
            WwordsModel * mod = tarr[i];
            [abtn setTitle:mod.name forState:UIControlStateNormal];
            
        }else if (abc==2)
        {
            childModel * mod = tarr[i];
            
            [abtn setTitle:mod.name forState:UIControlStateNormal];
        }else if(abc==6)
        {
            
            [abtn setTitle:tarr[i] forState:UIControlStateNormal];
            
        }
        
        [abtn setTitleColor:wBlackColor forState:UIControlStateNormal];
       abtn.titleLabel.font = [UIFont systemFontOfSize:13];
        abtn.layer.borderColor = FENGEXIANcolor.CGColor;
        abtn.layer.borderWidth = 0.5;
        
        abtn.tag = 60*path.section + 500 + i;
        
        [_myView addSubview:abtn];
        
        butX = CGRectGetMaxX(abtn.frame)+10;
        if (i==tarr.count-1)
        {
            NSLog(@"=rrr==%lf",butY+40);
            aaa = butY + 40;
        }
        
    }
    CGRect  rect = _myView.frame;
    rect.size.height = aaa + 20;
    _myView.frame = rect;
    
}






- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
