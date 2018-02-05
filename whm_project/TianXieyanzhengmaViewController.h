//
//  TianXieyanzhengmaViewController.h
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface TianXieyanzhengmaViewController : BaseViewController
@property(nonatomic,strong)NSString * phone;
@property(nonatomic,assign)BOOL isTabBar;
@property(nonatomic,copy)NSString * myStr;
@property(nonatomic,copy)NSDictionary * amyDic;

@property(nonatomic,copy)void(^myBlock)(NSDictionary * success,NSError * error);


@end
