//
//  AboutOneTableViewCell.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AboutOneTableViewCell.h"

@implementation AboutOneTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
    self.bounds = CGRectMake(0, 0, wScreenW, 230);
        [self creatMyView];
    }
    return self;
}

-(void)creatMyView
{   
    _cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(10,5,wScreenW-20,self.bounds.size.height-30) delegate:nil placeholderImage:[UIImage imageNamed:@"city"]];
    
//    _cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    _cycleScrollView2.pageControlStyle=SDCycleScrollViewPageContolStyleAnimated;
    [self addSubview:_cycleScrollView2];

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
