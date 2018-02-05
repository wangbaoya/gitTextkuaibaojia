//
//  Agent_infoModel.h
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol Agent_infoModel <NSObject>



@end
@interface Agent_infoModel : JSONModel
@property(nonatomic,copy)NSString<Optional>*name;
@property(nonatomic,copy)NSString<Optional>*birthday;
@property(nonatomic,copy)NSString<Optional>*point;
@property(nonatomic,copy)NSString<Optional>*sex;
@property(nonatomic,copy)NSString<Optional>*addr;
@property(nonatomic,copy)NSString<Optional>*service_area;
@property(nonatomic,copy)NSString<Optional>*service_scope;
@property(nonatomic,copy)NSString<Optional>*profession;
@property(nonatomic,copy)NSString<Optional>*cname;
@property(nonatomic,copy)NSString<Optional>*oname;
@property(nonatomic,copy)NSString<Optional>*cityn;
//avatar mobile intro
@property(nonatomic,copy)NSString<Optional>*avatar;
@property(nonatomic,copy)NSString<Optional>*mobile;
@property(nonatomic,copy)NSString<Optional>*uid;
@property(nonatomic,copy)NSString<Optional>*introduce;



@end
