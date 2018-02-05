//
//  AttrsModel.h
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/7/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol AttrsModel <NSObject>

@end
@interface AttrsModel : JSONModel
@property(nonatomic,strong)NSString <Optional> * name;
@property(nonatomic,strong)NSString <Optional> * val;

@end
