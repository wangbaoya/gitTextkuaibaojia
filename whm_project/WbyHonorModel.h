//
//  WbyHonorModel.h
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol WbyHonorModel <NSObject>

@end
@interface WbyHonorModel : JSONModel

@property(nonatomic,copy)NSString<Optional> * img;

@end
