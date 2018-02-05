//
//  XingmingViewController.h
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface XingmingViewController : BaseViewController

@property(nonatomic,copy)void(^myXingmingBlock)(NSString * name);

@property(nonatomic,copy)NSString * name;
@end
