//
//  WproModel.h
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol WproModel

@end

@interface WproModel : JSONModel
@property(nonatomic,copy)NSString<Optional> * id;
@property(nonatomic,copy)NSString<Optional> * short_name;
@property(nonatomic,copy)NSString<Optional> * name;
@property(nonatomic,copy)NSString<Optional> * company_id;
@property(nonatomic,copy)NSString<Optional> * limit_age_name;
@property(nonatomic,copy)NSString<Optional> * ins_type;
@property(nonatomic,copy)NSString<Optional> * is_main;
@property(nonatomic,copy)NSString<Optional> * pro_type_code_name;
@property(nonatomic,copy)NSString<Optional> * img;




@end
