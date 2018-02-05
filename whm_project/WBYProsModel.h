//
//  AAProsModel.h
//  whm_project
//
//  Created by apple on 17/4/24.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol  WBYProsModel  <NSObject>

@end

@interface WBYProsModel : JSONModel

@property(nonatomic,strong)NSString <Optional> * age;
@property(nonatomic,strong)NSString <Optional> * gender;
@property(nonatomic,strong)NSString <Optional> * input_num;
@property(nonatomic,strong)NSString <Optional> * insured;
@property(nonatomic,strong)NSString <Optional> * pay_period;
@property(nonatomic,strong)NSString <Optional> * period;

@property(nonatomic,strong)NSString <Optional> * pid;
@property(nonatomic,strong)NSString <Optional> * pro_name;
@property(nonatomic,strong)NSString <Optional> * rate;
@property(nonatomic,strong)NSString <Optional> * ret_num;


@end
