//
//  TianjiaxinxianzhongViewController.h
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface TianjiaxinxianzhongViewController : BaseViewController

@property(nonatomic,copy)NSString * sex;
@property(nonatomic,copy)NSString * beibaoid;

@property(nonatomic,copy)NSString * myimg;

@property(nonatomic,copy)NSString * tianjiaXianzgong;

@property(nonatomic,strong)DataModel * aModel;

@property(nonatomic,copy)void(^xianzhongBlock)(NSString * str);

@end
