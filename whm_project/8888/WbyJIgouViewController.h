//
//  WbyJIgouViewController.h
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface WbyJIgouViewController : BaseViewController
@property(nonatomic,strong)NSString * type;

@property(nonatomic,copy)void(^myGongsi)(NSString * myId,NSString*myName);
@end
