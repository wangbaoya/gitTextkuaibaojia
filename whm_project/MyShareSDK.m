//
//  MyShareSDK.m
//  zheShiGeHaoRuanJian
//
//  Created by Stephy_xue on 16/11/1.
//  Copyright © 2016年 henankuibu. All rights reserved.
//

#import "MyShareSDK.h"

@implementation MyShareSDK


+(void)shareLogo:(NSString*)logo baseaUrl:(NSString *)url xianzhongID:(NSString*)xianid touBiaoti:(NSString*)shareText
{
 
    
        [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_WechatSession)]];
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo)
         {
             // 根据获取的platformType确定所选平台进行下一步操作
             
             [MyShareSDK ShareType:platformType shareLogo:logo baseaUrl:url xianzhongID:xianid touBiaoti:shareText];
             
         }];
 
  
}

+(void)PTFshareLogo:(NSString*)logo baseaUrl:(NSString *)url xianzhongID:(NSString*)xianid touBiaoti:(NSString*)shareText
{
   
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_WechatSession)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo)
     {
         // 根据获取的platformType确定所选平台进行下一步操作
         
         UMSocialMessageObject * messageObject = [UMSocialMessageObject messageObject];
         UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:shareText descr:@"问保险,买保险,聊保险,点击进入无所不能的快保家理财中心" thumImage:logo];
         
         shareObject.webpageUrl =url;
         
         messageObject.shareObject = shareObject;
         
         [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:AppRootViewController completion:^(id data, NSError *error)
          {
              
              
        }];
     }];
 }



+(void)ShareType:(UMSocialPlatformType)platformType shareLogo:(NSString*)logo baseaUrl:(NSString *)url xianzhongID:(NSString *)xianid touBiaoti:(NSString*)shareText
{
    //创建分享消息对象
    UMSocialMessageObject * messageObject = [UMSocialMessageObject messageObject];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:shareText descr:@"问保险,买保险,聊保险,点击进入无所不能的快保家理财中心" thumImage:logo];
    
    shareObject.webpageUrl =[NSString stringWithFormat:@"%@/%@",url, xianid];
    
    messageObject.shareObject = shareObject;
    
    
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:AppRootViewController completion:^(id data, NSError *error)
     {
//         if (error)
//         {
//             UMSocialLogInfo(@"************Share fail with error %@*********",error);
//         }else{
//             if ([data isKindOfClass:[UMSocialShareResponse class]]) {
//                 UMSocialShareResponse *resp = data;
//                 //分享结果消息
//                 UMSocialLogInfo(@"response message is %@",resp.message);
//                 //第三方原始返回的数据
//                 UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
//                 
//             }else{
//                 UMSocialLogInfo(@"response data is %@",data);
//             }
//         }
         //        [self alertWithError:error];
     }];
    
}




@end
