//
//  WBYPay_periodModel.h
//  whm_project
//
//  Created by apple on 17/2/6.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol WBYPay_periodModel <NSObject>

@end
@interface WBYPay_periodModel : JSONModel
@property(nonatomic,copy)NSString * key;
@property(nonatomic,copy)NSString * val;
@end
