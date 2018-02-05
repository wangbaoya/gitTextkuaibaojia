//
//  XiuGaiViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XiuGaiViewController.h"
#import "XiugaixinxiTableViewCell.h"
#import "DatePickerView.h"
#import "GuanxiViewController.h"
#import "XuanXIngBie.h"

@interface XiuGaiViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView * myTab;
    NSArray * lArr;
    BOOL isOk;
    NSInteger sourceType;
    NSString * touxiangStr;
    NSString * guanxiID;
    
}
@property (strong,nonatomic) DatePickerView *datePickerView;

@property (nonatomic,strong)NSURL * imageUrl;
@property (nonatomic,strong)NSData *imageData ;
@property (nonatomic,strong)UIImage *images;

@end

@implementation XiuGaiViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (_xiugaiNumber==666)
    {
        self.title = @"修改被保人";
    }else
    {
        self.title = @"添加被保人";
    }
    
    lArr = @[@"头像",@"姓名",@"性别",@"关系",@"出生时间",@"年收入",@"负债"];
    [self creatLeftTtem];
    [self creatOneView];
    [self creatright];
    
}
-(void)creatright
{
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 50, 30);
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:wWhiteColor forState:UIControlStateNormal];
    button.backgroundColor = SHENLANSEcolor;
    button.titleLabel.font = Font(14);
    [button addTarget:self action:@selector(bianji:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:button];

    
}
//保存
-(void)bianji:(UIButton*)btn
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
   
    if (_xiugaiNumber==666)
    {
        for (NSInteger i=1; i<lArr.count; i++)
        {
            UITextField * myTf = [self.view viewWithTag:999+i];
            
            if (myTf.text.length<1)
            {
                myTf.text = myTf.placeholder;
            }
        }
        
        [dic setObject:_aModel.id?_aModel.id:_mModel.id forKey:@"id"];
  
        
    }
    
    UITextField * tf1 = [self.view viewWithTag:999+1];
    UITextField * tf2 = [self.view viewWithTag:999+2];
    UITextField * tf3 = [self.view viewWithTag:999+3];
    UITextField * tf4 = [self.view viewWithTag:999+4];
    UITextField * tf5 = [self.view viewWithTag:999+5];
    UITextField * tf6 = [self.view viewWithTag:999+6];
    
    
    if (tf1.text.length<1)
    {
        [WBYRequest showMessage:@"请输入姓名"];
    }else
    {
     
        [dic setObject:tf1.text forKey:@"name"];
        
        [dic setObject:touxiangStr?touxiangStr:@"" forKey:@"avatar"];
        if ([tf2.text isEqualToString:@"男"])
        {
            [dic setObject:@"1"forKey:@"sex"];
        }else
        {
            [dic setObject:@"2"forKey:@"sex"];
        }
        [dic setObject:tf4.text.length>=1?tf4.text:@"" forKey:@"birthday"];
        [dic setObject:tf3.text.length>=1?tf3.text:@"" forKey:@"relation_name"];
        [dic setObject:tf5.text.length>=1?tf5.text:@"" forKey:@"yearly_income"];
        [dic setObject:tf6.text.length>=1?tf6.text:@"" forKey:@"debt"];

        WS(weakSelf);
        
        btn.enabled = NO;
        
        [WBYRequest wbyLoginPostRequestDataUrl:@"save_rela" addParameters:dic success:^(WBYReqModel *model)
        {
            
            btn.enabled = YES;
                [WBYRequest showMessage:model.info];
            
            if ([model.err isEqualToString:TURE])
            {
                
                
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
            
        } failure:^(NSError *error) {
            
        }];
  
    }
}


-(void)creatOneView
{
    
    UIView * aaaview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 10)];
    aaaview.backgroundColor = JIANGEcolor;
    
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH - 64) style:UITableViewStylePlain];
    myTab.delegate = self;
    myTab.dataSource = self;
    myTab.tableHeaderView = aaaview;
    myTab.backgroundColor = JIANGEcolor;
    myTab.tableFooterView = [UIView new];
    [myTab registerClass:[XiugaixinxiTableViewCell class] forCellReuseIdentifier:@"cell"];
// myTab.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:myTab];
    
    [myTab setSeparatorInset:UIEdgeInsetsZero];
    [myTab setLayoutMargins:UIEdgeInsetsZero];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return lArr.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        return 80;
    }else
    {
        return HANGGAO;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        [self.datePickerView removeFromSuperview];

    XiugaixinxiTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
   
    cell.rTf.tag = 999+indexPath.row;
    
    cell.rTf.delegate = self;
    
    [cell.rTf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row==0||indexPath.row==2||indexPath.row==3||indexPath.row==4)
    {
        cell.rTf.enabled = NO;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else
    {
        cell.rTf.enabled = YES;
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    cell.llab.text = lArr[indexPath.row];
    if (indexPath.row==0)
    {
        cell.rTf.hidden = YES;
        cell.llab.hidden = YES;
        cell.rLab.frame = CGRectMake(10, 15, 80,50);
        cell.rLab.text = @"头像";
        cell.rLab.textColor = wBlackColor;
        cell.myBtn.frame=CGRectMake(wScreenW - 50 - 20-10, 15, 50, 50);
        cell.myBtn.tag = 5858;
        cell.myBtn.layer.masksToBounds = YES;
        cell.myBtn.layer.cornerRadius = 25;
        
        [cell.myBtn addTarget:self action:@selector(huantouxiang) forControlEvents:UIControlEventTouchUpInside];
        if (_xiugaiNumber==666)
        {
            [cell.myBtn sd_setImageWithURL:[NSURL URLWithString:_aModel.avatar?_aModel.avatar:_mModel.avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"city"]];
   
        }else
        {
            [cell.myBtn sd_setImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"city"]];
        }
        
    }else
    {
        cell.myBtn.hidden = YES;
        cell.rTf.hidden = NO;
        cell.rLab.hidden = YES;
        cell.rTf.textAlignment = 2;

        if (indexPath.row==1)
        {
            cell.rTf.placeholder =_xiugaiNumber==666?_aModel.name?_aModel.name:_mModel.name:@"请输入姓名";
        }
        if (indexPath.row==2)
        {
        cell.rTf.textColor = QIANZITIcolor;
            
            cell.rTf.text = _xiugaiNumber==666?[_aModel.sex?_aModel.sex:_mModel.sex  isEqualToString:@"1"]?@"男":@"女":@"男";
        }
        if (indexPath.row==3)
        {
            cell.rTf.placeholder =_xiugaiNumber==666?_aModel.relation_name?_aModel.relation_name:_mModel.relation_name :@"请选择与被保人关系";
     
        }
        if (indexPath.row==4)
        {
        
    cell.rTf.placeholder =_xiugaiNumber==666?[WBYRequest timeStr:_aModel.birthday?_aModel.birthday:_mModel.birthday]:@"请选择出生日期";
            
//  cell.rTf.placeholder =_xiugaiNumber==666?_aModel.birthday?_aModel.birthday:_mModel.birthday:@"请选择出生日期";
            
        }
        if (indexPath.row==5)
        {
            
            cell.rTf.clearButtonMode = UITextFieldViewModeWhileEditing;
            cell.rTf.placeholder = _xiugaiNumber==666?_aModel.yearly_income?_aModel.yearly_income:_mModel.yearly_income:@"请输入年收入";
            
            
            cell.rTf.keyboardType = UIKeyboardTypeNumberPad;
        }
        if (indexPath.row==6)
        {
            cell.rTf.clearButtonMode = UITextFieldViewModeWhileEditing;
            cell.rTf.keyboardType = UIKeyboardTypeNumberPad;
            cell.rTf.placeholder = _xiugaiNumber==666?_aModel.debt?_aModel.debt:_mModel.debt:@"请输入负债";
        }
        
    }
    return cell;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    UITextField * tf4 = [myTab viewWithTag:999+4];
    
    if (textField!=tf4)
    {
        [self.datePickerView removeFromSuperview];
    }
    
}

-(void)textFieldDidChange:(UITextField*)atf
{
    UITextField * tf = [myTab viewWithTag:999+1];
    UITextField * tf1 = [myTab viewWithTag:999+5];
    UITextField * tf2 = [myTab viewWithTag:999+6];
    
    
    if (atf==tf)
    {
        CGFloat maxLength = 4;
        NSString *toBeString = tf.text;
        
        //获取高亮部分
        UITextRange *selectedRange = [tf markedTextRange];
        UITextPosition *position = [tf positionFromPosition:selectedRange.start offset:0];
        
        if (!position || !selectedRange)
        {
            if (toBeString.length > maxLength)
            {
                
                [WBYRequest showMessage:@"姓名不能超过4位"];
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxLength];
                if (rangeIndex.length == 1)
                {
                    tf.text = [toBeString substringToIndex:maxLength];
                }
                else
                {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
                    tf.text = [toBeString substringWithRange:rangeRange];
                }
            }
        }
        
        
    }
    
    if (atf==tf1)
    {
        CGFloat maxLength = 9;
        NSString *toBeString = tf1.text;
        
        //获取高亮部分
        UITextRange *selectedRange = [tf1 markedTextRange];
        UITextPosition *position = [tf1 positionFromPosition:selectedRange.start offset:0];
        if (!position || !selectedRange)
        {
            if (toBeString.length > maxLength)
            {
                [WBYRequest showMessage:@"年收入不能超过9位"];

                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxLength];
                if (rangeIndex.length == 1)
                {
                    tf1.text = [toBeString substringToIndex:maxLength];
                }
                else
                {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
                    tf1.text = [toBeString substringWithRange:rangeRange];
                }
            }
        }
      }
    
    if (atf==tf2)
    {
        CGFloat maxLength = 9;
        NSString *toBeString = tf2.text;
        
        //获取高亮部分
        UITextRange *selectedRange = [tf2 markedTextRange];
        UITextPosition *position = [tf2 positionFromPosition:selectedRange.start offset:0];
        if (!position || !selectedRange)
        {
            if (toBeString.length > maxLength)
            {
                [WBYRequest showMessage:@"负债不能超过9位"];

                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxLength];
                if (rangeIndex.length == 1)
                {
                    tf2.text = [toBeString substringToIndex:maxLength];
                }
                else
                {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
                    tf2.text = [toBeString substringWithRange:rangeRange];
                }
            }
        }
        
    }
    
}

-(void)huantouxiang
{
    
    [self changeTouXiang];
 
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WS(weakSelf);
    [weakSelf.datePickerView removeFromSuperview];
    UITextField * tf= [myTab viewWithTag:999 + indexPath.row];
    if (indexPath.row==0)
    {
        [self changeTouXiang];
    }
    if (indexPath.row==2)
    {
        
        [XuanXIngBie showWithTitle:@"选择性别" titles:@[@"男",@"女"] selectIndex:^(NSInteger selectIndex)
        {
            
            
        } selectValue:^(NSString *selectValue) {
            
            tf.text = selectValue;
            
        } showCloseButton:YES];
        
    }
    
    if (indexPath.row==3)
    {

        GuanxiViewController * guanxi = [GuanxiViewController new];
 
        guanxi.mblock2 = ^(NSString * name,NSString*myId)
        {
            tf.text = name;
            guanxiID = myId;
            
        };
        
        [self.navigationController pushViewController:guanxi animated:YES];
        
    }
    if (indexPath.row==4)
    {
        
        _datePickerView = [[DatePickerView alloc] initWithCustomeHeight:260 xzhou:0 yzhou:wScreenH-260-64];
        
        [self.view addSubview:_datePickerView];
        
        _datePickerView.confirmBlock = ^(NSString *choseDate, NSString *restDate)
        {
            
            tf.text = choseDate;
            
            [weakSelf.datePickerView removeFromSuperview];
            
        };
        
        
        _datePickerView.cannelBlock = ^()
        {
            [weakSelf.view endEditing:YES];
            [weakSelf.datePickerView  removeFromSuperview];
        };

    }
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
    [sheet showInView:self.view];
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
        
        UIImagePickerController * imagePickView=[[UIImagePickerController alloc] init];
        imagePickView.delegate=self;
        imagePickView.allowsEditing=YES;
        imagePickView.sourceType = sourceType;
        
        [self presentViewController:imagePickView animated:YES completion:NULL];
        
        
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIButton*abtn=[myTab viewWithTag:5858];
    
    isOk=YES;
    //    UIButton*myBtn=[self.view viewWithTag:5858];
    
    
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
        
    }else
    {
        touxiangStr = @"";
        [WBYRequest showMessage:@"出现错误请等一会操作"];
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    
    [_datePickerView removeFromSuperview];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
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
