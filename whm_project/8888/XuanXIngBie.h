//
//  XuanXIngBie.h
//  搜索框
//
//  Created by apple on 17/6/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XuanXIngBie : UIView
typedef void (^SelectIndex)(NSInteger selectIndex);//编码
typedef void (^SelectValue)(NSString *selectValue);//数值

@property (nonatomic, strong) NSArray * titles;//string数组

@property (nonatomic, copy) SelectIndex selectIndex;
@property (nonatomic, copy) SelectValue selectValue;

@property (nonatomic, strong) UITableView *selectTableView;//选择列表
+ (XuanXIngBie *)showWithTitle:(NSString *)title
                        titles:(NSArray *)titles
                   selectIndex:(SelectIndex)selectIndex
                   selectValue:(SelectValue)selectValue
               showCloseButton:(BOOL)showCloseButton;

@end
