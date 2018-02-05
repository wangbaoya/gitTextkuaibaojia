//
//  Photo.h
//  KuiBuText
//
//  Created by Stephy_xue on 16/3/7.
//  Copyright © 2016年 Baoya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//使用block 返回值
typedef void (^sendPictureBlock)(UIImage *image,BOOL isOk,NSData* data);

@interface Photo : NSObject<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,copy)sendPictureBlock sPictureBlock;


+ (Photo *)sharedModel;

+(void)sharePicture:(sendPictureBlock)block;



@end
