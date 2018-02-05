//
//  WBYNEWGSViewController.h
//  whm_project
//
//  Created by apple on 17/3/6.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "BaseViewController.h"

@interface WBYNEWGSViewController : BaseViewController

@property(nonatomic,strong)NSString * type;

@property(nonatomic,copy)void(^myZCid)(NSString * myId,NSString*myName);


@end
