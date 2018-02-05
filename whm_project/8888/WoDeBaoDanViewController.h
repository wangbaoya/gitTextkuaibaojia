//
//  WoDeBaoDanViewController.h
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface WoDeBaoDanViewController : BaseViewController
@property(nonatomic,copy)NSString * tijian;
@property(nonatomic,copy)void(^tijianBlock)(DataModel * amodel);

@end
