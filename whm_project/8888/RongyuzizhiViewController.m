    //
    //  RongyuzizhiViewController.m
    //  com.fastprotecthome.iphoneformal
    //
    //  Created by apple on 17/6/14.
    //  Copyright © 2017年 apple. All rights reserved.
    //

    #import "RongyuzizhiViewController.h"
    #import "PicUpdateCollectionViewCell.h"
    #import "AddPicCollectionViewCell.h"
    @interface RongyuzizhiViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
    {
        NSMutableArray * allArr;
        NSArray * huquArr;
        NSString * aid;
        
        BOOL isOk;
        NSInteger sourceType;
        
        NSInteger dijigeshan;
    }
    @property (nonatomic,strong)UICollectionView *collectionView;
    @property (nonatomic,strong)NSURL * imageUrl;
    @property (nonatomic,strong)NSData *imageData ;
    @property (nonatomic,strong)UIImage *images;
    @end

    @implementation RongyuzizhiViewController

    - (void)viewDidLoad
    {
        [super viewDidLoad];
        // Do any additional setup after loading the view.
        self.navigationItem.title = @"荣誉资质";
        
        allArr = [NSMutableArray array];
        huquArr = [NSArray array];
        
        
        [self creatLeftTtem];
        [self huoqushuju];

        [self creatUi];
        
    }

    -(void)creatUi
    {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0 , wScreenW, wScreenH-64) collectionViewLayout:flowLayout];
        //定义每个UICollectionView 的大小
        flowLayout.itemSize = CGSizeMake((wScreenW - 60) / 3, (wScreenW - 60) / 3);
        //定义每个UICollectionView 纵向的间距
        flowLayout.minimumLineSpacing = 15;
        
        flowLayout.sectionInset = UIEdgeInsetsMake(15, 15 , 15, 15);//上左下右
        //注册cell和ReusableView（相当于头部）
        [_collectionView registerClass:[PicUpdateCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        [_collectionView registerClass:[AddPicCollectionViewCell class] forCellWithReuseIdentifier:@"addcell"];

        //设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        //背景颜色
        _collectionView.backgroundColor = [UIColor clearColor];
        
        [self.view addSubview:_collectionView];
        
    }

    #pragma mark 定义展示的UICollectionViewCell的个数
    -(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
    {
        return allArr.count + 1;
        
    }
    -(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
    {
        if (indexPath.row < allArr.count)
        {
            NSString *pic = allArr[indexPath.row];
            
            static NSString *identify = @"cell";
            PicUpdateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
            
            [cell sizeToFit];
            cell.picImage.tag = 999+indexPath.row;
            cell.picImage.userInteractionEnabled = YES;
            [cell.picImage sd_setImageWithURL:[NSURL URLWithString:pic] placeholderImage:[UIImage imageNamed:@""]];
            
            
            return cell;
        }
        else
        {
            static NSString *idCell = @"addcell";
            AddPicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:idCell forIndexPath:indexPath];
            [cell sizeToFit];
            
    //        [cell.addBtn setBackgroundImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e642", 30, wBlackColor)] forState:UIControlStateNormal];
            
            [cell.addBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e642", 30, wBlackColor)]  forState:UIControlStateNormal];
            cell.addBtn.backgroundColor = JIANGEcolor;
            [cell.addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }
    }

    -(void)addBtnAction
    {
        UIImageView * img = [_collectionView viewWithTag:999+dijigeshan];
        
        for (NSInteger i=0; i<20; i++)
        {
            UIButton * btn = [_collectionView viewWithTag:888+i];
   
            [btn removeFromSuperview];
            
        }
        
        
            for (NSInteger i=0; i<allArr.count; i++)
            {
                
                UIButton * btn = [_collectionView viewWithTag:888+i];
                [btn removeFromSuperview];
                
            }
        
            [img.layer removeAnimationForKey:@"shake"];

        
        [self changeTouXiang];
        
    }

    - (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
    {
        if (huquArr.count>=1)
        {
            
            UIImageView * img = [_collectionView viewWithTag:999+indexPath.item];
            
               double angle1 = -5.0 / 180.0 * M_PI;
                double angle2 = 5.0 / 180.0 * M_PI;
               CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
                anim.keyPath = @"transform.rotation";
           
                 anim.values = @[@(angle1), @(angle2),@(angle1)];
                 anim.duration = 0.25;
               // 动画的重复执行次数
                 anim.repeatCount = MAXFLOAT;
          
                 // 保持动画执行完毕后的状态
               anim.removedOnCompletion = NO;
                anim.fillMode = kCAFillModeForwards;
            
            [img.layer addAnimation:anim forKey:@"shake"];
            
            UIButton * shanchubtn = [UIButton buttonWithType:UIButtonTypeCustom];
            shanchubtn.frame = CGRectMake((wScreenW - 60) / 3-35, 0, 35, 35);
            shanchubtn.tag = 888+indexPath.item;
    //        [shanchubtn setBackgroundImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e610",35, wRedColor)] forState:UIControlStateNormal];
            
            [shanchubtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e610",25, wRedColor)] forState:UIControlStateNormal];
            
    //        [shanchubtn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
            
            
            [shanchubtn addTarget:self action:@selector(shanchu:) forControlEvents:UIControlEventTouchUpInside];
            
            [img addSubview:shanchubtn];
            
        }
        
    }

    -(void)shanchu:(UIButton*)btn
    {
        DataModel * model = huquArr[btn.tag-888];
        
        dijigeshan = btn.tag-888;
        
        aid = model.id?model.id:@"";
        
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你确定要删除该图片吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alert show];
        
    }


    -(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
    {
        
        UIImageView * img = [_collectionView viewWithTag:999+dijigeshan];
        
        
        if (buttonIndex == 1)
        {
           
            for (NSInteger i=0; i<allArr.count; i++)
            {
                
            UIButton * btn = [_collectionView viewWithTag:888+i];
                
                [btn removeFromSuperview];
      
            }
            
            
            
        [img.layer removeAnimationForKey:@"shake"];
            
            [self shanchutupian:aid?aid:@""];
        }
        
    }




    -(void)huoqushuju
    {
        WS(weakSelf);
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        [WBYRequest wbyLoginPostRequestDataUrl:@"get_honor" addParameters:dic success:^(WBYReqModel *model)
        {
            
            if ([model.err isEqualToString:TURE]||[model.err isEqualToString:@"1400"])
            {
                huquArr = model.data;
              
                [allArr removeAllObjects];
                
                for (DataModel * mod in model.data)
                {
                    [allArr addObject:mod.img1];
                }
            }
        
            [weakSelf.collectionView reloadData];
            
        } failure:^(NSError *error) {
            
        }];
        
    }

    -(void)tianjiashuju:(NSString *)str
    {
        WS(weakSelf);
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        [dic setObject:UID forKey:@"uid"];
        [dic setObject:str?str:@"" forKey:@"img"];

        
        [WBYRequest wbyLoginPostRequestDataUrl:@"save_honor" addParameters:dic success:^(WBYReqModel *model)
         {
             if ([model.err isEqualToString:TURE])
             {
                 [WBYRequest showMessage:model.info];
                 [weakSelf huoqushuju];
             }
             
         } failure:^(NSError *error) {
             
         }];
    }

    -(void)shanchutupian:(NSString*)str
    {
        WS(weakSelf);
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        [dic setObject:str forKey:@"id"];
        
        [WBYRequest wbyLoginPostRequestDataUrl:@"del_honor" addParameters:dic success:^(WBYReqModel *model)
         {
             if ([model.err isEqualToString:TURE])
             {
                 [WBYRequest showMessage:model.info];
                 [weakSelf huoqushuju];
             }
             [_collectionView reloadData];
         } failure:^(NSError *error) {
             
         }];
        
    }

    -(void)changeTouXiang
    {
        UIActionSheet*sheet;
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            sheet=[[UIActionSheet alloc] initWithTitle:@"设置头像" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册中获取", nil];
        }else
        {
            sheet = [[UIActionSheet alloc] initWithTitle:@"设置头像" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"相册中获取", nil];
        }
        sheet.tag=2555;
        [sheet showInView:AppRootView];
    }

    #pragma mark - action sheet delegte

    -(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
    {
        if (actionSheet.tag==2555)
        {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                switch (buttonIndex)
                {
                    case 0:
                        return;
                        break;
                        
                    case 1:
                        sourceType=UIImagePickerControllerSourceTypeCamera;
                        break;
                        
                    case 2:
                        sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
                        break;
                }
            }else
            {
                if (buttonIndex==0)
                {
                    return;
                    
                }else
                {
                    sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                }
            }
            UIImagePickerController*imagePickView=[[UIImagePickerController alloc] init];
            imagePickView.delegate=self;
            imagePickView.allowsEditing=YES;
            imagePickView.sourceType = sourceType;
            [AppRootViewController presentViewController:imagePickView animated:YES completion:NULL];
        }
    }

    -(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
    {
    //    UIButton*abtn=[self.view viewWithTag:5858];
        
        isOk=YES;
        [self dismissViewControllerAnimated:YES completion:nil];
        _imageUrl=[info valueForKey:UIImagePickerControllerReferenceURL];
        if (picker.allowsEditing)
        {
            
            _images=[info objectForKey:UIImagePickerControllerEditedImage];
        }else
        {
            _images=[info objectForKey:UIImagePickerControllerOriginalImage];
        }
        UIImageWriteToSavedPhotosAlbum(_images, nil, nil, nil);
        UIImage * image=[info objectForKey:UIImagePickerControllerEditedImage];
        
        
    //    [abtn setImage:_images forState:UIControlStateNormal];
        
        _imageData=UIImageJPEGRepresentation(image, 0.5);
        
        NSString * imageDataStr =  [_imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        
        if (imageDataStr)
        {
             [self tianjiashuju:imageDataStr];
            
        }else
        {
    //        touxiangStr = @"";
            [WBYRequest showMessage:@"出现错误请等一会操作"];
            
        }
        
    }

    - (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
    {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
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
