//
//  WBYtotalRataModel.h
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol WBYtotalRataModel <NSObject>


@end

@interface WBYtotalRataModel : JSONModel
@property(nonatomic,strong)NSString <Optional> * name;
@property(nonatomic,strong)NSString <Optional> * score;
@property(nonatomic,strong)NSString <Optional> * level;
@property(nonatomic,strong)NSString <Optional> * des;
@property(nonatomic,strong)NSString <Optional> * total;

@end
