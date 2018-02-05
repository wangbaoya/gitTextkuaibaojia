//
//  BaseViewController.h
//  KuiBuText
//
//  Created by Baoya on 16/2/25.
//  Copyright © 2016年 Baoya. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "WBYRequest.h"
@interface BaseViewController : UIViewController<UIAlertViewDelegate>


@property (nonatomic, strong)  UIView * beijingDateView;


-(void)creatLeftTtem;


- (NSString*)dictionaryToJson:(NSDictionary *)dic;
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
-(void)callPhone:(NSString *)str;
-(void)wushuju;
-(void)wushujuSecond;

-(void)liaanniu;

-(void)qufengexian;
-(void)jiafengexian;

-(void)goLogin;
-(void)caiwucreatLeftTtem;
#pragma mark失去第一相应
-(void)shiqudiyixiangying;


@end
