//
//  WBYparamsModel.h
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol WBYparamsModel <NSObject>



@end

@interface WBYparamsModel : JSONModel
@property(nonatomic,strong)NSString <Optional> * en;
@property(nonatomic,strong)NSString <Optional> * name;
@property(nonatomic,strong)NSString <Optional> * val;


@end
