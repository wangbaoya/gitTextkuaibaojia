//
//  WBYinterestsModel.h
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol WBYinterestsModel <NSObject>



@end
@interface WBYinterestsModel : JSONModel
@property(nonatomic,strong)NSString <Optional> * insured_amount;
@property(nonatomic,strong)NSString <Optional> * iid;
@property(nonatomic,strong)NSString <Optional> * name;
@property(nonatomic,strong)NSString <Optional> * calculation;
@property(nonatomic,strong)NSString <Optional> * no_calculation;
@property(nonatomic,strong)NSString <Optional> * most;
@property(nonatomic,strong)NSString <Optional> * show;
@property(nonatomic,strong)NSString <Optional> * content;
@property(nonatomic,strong)NSString <Optional> * premise;

@end
