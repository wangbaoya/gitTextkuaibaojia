//
//  WwwGroupsModel.h
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol WwwGroupsModel <NSObject>


@end
@interface WwwGroupsModel : JSONModel

@property(nonatomic,strong)NSString <Optional> * id;
@property(nonatomic,strong)NSString <Optional> * is_main;
@property(nonatomic,strong)NSString <Optional> * name;
@property(nonatomic,strong)NSString <Optional> * short_name;
@property(nonatomic,strong)NSArray <WBYInsured >* interets;
//@property(nonatomic,strong)NSArray <WBYMongo_rataModel >* rate;



@end
