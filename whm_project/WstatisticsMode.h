//
//  WstatisticsMode.h
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol WstatisticsMode <NSObject>


@end
@interface WstatisticsMode : JSONModel
@property(nonatomic,copy)NSString<Optional>*pro_count;
@property(nonatomic,copy)NSString<Optional>*message_count;



@end
