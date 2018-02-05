//
//  AAinterestsModel.h
//  whm_project
//
//  Created by apple on 17/4/14.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol AAinterestsModel <NSObject>

@end
@interface AAinterestsModel : JSONModel
@property(nonatomic,strong)NSString <Optional> * id;
@property(nonatomic,strong)NSString <Optional> * show;

@end
