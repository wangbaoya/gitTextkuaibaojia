//
//  AppDelegate.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/4.
//  Copyright © 2017年 apple. All rights reserved.

#import "AppDelegate.h"
#import "BaiduMobStat.h"
#import "MyTabbarviewconstrerViewController.h"
#import "iflyMSC/IFlyMSC.h"
#import "IQKeyboardManager.h"

#import "Order.h"
#import "APAuthV2Info.h"
#import "Util/DataSigner.h"
#import "AlipaySDK.framework/Headers/AlipaySDK.h"
#import <JPUSHService.h>
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

#import "MotaiViewController.h"
@interface AppDelegate ()<JPUSHRegisterDelegate>

@property(nonatomic,strong)BMKMapManager * mapManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    /* 打开日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    // 打开图片水印
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    [UMSocialGlobal shareInstance].isClearCacheWhenGetUserInfo = NO;
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:USHARE_DEMO_APPKEY];
    
    
    MyTabbarviewconstrerViewController*view=[[MyTabbarviewconstrerViewController alloc] init];
    
    view.dijici = 888;
    self.window.rootViewController=view;
    
    _mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [_mapManager start:@"CSZv39bjvYYwu3D2mO5xKwxc4fwDA01I" generalDelegate:self];
    if (!ret)
    {
        NSLog(@"manager start failed!");
    } else {
        NSLog(@"鉴权成功！");
    }
    
    [self shareUmeng];
    
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",APPID_VALUE];
    [IFlySpeechUtility createUtility:initString];
    
    [[BaiduMobStat defaultStat] startWithAppId:@"34ae007e1c"];
    [self jianpan];
    
    [self textInternet];
    [self tuisong];
    
    [JPUSHService setupWithOption:launchOptions appKey:@"2a88b7799c25a2a42265ee6d" channel:@"App Store" apsForProduction:YES];

    [self.window makeKeyAndVisible];
    
    return YES;
}


-(void)tuisong
{
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    
//    if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0)
//    {
//        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
//                                                          UIUserNotificationTypeSound |
//                                                          UIUserNotificationTypeAlert) categories:nil];
//    }
//
      [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
    {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
    
//    aps =     {
//        alert = 66666;
//        badge = 1;
    //        sound = default;body = "https://www.baidu.com";
//    subtitle = 66666;
//    };

//    NSString * str = userInfo[@"aps"][@"alert"];
//    
////    NSLog(@"===%@",[str hasPrefix:@"https:"]);
//
//    if ([str hasPrefix:@"http"]||[str hasPrefix:@"www"])
//    {
//        NSLog(@"===%@",str);
//  
//        MotaiViewController *ctl = [[MotaiViewController alloc] init];
//        
//        MyTabbarviewconstrerViewController *tabBar = (MyTabbarviewconstrerViewController *)self.window.rootViewController;//获取window的跟视图,并进行强制转换
//        ctl.url = str;
//        if ([tabBar isKindOfClass:[UITabBarController class]]) {//判断是否是当前根视图
//            
//            UINavigationController *nav = tabBar.selectedViewController;//获取到当前视图的导航视图
//            
//            [nav.topViewController.navigationController pushViewController:ctl animated:YES];//获取当前跟视图push到的最高视图层,然后进行push到目的页面
//            
//        }
//        
//        
//    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
    
    NSLog(@"===%@",userInfo);
    
    application.applicationIconBadgeNumber = 0;
    
    
    
}

-(void)applicationDidBecomeActive:(UIApplication *)application
{
    [JPUSHService resetBadge];
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];

    
}

-(void)jianpan
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    
    manager.enable = YES;
    
    manager.shouldResignOnTouchOutside = YES;//这个是点击空白区域键盘收缩的开关
    manager.enableAutoToolbar = NO;//这个是它自带键盘工具条开关
    
}

-(void)shareUmeng
{
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxff52ab613da7ab0c" appSecret:@"fcf5880a37638b5cf21f344d92220042" redirectURL:@"http://mobile.umeng.com/social"];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105469472"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://www.umeng.com/social"];
    
    //    //设置友盟社会化组件appkey
    //    [UMSocialData setAppKey:@"576bac6d67e58e0b6b000a36"];
    //    //设置微信AppId、appSecret，分享url
    //    [UMSocialWechatHandler setWXAppId:@"wxff52ab613da7ab0c" appSecret:@"fcf5880a37638b5cf21f344d92220042" url:@"http://www.umeng.com/social"];
    //    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    //    [UMSocialQQHandler setQQWithAppId:@"1105469472" appKey:@"t7lum7Vsb1K9bOvq" url:@"http://www.umeng.com/social"];//
    
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    //    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
    //                                              secret:@"04b48b094faeb16683c32669824ebdad"
    //                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    //
    
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result)
    {
        // 其他如支付等SDK的回调
        if ([url.host isEqualToString:@"safepay"])
        {
            // 支付跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic)
             {
                 NSLog(@"result = %@",resultDic);
                 
             }];
            
            // 授权跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic)
             {
                 NSLog(@"result = %@",resultDic);
                 // 解析 auth code
                 NSString *result = resultDic[@"result"];
                 NSString *authCode = nil;
                 if (result.length>0)
                 {
                     NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                     for (NSString *subResult in resultArr)
                     {
                         if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="])
                         {
                             authCode = [subResult substringFromIndex:10];
                             break;
                         }
                     }
                 }
             }];
        }
    }
    return result;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    
    if (!result)
    {
        if ([url.host isEqualToString:@"safepay"])
        {
            // 支付跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic)
             {
                 NSString * wwww=resultDic[@"resultStatus"];
                 if ([wwww isEqualToString:@"9000"])
                 {
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"tiaozhuan" object:nil];
                 }
             }];
            // 授权跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic)
             {
                 NSLog(@"456result = %@",resultDic);
                 // 解析 auth code
                 NSString *result = resultDic[@"result"];
                 NSString *authCode = nil;
                 if (result.length>0) {
                     NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                     for (NSString *subResult in resultArr) {
                         if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                             authCode = [subResult substringFromIndex:10];
                             break;
                         }
                     }
                 }
                 
             }];
        }
    }
    
    return result;
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)textInternet
{
    //开启网络状况监听
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         switch (status)
         {
             case AFNetworkReachabilityStatusUnknown:
                 NSLog(@"未识别的网络");
                 
                 [WBYRequest showMessage:@"未识别的网络"];
                 break;
                 
             case AFNetworkReachabilityStatusNotReachable:
                 NSLog(@"不可达的网络(未连接)");
                 [WBYRequest showMessage:@"未识别的网络"];
                 
                 break;
                 
             case AFNetworkReachabilityStatusReachableViaWWAN:
                 //                 [self wbyUpTextApp];
                 
                 NSLog(@"2G,3G,4G...的网络");
                 break;
             case AFNetworkReachabilityStatusReachableViaWiFi:
                 NSLog(@"wifi的网络");
                 
                 break;
             default:
                 break;
         }
     }];
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.window endEditing:YES];
}


@end
