//
//  WBYrightsModel.h
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol WBYrightsModel <NSObject>


@end


@interface WBYrightsModel : JSONModel
@property(nonatomic,strong)NSString <Optional> * iid;
@property(nonatomic,strong)NSString <Optional> * calculation;
@property(nonatomic,strong)NSString <Optional> * no_calculation;
@property(nonatomic,strong)NSString <Optional> * most;
@property(nonatomic,strong)NSString <Optional> * premise;
@property(nonatomic,strong)NSString <Optional> * content;


@end
