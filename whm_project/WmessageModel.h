//
//  WmessageModel.h
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol WmessageModel <NSObject>

@end
@interface WmessageModel : JSONModel
@property(nonatomic,copy)NSString<Optional>*status;
@property(nonatomic,copy)NSString<Optional>*read;
@property(nonatomic,copy)NSString<Optional>*reply_status;
@property(nonatomic,copy)NSString<Optional>*create_time;
@property(nonatomic,copy)NSString<Optional>*ip;
@property(nonatomic,copy)NSString<Optional>*city_name;
@property(nonatomic,copy)NSString<Optional>*req_name;

@property(nonatomic,copy)NSString<Optional>*message;
@property(nonatomic,copy)NSString<Optional>*cname;
@property(nonatomic,copy)NSString<Optional>*oname;
@property(nonatomic,copy)NSString<Optional>*cityn;



@end
