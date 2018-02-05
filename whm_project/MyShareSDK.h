//
//  MyShareSDK.h
//  zheShiGeHaoRuanJian
//
//  Created by Stephy_xue on 16/11/1.
//  Copyright © 2016年 henankuibu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>


@interface MyShareSDK : NSObject
+(void)shareLogo:(NSString*)logo baseaUrl:(NSString *)url xianzhongID:(NSString*)xianid touBiaoti:(NSString*)shareText;
+(void)PTFshareLogo:(NSString*)logo baseaUrl:(NSString *)url xianzhongID:(NSString*)xianid touBiaoti:(NSString*)shareText;

@end
