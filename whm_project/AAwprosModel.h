//
//  AAwprosModel.h
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "WBYparamsModel.h"

@protocol AAwprosModel <NSObject>
@end
@interface AAwprosModel : JSONModel
@property(nonatomic,copy)NSString<Optional> * id;
@property(nonatomic,copy)NSString<Optional> * short_name;
@property(nonatomic,copy)NSString<Optional> * name;
@property(nonatomic,copy)NSString<Optional> * company_id;
@property(nonatomic,copy)NSString<Optional> * limit_age_name;
@property(nonatomic,copy)NSString<Optional> * ins_type;
@property(nonatomic,copy)NSString<Optional> * is_main;
@property(nonatomic,copy)NSString<Optional> * pro_type_code_name;
@property(nonatomic,copy)NSString<Optional> * img;
@property(nonatomic,copy)NSString<Optional> * logo;

@property(nonatomic,strong)NSString <Optional> * age;
@property(nonatomic,strong)NSString <Optional> * gender;
@property(nonatomic,strong)NSString <Optional> * input_num;
@property(nonatomic,strong)NSString <Optional> * insured;
@property(nonatomic,strong)NSString <Optional> * pay_period;
@property(nonatomic,strong)NSString <Optional> * period;
@property(nonatomic,strong)NSString <Optional> * insurance_period;

//insurance_period

@property(nonatomic,strong)NSString <Optional> * pid;
@property(nonatomic,strong)NSString <Optional> * pro_name;
@property(nonatomic,strong)NSString <Optional> * rate;
@property(nonatomic,strong)NSString <Optional> * ret_num;
@property(nonatomic,strong)NSString <Optional> * score;
@property(nonatomic,strong)NSString <Optional> * payout;

@property(nonatomic,strong)NSArray<WBYparamsModel,Optional>* params;

//score payout

@end
