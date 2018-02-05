//
//  WAgengModel.h
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/25.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol  WAgengModel <NSObject>
@end
//uid
@interface WAgengModel : JSONModel
@property(nonatomic,copy)NSString<Optional> * avatar;
@property(nonatomic,copy)NSString<Optional> * oname;
@property(nonatomic,copy)NSString<Optional> * name;
@property(nonatomic,copy)NSString<Optional> * birthday;
@property(nonatomic,copy)NSString<Optional> * sex;
@property(nonatomic,copy)NSString<Optional> * mobile;
@property(nonatomic,copy)NSString<Optional> * uid;

@end
