//
//  Photo.m
//  KuiBuText
//
//  Created by Stephy_xue on 16/3/7.
//  Copyright © 2016年 Baoya. All rights reserved.
//

#import "Photo.h"

@implementation Photo
{
    NSInteger sourceType;
}

+(Photo*)sharedModel
{
    static Photo*sharedModel=nil;
    static dispatch_once_t oneToken;
       dispatch_once(&oneToken, ^{
        
       sharedModel = [[Photo alloc] init];
        
        
    });
    return sharedModel;
    
}


+(void)sharePicture:(sendPictureBlock)block
{
    Photo *tp=[Photo sharedModel];
    
    tp.sPictureBlock=block;
    UIActionSheet*sheet;
    //    判断是否支持相机
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet=[[UIActionSheet alloc] initWithTitle:@"设置头像" delegate:tp cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册中获取", nil];
        
    }else
    {
        sheet = [[UIActionSheet alloc] initWithTitle:@"设置头像" delegate:tp cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"相册中获取", nil];
        
        
    }
    sheet.tag = 255;
    
    [sheet showInView:AppRootView];
    
}
#pragma mark - action sheet delegte

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255)
    {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            switch (buttonIndex)
            {
                case 0:
                    return;
                case 1: //相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 2: //相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0)
            {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        
        // 跳转到相机或相册页面
        UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [AppRootViewController presentViewController:imagePickerController animated:YES completion:NULL];
    }
}

#pragma mark - image picker delegte

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    BOOL isOk=YES;
    
    Photo *TPhoto = [Photo sharedModel];
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    NSData*data=UIImageJPEGRepresentation(image, 0.5);
    
    [TPhoto sPictureBlock](image,isOk,data);

    
}
@end
