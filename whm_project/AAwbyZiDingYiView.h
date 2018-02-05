//
//  AAwbyZiDingYiView.h
//  whm_project
//
//  Created by apple on 17/4/27.
//  Copyright © 2017年 chenJw. All rights reserved.
//


#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

@interface AAwbyZiDingYiView : BMKAnnotationView
@property(nonatomic,copy)UILabel           *titleLable;
@property(nonatomic,strong)UIView           *contentView;
@property(nonatomic,copy)NSString           *mytittle;
@property(nonatomic,copy)NSString           *titleText;

@end
