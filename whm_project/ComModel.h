//
//  ComModel.h
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol ComModel <NSObject>



@end
@interface ComModel : JSONModel
@property(nonatomic,copy)NSString<Optional> *cname;
@property(nonatomic,copy)NSString<Optional> *cid;
@property(nonatomic,copy)NSString<Optional> *logo;



@end
