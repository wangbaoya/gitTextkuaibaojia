//
//  WBYaaColumnsModel.h
//  whm_project
//
//  Created by apple on 17/4/5.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol WBYaaColumnsModel <NSObject>
@end
@interface WBYaaColumnsModel : JSONModel
@property(nonatomic,strong)NSString <Optional> * en;
@property(nonatomic,strong)NSString <Optional> * name;
@property(nonatomic,strong)NSArray <Optional> * vals;


@end
