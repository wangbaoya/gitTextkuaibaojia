//
//  ScoreModel.h
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol ScoreModel <NSObject>

@end
@interface ScoreModel : JSONModel
@property(nonatomic,copy)NSString<Optional> *score;
@property(nonatomic,copy)NSString<Optional> *level;
@property(nonatomic,copy)NSString<Optional> *rate;


@end
