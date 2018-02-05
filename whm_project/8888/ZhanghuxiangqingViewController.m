//
//  ZhanghuxiangqingViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ZhanghuxiangqingViewController.h"
#import "ZhanghuxiangqingTableViewCell.h"
#import "XingmingViewController.h"
#import "XiangxidizhiViewController.h"
#import "DatePickerView.h"
#import "PickView.h"

@interface ZhanghuxiangqingViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
{
    UITableView * myTab;
    NSArray * xmArr;
    NSArray * dzArr;
    NSString * touxiangStr;

    BOOL isOk;
    NSInteger sourceType;
    NSArray  * myArr;
      UIView *_chooseCityView;

}
@property (strong,nonatomic) DatePickerView *datePickerView;

@property (nonatomic,strong)NSURL * imageUrl;
@property (nonatomic,strong)NSData *imageData ;
@property (nonatomic,strong)UIImage *images;
@property (nonatomic, strong)PickView * cityPickerView;



@end

@implementation ZhanghuxiangqingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"账户详情";
    [self creatLeftTtem];
    xmArr = @[@"头像",@"姓名",@"性别",@"出生时间"];
    dzArr = @[@"所在地区",@"详细地址"];
    myArr = [NSArray array];
    _cityPickerView = [[PickView alloc] init];
    _cityPickerView.backgroundColor= JIANGEcolor;
    
    
    [self creatLeftTtem];
    
    [self creatrequestData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
//    [self creatrequestData];
}
-(void)creattab
{
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH - 64) style:UITableViewStylePlain];
    myTab.delegate = self;
    myTab.dataSource = self;
    myTab.bounces = NO;
    myTab.separatorColor = FENGEXIANcolor;
    
    [myTab registerClass:[ZhanghuxiangqingTableViewCell class] forCellReuseIdentifier:@"cell"];
    myTab.backgroundColor = JIANGEcolor;
    [myTab setSeparatorInset:UIEdgeInsetsZero];
    [myTab setLayoutMargins:UIEdgeInsetsZero];
    [self.view addSubview:myTab];
  
    myTab.tableFooterView = [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        return 80;
    }else
    {
        return HANGGAO;
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * aView;
    
    
    if (!aView)
    {
        aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 8)];
        aView.backgroundColor = JIANGEcolor;
        
        
    }
    return aView;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0)
    {
        return 4;
    }else
    {
        return 2;
    }
   
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
return 2;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZhanghuxiangqingTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    cell.llab.textColor = wBlackColor;
    cell.rTf.textAlignment = 2;
    cell.rTf.enabled = NO;
    cell.rTf.textColor = QIANZITIcolor;
    if (myArr.count>=1)
    {
        DataModel *_perMod =[myArr firstObject];
        
        if (indexPath.section==0)
        {
            cell.rTf.tag = 700+indexPath.row;
            cell.llab.text = xmArr[indexPath.row];
            
            if (indexPath.row==0)
            {
                cell.rTf.hidden = YES;
                cell.llab.hidden = YES;
                cell.rLab.frame = CGRectMake(10, 15, 80,50);
                cell.rLab.text = @"头像";
                cell.rLab.font = daFont;
                cell.rLab.textColor = wBlackColor;
                cell.myBtn.frame=CGRectMake(wScreenW - 50 - 20-10, 15, 50, 50);
                cell.myBtn.tag = 5858;
                cell.myBtn.layer.masksToBounds = YES;
                cell.myBtn.layer.cornerRadius = 25;
                [cell.myBtn sd_setImageWithURL:[NSURL URLWithString:_perMod.avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"city"]];
                
                
            }else if (indexPath.row == 1)
            {
                cell.myBtn.hidden = YES;
                cell.rTf.hidden = NO;
                cell.rLab.hidden = YES;
                cell.rTf.text = _perMod.name?_perMod.name:@"暂无";
            }else if (indexPath.row==2)
            {
                if ([_perMod.sex  isEqual:@"1"])
                {
                    cell.rTf.text = @"男";
                }else{
                    cell.rTf.text = @"女";
                }
            }else if (indexPath.row==3)
            {
                cell.rTf.text = _perMod.birthday;
            }
        }else
        {
            cell.rTf.tag = 800+indexPath.row;
            
            cell.llab.text = dzArr[indexPath.row];
            cell.myBtn.hidden = YES;
            cell.rTf.hidden = NO;
            cell.rLab.hidden = YES;
            
            if (indexPath.row==0)
            {
                cell.rTf.text = _perMod.area_info?_perMod.area_info:@"请选择地区";
            }else
            {
                cell.rTf.text = _perMod.address?_perMod.address:@"请输入详细地区";
                
            }        
        }
        
    }    
        return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WS(weakSelf);
 [weakSelf.datePickerView  removeFromSuperview];
    if (myArr.count>=1)
    {
        DataModel *_perMod =[myArr firstObject];
        if (indexPath.section==0)
        {    [_cityPickerView hiddenPickerView];

            UITextField * tf = [myTab viewWithTag:700+indexPath.row];
            
            if (indexPath.row==0)
            {
                [self changeTouXiang];
                
            }else if (indexPath.row==1)
            {
                XingmingViewController * xingming = [XingmingViewController new];
                xingming.name = _perMod.name;
                xingming.myXingmingBlock = ^(NSString * aname)
                {
                    tf.text = aname;
                    
                    [weakSelf requestData:@"name" val:aname];
                };
                [self.navigationController pushViewController:xingming animated:YES];
            }else if (indexPath.row==2)
            {
                [XuanXIngBie showWithTitle:@"选择性别" titles:@[@"男",@"女"] selectIndex:^(NSInteger selectIndex)
                 {
                     
                 } selectValue:^(NSString *selectValue) {
                     
                     tf.text = selectValue;
                     if ([selectValue isEqualToString:@"男"])
                     {
                         [weakSelf requestData:@"sex" val:@"1"];
  
                     }else
                     {
                         [weakSelf requestData:@"sex" val:@"0"];
                     }
                 } showCloseButton:YES];
                
                
            }else
            {
               
                _datePickerView = [[DatePickerView alloc] initWithCustomeHeight:260 xzhou:0 yzhou:wScreenH-260-64];
                [self.view addSubview:_datePickerView];
                
                _datePickerView.confirmBlock = ^(NSString *choseDate, NSString *restDate)
                {
                    [weakSelf requestData:@"birthday" val:choseDate];
                  
                    tf.text = choseDate;
                    [weakSelf.datePickerView removeFromSuperview];
 
                };
                
                _datePickerView.cannelBlock = ^(){
                    
                    [weakSelf.view endEditing:YES];
                    
                    [weakSelf.datePickerView  removeFromSuperview];
                    
                };
     
                
                
            }
            
        }else
        {
             [weakSelf.datePickerView  removeFromSuperview];
            UITextField * tf = [myTab viewWithTag:800+indexPath.row];
            if (indexPath.row==0)
            {
//                [_cityPickerView hiddenPickerView];

                [self creatpickvie];
     
                
            }else
            {
                [_cityPickerView hiddenPickerView];

                XiangxidizhiViewController * dizhi = [XiangxidizhiViewController new];
                dizhi.dizhi = _perMod.address;
                
                dizhi.mydizhiBlock = ^(NSString*dizhi)
                {
                    tf.text = dizhi;
                    
                    [weakSelf requestData:@"address" val:dizhi];
                };
                [self.navigationController pushViewController:dizhi animated:YES];
            }
        }
    }
}

-(void)creatpickvie
{
    [UIView animateWithDuration:0.3f animations:^{
        _chooseCityView.frame = CGRectMake(-2, self.view.frame.size.height - 240, self.view.frame.size.width+4, 40);
    }];
    [_cityPickerView showInView:self.view];
    
    _chooseCityView = [[UIView alloc]initWithFrame:CGRectMake(1,0,wScreenW-2, 40)];
    _chooseCityView.backgroundColor = [UIColor whiteColor];
    _chooseCityView.layer.borderColor = wBaseColor.CGColor;
    _chooseCityView.layer.borderWidth = 0.6f;
    [_cityPickerView addSubview:_chooseCityView];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(12, 0, 40, 40);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(pickerviewbuttonclick:) forControlEvents:UIControlEventTouchUpInside];
    [_chooseCityView addSubview:cancelButton];
    
    UIButton *chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseButton.frame = CGRectMake(self.view.frame.size.width - 50, 0, 40, 40);
    [chooseButton setTitle:@"确定" forState:UIControlStateNormal];
    chooseButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [chooseButton setTitleColor:wBlue forState:UIControlStateNormal];
    [chooseButton addTarget:self action:@selector(pickerviewbuttonclick:) forControlEvents:UIControlEventTouchUpInside];
    [_chooseCityView addSubview:chooseButton];
}

- (void)pickerviewbuttonclick:(UIButton *)sender
{
    UITextField * lab = [self.view viewWithTag:800];
    
    if ([sender.titleLabel.text isEqualToString:@"确定"])
    {
      
        
        lab.text = [NSString stringWithFormat:@"%@,%@,%@",_cityPickerView.sheng,_cityPickerView.shi,_cityPickerView.qu];
        
//        StrAreaID = [NSString stringWithFormat:@"%@,%@,%@",_cityPickerView.idprovence,_cityPickerView.idcity,_cityPickerView.idarea];
        [self requestData:@"area_info" val:[NSString stringWithFormat:@"%@,%@,%@",_cityPickerView.idprovence,_cityPickerView.idcity,_cityPickerView.idarea]];
        
        
    }
    
    [_cityPickerView hiddenPickerView];
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
    UIButton*abtn=[myTab viewWithTag:5858];
    
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
    
    
    [abtn setImage:_images forState:UIControlStateNormal];
    
    _imageData=UIImageJPEGRepresentation(image, 0.5);
    
    NSString * imageDataStr =  [_imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];   
    
    if (imageDataStr)
    {
        touxiangStr = imageDataStr;
        
        [self requestData:@"avatar" val:imageDataStr];
        
        
    }else
    {
        touxiangStr = @"";
        [WBYRequest showMessage:@"出现错误请等一会操作"];
        
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)requestData:(NSString*)name val:(NSString*)aval
{
    WS(weakSelf);
    if (KEY&&UID)
    {
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        
        [dic setObject:UID forKey:@"uid"];
        
        [dic setObject:name forKey:@"col"];
        [dic setObject:aval?aval:@"" forKey:@"val"];
        
        
        [WBYRequest wbyLoginPostRequestDataUrl:@"save_user" addParameters:dic success:^(WBYReqModel *model) {
            
            [WBYRequest showMessage:model.info];
            if ([model.err isEqualToString:SAME])
            {
                [weakSelf goLogin];
            }
            
            
            
        } failure:^(NSError *error) {
            
        }];
        
        
        
    }else
    {
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要去登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [view show];
    }
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        [self goLogin];
    }
}




-(void)creatrequestData
{
    
    WS(weakSelf);
    if (KEY&&UID)
    {
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        
        [dic setObject:UID forKey:@"uid"];
        
        [WBYRequest wbyLoginPostRequestDataUrl:@"get_user" addParameters:dic success:^(WBYReqModel *model) {
            if ([model.err isEqualToString:TURE])
            {
                myArr = model.data;
                [weakSelf creattab];

            }
            
            if ([model.err isEqualToString:SAME])
            {
                [weakSelf goLogin];
            }
            
            [myTab reloadData];
            
        } failure:^(NSError *error) {
            
        }];
        
        
        
    }else
    {
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要去登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [view show];
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
