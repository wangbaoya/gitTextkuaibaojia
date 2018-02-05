//
//  Wpro_groupModel.h
//  whm_project
//
//  Created by apple on 17/7/20.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol Wpro_groupModel <NSObject>


@end
@interface Wpro_groupModel : JSONModel
//pdf_path
@property(nonatomic,strong)NSString <Optional> * name;
@property(nonatomic,strong)NSString <Optional> * clause;
@property(nonatomic,strong)NSString <Optional> * rights;
@property(nonatomic,strong)NSString <Optional> * rule;
@property(nonatomic,strong)NSString <Optional >* cases;
@property(nonatomic,strong)NSString <Optional> * pdf_path;
@property(nonatomic,strong)NSString <Optional> * id;


@end
