//
//  XiangxidizhiViewController.h
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface XiangxidizhiViewController : BaseViewController
@property(nonatomic,copy)void(^mydizhiBlock)(NSString * dizhi);
@property(nonatomic,copy)NSString * dizhi;
@end
