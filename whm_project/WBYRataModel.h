//
//  WBYRataModel.h
//  whm_project
//
//  Created by apple on 17/1/20.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "WBYPay_periodModel.h"

@protocol WBYRataModel <NSObject>

@end

@interface WBYRataModel : JSONModel
@property(nonatomic,copy)NSString * age;
@property(nonatomic,copy)NSString * gender;
@property(nonatomic,copy)NSString * payout;
@property(nonatomic,copy)NSString * period;
@property(nonatomic,strong)NSArray <WBYPay_periodModel > * pay_period;


@end
