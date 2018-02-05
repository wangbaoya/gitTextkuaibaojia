//
//  WwRelaModel.h
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol WwRelaModel <NSObject>
@end

@interface WwRelaModel : JSONModel
@property(nonatomic,strong)NSString <Optional> * id;
@property(nonatomic,strong)NSString <Optional> * user;
@property(nonatomic,strong)NSString <Optional> * name;
@property(nonatomic,strong)NSString <Optional> * sex;
@property(nonatomic,strong)NSString <Optional> * birthday;
@property(nonatomic,strong)NSString <Optional> * yearly_income;
@property(nonatomic,strong)NSString <Optional> * yearly_out;
@property(nonatomic,strong)NSString <Optional> * debt;
@property(nonatomic,strong)NSString <Optional> * coverage;
@property(nonatomic,strong)NSString <Optional> * insured_amount;
@property(nonatomic,strong)NSString <Optional> * rate;
@property(nonatomic,strong)NSString <Optional> * relation;
@property(nonatomic,strong)NSString <Optional> * type;
@property(nonatomic,strong)NSString <Optional> * avatar;
@property(nonatomic,strong)NSString <Optional> * relation_name;




@end
