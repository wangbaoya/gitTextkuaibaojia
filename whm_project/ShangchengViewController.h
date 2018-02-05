//
//  ShangchengViewController.h
//  MYTEXT
//
//  Created by apple on 17/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface ShangchengViewController : BaseViewController

@property(nonatomic,copy) void (^successCallBack)(NSDictionary *responseDict);
@property(nonatomic,copy)void (^errorCallBack)(NSError *error);

@property(nonatomic,strong)NSDictionary * denglumyDic;

@end
