//
//  MyTabbarviewconstrerViewController.m
//  iconfont的使用
//
//  Created by apple on 17/5/11.
//  Copyright © 2017年 WOSHIPM. All rights reserved.
//

#import "MyTabbarviewconstrerViewController.h"
#import "WangNavViewController.h"
#import "GXCustomButton.h"
#import "UIImage+TBCityIconFont.h"
#import "FaxianViewController.h"
#import "ShangchengViewController.h"
#import "WodeViewController.h"
#import "TijianViewController.h"
#import "ShouYeViewController.h"

#import "YshangchengViewController.h"

@interface MyTabbarviewconstrerViewController ()<BMKLocationServiceDelegate>
{
    UIImageView *_tabBarView; //自定义的覆盖原先的tarbar的控件
    GXCustomButton *_previousBtn; //记录前一次选中的按钮
    BMKLocationService * localService;

}
@end

@implementation MyTabbarviewconstrerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = wWhiteColor;
    // Do any additional setup after loading the view.
//    self.tabBar.hidden = YES; //隐藏原先的tabBar
    [self creattabbars];
    
    localService = [[BMKLocationService alloc] init];
    localService.delegate = self;
    [localService startUserLocationService];
    localService.distanceFilter = 1000;
    localService.desiredAccuracy = 200;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
//    if (_dijici==666)
//    {
//        self.selectedIndex = 2;
//        
//    }
//  
//    if(_dijici==888)
//    {
//        self.selectedIndex = 0;
//    }
    
    
    

}

-(void)creattabbars
{
    
    ShouYeViewController * zhaoview = [ShouYeViewController new];
    FaxianViewController * faxian = [FaxianViewController new];
    WodeViewController * wode = [WodeViewController new];
    TijianViewController * tijian = [TijianViewController new];
    
//    YshangchengViewController * shangcheng = [YshangchengViewController new];
    
     ShangchengViewController * shangcheng = [ShangchengViewController new];
    
    WangNavViewController * nav = [[WangNavViewController alloc] initWithRootViewController:zhaoview];
    
    WangNavViewController * nav1 = [[WangNavViewController alloc] initWithRootViewController:tijian];
    WangNavViewController * nav2 = [[WangNavViewController alloc] initWithRootViewController:shangcheng];
    
    WangNavViewController * nav3 = [[WangNavViewController alloc] initWithRootViewController:faxian];
    WangNavViewController * nav4 = [[WangNavViewController alloc] initWithRootViewController:wode];
    
    self.viewControllers = @[nav,nav1,nav2,nav3,nav4];    
    
    NSInteger daxiao = 30;
    
    nav.tabBarItem.image = [[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e609",daxiao,QIANLANSEcolor)] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    nav.tabBarItem.selectedImage = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e602",daxiao,SHENLANSEcolor)];

    nav1.tabBarItem.image = [[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e607",daxiao,QIANLANSEcolor)] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    nav1.tabBarItem.selectedImage = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e601",daxiao,SHENLANSEcolor)];
    
    nav2.tabBarItem.image = [[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e606",daxiao,QIANLANSEcolor)] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    nav2.tabBarItem.selectedImage = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e604",daxiao,SHENLANSEcolor)];

    
    nav3.tabBarItem.image = [[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e608",daxiao,QIANLANSEcolor)] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    nav3.tabBarItem.selectedImage = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e603",daxiao,SHENLANSEcolor)];
 
    nav4.tabBarItem.image = [[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e60a",daxiao,QIANLANSEcolor)] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    nav4.tabBarItem.selectedImage = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e60d",daxiao,SHENLANSEcolor)];
    
        nav.title=@"首页";
        nav1.title=@"体检";
        nav2.title=@"商城";
        nav3.title=@"发现";
        nav4.title=@"我的";
    
      [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:SHENLANSEcolor,NSFontAttributeName:Font(12)} forState:UIControlStateSelected];
    
    
     [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:QIANLANSEcolor,NSFontAttributeName:Font(12)} forState:UIControlStateNormal];
    
//     [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:unselectColor,NSFontAttributeName:[UIFont fontWithName:foneName size:size]} forState:UIControlStateNormal];
//    
    
    
 }

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    34.797974 ======34.798085=====113.670845
    NSLog(@"======%f=====%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    CLGeocoder * geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation: userLocation.location completionHandler:^(NSArray *array, NSError *error) {
        
        if (array.count > 0)
        {
            CLPlacemark *placemark = [array objectAtIndex:0];
            if (placemark != nil)
            {
                
                //城市
                NSString *city = placemark.locality;
                
                //区
                NSString *qu = placemark.subLocality;

                
                [ud setValue:[NSString stringWithFormat:@"%@",city.length > 1 ? city:@"省/市/区"] forKey:@"zhediqu"];
                
                [ud setValue:[NSString stringWithFormat:@"%@",qu.length > 1 ? qu:@"省/市/区"] forKey:@"zhegequ"];
                
                //                placemark.locality
                NSLog(@"当前城市名称------%@",city);
                
                //                BMKOfflineMap * _offlineMap = [[BMKOfflineMap alloc] init];
                
                //                _offlineMap.delegate = self;//可以不要
                
                //                NSArray* records = [_offlineMap searchCity:city];
                //
                //                BMKOLSearchRecord* oneRecord = [records objectAtIndex:0];
                //
                //                //城市编码如:北京为131
                //
                //                NSInteger cityId = oneRecord.cityID;
                //
                //
                //                NSLog(@"当前城市编号-------->%zd",cityId);
                
                //找到了当前位置城市后就关闭服务
                
                //                [_locService stopUserLocationService];
                
            }
            
        }
        
    }];
    
    [ud setValue:[NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude > 1 ? userLocation.location.coordinate.longitude:113.670845] forKey:@"one"];
    [ud setValue:[NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude > 1 ? userLocation.location.coordinate.latitude:34.798085] forKey:@"two"];
    
    NSString * str = TYPE;
    if ([str isEqualToString:@"1"])
    {
        [self shangchuanjingweidu:userLocation];
    }
    
    [ud synchronize];
    
    [localService stopUserLocationService];
}

-(void)shangchuanjingweidu:(BMKUserLocation*)userLocation
{
    
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
//    [dic setObject:UID forKey:@"uid"];
    [dic setObject:[NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude > 1 ? userLocation.location.coordinate.longitude:113.670845]forKey:@"lng"];
    
    [dic setObject:[NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude > 1 ? userLocation.location.coordinate.latitude:34.798085] forKey:@"lat"];
    
    if (UID&&KEY)
    {
        [WBYRequest wbyLoginPostRequestDataUrl:@"set_loc" addParameters:dic success:^(WBYReqModel *model)
         {
             //        if ([model.err isEqualToString:TURE])
             //        {
             //        }else
             //        {
             //            [WBYRequest showMessage:model.info];
             //        }
             
         } failure:^(NSError *error) {
             
         }];
        
    }
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
