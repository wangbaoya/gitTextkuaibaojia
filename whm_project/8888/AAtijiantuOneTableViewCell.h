//
//  AAtijiantuOneTableViewCell.h
//  whm_project
//
//  Created by apple on 17/3/22.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AAtijiantuOneTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView * lImg;
@property(nonatomic,strong)UILabel * rLab;

@property(nonatomic,strong)UIView * oneView;
@property(nonatomic,strong)UIView * twoVIew;
//@property(nonatomic,strong)UIView * threeView;
//@property(nonatomic,strong)UIView * fourView;
//@property(nonatomic,strong)UIView * fiveView;

@property(nonatomic,strong)UILabel * oneLab;
@property(nonatomic,strong)UILabel * twoLab;
//@property(nonatomic,strong)UILabel * threeLab;
@property(nonatomic,strong)UILabel * fourLab;
@property(nonatomic,strong)UILabel * fiveLab;

@property(nonatomic,strong)AAwprosModel * model;

@end
