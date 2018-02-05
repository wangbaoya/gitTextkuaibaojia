//
//  XianZhongXiangQingDetileViewController.h
//  whm_project
//
//  Created by apple on 17/8/1.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XianZhongXiangQingDetileViewController : UIViewController
@property(nonatomic,strong)NSDictionary * myDic;
@property(nonatomic,copy) void (^successCallBack)(NSDictionary *responseDict);
@property(nonatomic,copy)void (^errorCallBack)(NSError *error);

@property(nonatomic,strong)NSDictionary * denglumyDic;

@end
