//
//  WBYInsured.h
//  whm_project
//
//  Created by apple on 17/3/7.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol WBYInsured <NSObject>
@end
@interface WBYInsured : JSONModel
@property(nonatomic,copy)NSString  * calculation;
@property(nonatomic,copy)NSString  * content;
@property(nonatomic,copy)NSString  * iid;
@property(nonatomic,copy)NSString  * most;
@property(nonatomic,copy)NSString  * name;
@property(nonatomic,copy)NSString  * no_calculation;
@property(nonatomic,copy)NSString  * premise;
@property(nonatomic,copy)NSString  * show;

@end
