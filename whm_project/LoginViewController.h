//
//  LoginViewController.h
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController
@property(nonatomic,assign)BOOL isTabBar;

@property(nonatomic,copy)NSString * myStr;

@property(nonatomic,copy) void (^successCallBack)(NSDictionary *responseDict);
@property(nonatomic,copy)void (^errorCallBack)(NSError *error);
@property(nonatomic,copy)NSDictionary * myDic;

@end
