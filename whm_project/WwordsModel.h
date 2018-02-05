//
//  WwordsModel.h
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol WwordsModel <NSObject>
@end
@interface WwordsModel : JSONModel

@property(nonatomic,copy)NSString<Optional> * name;
@property(nonatomic,copy)NSString<Optional> * mongo_id;
@end
