//
//  Header.h
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#ifndef Header_h
#define Header_h
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define NSLog(...)
#define debugMethod()
#endif


#import "TijianXinXiModel.h"

#import "XuanXIngBie.h"
#import "WBYRequest.h"
#import "MyDdddd.h"
#import "UIButton+WebCache.h"
#import <UIImageView+WebCache.h>
#import "UIView+ZYDraggable.h"
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import <Masonry.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "TBCityIconFont.h"
#import "TBCityIconInfo.h"
#import "iflyMSC/iflyMSC.h"
#import "IATConfig.h"
#import "UISearchBar+JCSearchBarPlaceholder.h"
#import "MJRefresh.h"
#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"
#import "AipGeneralVC.h"
#import "AipCaptureCardVC.h"
#import "AipOcrService.h"
#import "AipOcrDelegate.h"

#import "MyShareSDK.h"
#import "CMIndexBar.h"

#import "NSString+PinYin.h"

#define ScrenScale [UIScreen mainScreen].bounds.size.width/320.0

#define TURE  @"0"

#define AppRootViewController  ([[[[UIApplication sharedApplication] delegate] window] rootViewController])
#define AppRootView  ([[[[[UIApplication sharedApplication] delegate] window] rootViewController] view])

#define STOREAPPID @"1133378369"

#define WUSHUJU @"1400"
#define ZT16  [UIScreen mainScreen].bounds.size.width > 350 ? [UIFont systemFontOfSize:16.0]:[UIFont systemFontOfSize:14.0];
#define ZT14  [UIScreen mainScreen].bounds.size.width > 350 ? [UIFont systemFontOfSize:14.0]:[UIFont systemFontOfSize:12.0];
#define ZT13  [UIScreen mainScreen].bounds.size.width > 350 ? [UIFont systemFontOfSize:13.0]:[UIFont systemFontOfSize:11.0];
#define ZT12  [UIScreen mainScreen].bounds.size.width > 350 ? [UIFont systemFontOfSize:12.0]:[UIFont systemFontOfSize:10.0];

#define Font(a) [UIFont systemFontOfSize:a]

#define SHU (wScreenW/320-1)*10
#define newFont(a) [UIFont systemFontOfSize:a*(wScreenW/320)*0.9]

#define biaoTiFont [UIFont systemFontOfSize:18+SHU]
#define daFont [UIFont systemFontOfSize:16+SHU]
#define zhongFont [UIFont systemFontOfSize:14.0+SHU]
#define xiaoFont [UIFont systemFontOfSize:11.0+SHU]


#define DAZITI  Font(20)
#define ZHONGZITI  Font(16)
#define XIAOZITI  Font(12)
#define BASEURL    @"https://www.kuaibao365.com/api/k/"
//ABASEURL
#define ABASEURL    @"https://www.kuaibao365.com/api/kj/"


#define SAME  @"1304"

#define HANGGAO  60.0

#define XIANZHONGXIANGQING_URL @"https://www.kuaibao365.com/product/details"
#define GONGSIBASEURL    @"https://www.kuaibao365.com/company/info"

#define ZIXUNBASEURL    @"https://www.kuaibao365.com/news/details"
#define WEIZHANBASEURL @"https://www.kuaibao365.com/micro"

#define wScreenW   [UIScreen mainScreen].bounds.size.width
#define wScreenH   [UIScreen mainScreen].bounds.size.height
#define WS(weakSelf)     __weak __typeof(&*self)weakSelf = self

#define UIColorFromHex(s)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]

#define TBCityIconInfoMake(text, imageSize, imageColor) [TBCityIconInfo iconInfoWithText:text size:imageSize color:imageColor]

#define SHENLANSEcolor UIColorFromHex(0x3498DB)
#define QIANLANSEcolor UIColorFromHex(0x78c0F1)
#define JIANGEcolor UIColorFromHex(0xeff3f5)

//#define QIANZITIcolor UIColorFromHex(0xBEBEBE)
//#define QIANZITIcolor UIColorFromHex(0x666666)
#define QIANZITIcolor UIColorFromHex(0x909090)
#define SHENZITIcolor UIColorFromHex(0x909090)

#define TIDAIZITIcolor UIColorFromHex(0xC4C4C4)

#define FENGEXIANcolor UIColorFromHex(0xF4F4F4)

#define HUITUColor UIColorFromHex(0xA4A4A4)

#define DianhuaColor UIColorFromHex(0x3498DB)

#define wRedColor  [UIColor redColor]

#define ZuoHeXianColour  [UIColor colorWithRed:255/255.0 green:207/255.0 blue:17/255.0 alpha:1.0]

#define Wqingse  [UIColor colorWithRed:40/255.0 green:214/255.0 blue:142/255.0 alpha:1.0]

#define wWhiteColor [UIColor whiteColor]
//#define wBlackColor UIColorFromHex(0x666666)

#define wBlackColor [UIColor blackColor]


#define RGBwithColor(a,b,c) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1.0]

//#define wLvColour [UIColor colorWithRed:42 / 255.0 green:209 / 255.0 blue:123.0 / 255.0 alpha:1.0]
#define wBaseColor [UIColor colorWithRed:246 / 255.0 green:247 / 255.0 blue:249 / 255.0 alpha:1.0]
#define wBlue  [UIColor colorWithRed:68.0/255 green:103.0/255 blue:255.0/225 alpha:1]
//#define wOrangeColor [UIColor colorWithRed:230.0/255 green:100.0/255 blue:8.0/255 alpha:1]
#define ZTCOlor UIColorFromHex(0x909090)

#define wGrayColor UIColorFromHex(0x909090)

//#define wGrayColor1 [UIColor colorWithRed:221.0/255 green:220.0/255 blue:223.0/255 alpha:1.0]
#define wGrayColor2 UIColorFromHex(0x909090)


//#define JinSe [UIColor colorWithRed:255/255.f green:199/255.f blue:117/255.f alpha:1]
//#define XianColour [UIColor colorWithRed:183 / 255.0 green:183 / 255.0 blue:183 / 255.0 alpha:1.0] zhegequ
#define CHENGSHI  [[NSUserDefaults standardUserDefaults] objectForKey:@"zhediqu"]

#define ZHEGEDIANHUA  [[NSUserDefaults standardUserDefaults] objectForKey:@"zhegedianhua"]

#define DIQU  [[NSUserDefaults standardUserDefaults] objectForKey:@"zhegequ"]

#define TOUXIANG  [[NSUserDefaults standardUserDefaults] objectForKey:@"touxiang"]

#define KEY  [[NSUserDefaults standardUserDefaults] objectForKey:@"key"]
#define UID  [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]
#define XINGMING  [[NSUserDefaults standardUserDefaults] objectForKey:@"xingming"]
#define TYPE  [[NSUserDefaults standardUserDefaults] objectForKey:@"type"]

#define LNGONE  [[NSUserDefaults standardUserDefaults] objectForKey:@"one"]

#define LATTWO  [[NSUserDefaults standardUserDefaults] objectForKey:@"two"]

#define RENZHENGZHUANGTAI  [[NSUserDefaults standardUserDefaults] objectForKey:@"renzhengzhuangtai"]
//tuijianrendianhua
#define RENZHENGMINGZI  [[NSUserDefaults standardUserDefaults] objectForKey:@"renzhengmingzi"]

#define TUiJIANRENDIANHUA  [[NSUserDefaults standardUserDefaults] objectForKey:@"tuijianrendianhua"]

#define TUiJIANRmingzi  [[NSUserDefaults standardUserDefaults] objectForKey:@"tuijianrenmingzi"]

#define APPID_VALUE           @"586dfe31"
#define USHARE_DEMO_APPKEY @"576bac6d67e58e0b6b000a36"

#endif /* Header_h */
