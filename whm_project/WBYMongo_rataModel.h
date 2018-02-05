//
//  WBYMongo_rataModel.h
//  whm_project
//
//  Created by apple on 17/2/6.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "WBYRataModel.h"
#import "WBYaaColumnsModel.h"
#import "WBYAAvalsModel.h"

@protocol WBYMongo_rataModel <NSObject>
@end
@interface WBYMongo_rataModel : JSONModel
@property(nonatomic,copy)NSString * pid;

@property(nonatomic,copy)NSString * bee_type;
@property(nonatomic,copy)NSString * insured;
@property(nonatomic,strong)NSArray <WBYRataModel >*rate;
@property(nonatomic,strong)NSArray <WBYaaColumnsModel>*columns;
@property(nonatomic,strong)NSArray *vals;


@end
