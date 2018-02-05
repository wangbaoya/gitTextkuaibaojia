//
//  AACollectionViewCell.m
//  SearchHistory
//
//  Created by apple on 17/5/23.
//  Copyright © 2017年 机智的新手. All rights reserved.
//

#import "AACollectionViewCell.h"
CGFloat heightForCell = 35;

@implementation AACollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.aLab = [UILabel new];
        self.aLab.textAlignment = NSTextAlignmentCenter;
        
        self.aLab.layer.borderColor = FENGEXIANcolor.CGColor;
        self.aLab.layer.borderWidth = 0.5;
        self.aLab.font = Font(16);
        
        [self.contentView addSubview:self.aLab];
    }
    
    return self;
    
}

- (void)setKeyword:(NSString *)keyword {
    _keyword = keyword;
    _aLab.text = _keyword;
    [self layoutIfNeeded];
    [self updateConstraintsIfNeeded];
}

- (CGSize)sizeForCell
{
    //宽度加 heightForCell 为了两边圆角。
    return CGSizeMake([_aLab sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)].width + heightForCell, heightForCell);
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize sizeForFirstLabel = [self.aLab.text boundingRectWithSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width+10,50+4) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:Font(16)} context:nil].size;
    
    self.aLab.frame = CGRectMake(0, 0, sizeForFirstLabel.width+10, sizeForFirstLabel.height+10);
    
    CGRect frame = self.contentView.frame;
    
   frame.size = CGSizeMake(sizeForFirstLabel.width+10,sizeForFirstLabel.height+10);
    
    self.contentView.frame = frame;
    
    CGRect cellFrame = self.frame;
    
    cellFrame.size = self.contentView.frame.size;
    
    self.frame = cellFrame;
    
}



@end
