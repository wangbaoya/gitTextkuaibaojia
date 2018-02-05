//
//  WBYRequest.h
//  KuiBuText
//
//  Created by Stephy_xue on 16/3/4.
//  Copyright © 2016年 Baoya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "WBYReqModel.h"
#import "AFNetworkActivityIndicatorManager.h"
//#import "WBYtextModel.h"

typedef void(^getModelBlock)(WBYReqModel *model);
typedef void(^failDownloadBlcok)(NSError *error);

typedef void(^textgetModelBlock)(NSArray * amodel);
typedef void(^textfailDownloadBlcok)(NSError * aerror);


@interface WBYRequest : NSObject<UIAlertViewDelegate>

+(void)wbyTijianPostRequestDataUrl:(NSString *)url addParameters:(NSDictionary *)requestDict success:(textgetModelBlock)successBlock failure:(textfailDownloadBlcok)failureBlock;


+ (NSInteger)compareDate:(NSString*)date01 withDate:(NSString*)date02;

+ (void)showMessage:(NSString *)message;
+ (double)getCurrentIOS;
+(NSString *)getBundleShortVersion;

+(void)wbyPostRequestDataUrl:(NSString *)url addParameters:(NSDictionary *)requestDict success:(getModelBlock)successBlock failure:(failDownloadBlcok)failureBlock isRefresh:(BOOL)isRefresh;

+(void)wbyLoginPostRequestDataUrl:(NSString *)url addParameters:(NSDictionary *)requestDict success:(getModelBlock)successBlock failure:(failDownloadBlcok)failureBlock;


+(NSString *)jiami:(NSString *)canshu canshutwo:(NSString*)canshuer;
+(NSString * )timeStr:(NSString*)myTime;

+ (BOOL)isMobileNumber:(NSString *)mobileNum;

+ (BOOL)isEmailAddress:(NSString *)address;

+ (BOOL)isChePaiHao:(NSString *)address;

+(NSString*)creatFile:(NSString*)aName;

//通过string和字体大小求出text自适应需要的高度
+ (CGFloat)getAutoHeightForString:(NSString *)String
                        withWidth:(CGFloat)width
                     withFontSize:(CGFloat)fontSize;

+(CGFloat)getWeightForString:(NSString *)String
withHeight:(CGFloat)weight
                withFontSize:(CGFloat)fontSize;
+(NSString*)fileSizeOfLength:(long long)length;
+ (BOOL)isPersonIDCardNumber:(NSString *)value;

+ (long long)getZiFuChuan:(NSString*)time;
+ (long long)getCurrentDate;

+(NSArray *)paixuArr:(NSMutableArray *)arr;

+(NSMutableArray*)shanchuSame:(NSMutableArray *)dataArray;
+(NSMutableArray *)paixuJiaoFeiQiJianArr:(NSMutableArray *)arr;
//+(void)CeShiwbyPostRequestDataUrl:(NSString *)url addParameters:(NSDictionary *)requestDict success:(textgetModelBlock)successBlock failure:(textfailDownloadBlcok)failureBlock isRefresh:(BOOL)isRefresh;
+ (BOOL)isFloatPrice:(NSString *)priceStr;
+(NSInteger)getAge:(NSString *)str;
+ (BOOL)IsBankCard:(NSString *)cardNumber;

@end
