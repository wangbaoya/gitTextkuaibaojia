//
//  WBYsecondModel.h
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "WBYinterestsModel.h"
@protocol WBYsecondModel <NSObject>
@end

@interface WBYsecondModel : JSONModel
@property(nonatomic,strong)NSString <Optional> * name;
@property(nonatomic,strong)NSString <Optional> * short_name;
@property(nonatomic,strong)NSString <Optional> * is_main;
@property(nonatomic,strong)NSString <Optional> * pid;
@property(nonatomic,strong)NSArray <WBYinterestsModel,Optional> * interests;


@end
