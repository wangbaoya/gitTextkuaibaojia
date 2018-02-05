//
//  DailirenzhengxinxiViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DailirenzhengxinxiViewController.h"
#import "DailirenrenzhengTableViewCell.h"
#import "AAzhiwuViewController.h"
#import "WBYNEWGSViewController.h"
#import "WLeiXingViewController.h"
#import "WbyJIgouViewController.h"
#import "Order.h"
#import "APAuthV2Info.h"
#import "Util/DataSigner.h"
#import "AlipaySDK.framework/Headers/AlipaySDK.h"
#import "WBYzfcgViewController.h"


@interface DailirenzhengxinxiViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,AipOcrDelegate>
{
    NSMutableArray * bigArr;
    UITableView * myTab;
    
    NSString * type1;
    NSString * type2;
    
    NSString * jigoutype;
    UIView * bigView;
}
@end

@implementation DailirenzhengxinxiViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"代理认证信息";
    
    NSArray * firstArr = @[@"姓名",@"身份证号"];
    NSArray * secondArr = @[@"公司类型",@"公司名称",@"保险网点"];
    NSArray * threeArr = @[@"职务",@"推荐人"];
    bigArr = [NSMutableArray arrayWithObjects:firstArr,secondArr,threeArr, nil];
    [self creatLeftTtem];
    [self creatui];
    
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dianji) name:@"tiaozhuan" object:nil];
    
    
}


-(void)dianji
{
    [self.navigationController pushViewController:[WBYzfcgViewController new] animated:YES];
}

-(void)creatui
{
  UIView *   aView = [[UIView alloc] initWithFrame:CGRectMake(0,0, wScreenW, 10)];
    aView.backgroundColor = RGBwithColor(241, 241, 241);
    
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, wScreenW, wScreenH - 64-44 ) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    myTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [myTab registerClass:[DailirenrenzhengTableViewCell class] forCellReuseIdentifier:@"cell"];
    myTab.tableHeaderView = aView;
    myTab.backgroundColor = RGBwithColor(241, 241, 241);
    myTab.separatorColor = FENGEXIANcolor;
    myTab.bounces = NO;
    myTab.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:myTab];
    
    [myTab setSeparatorInset:UIEdgeInsetsZero];
    [myTab setLayoutMargins:UIEdgeInsetsZero];
   
    UIView * bgview = [[UIView alloc] initWithFrame:CGRectMake(0, wScreenH-44-64, wScreenW, 44)];
    bgview.backgroundColor = wWhiteColor;
    [self.view addSubview:bgview];
    
    UILabel * alab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,2* wScreenW/3, 44)];
    
    
  CGFloat aaa = [_aModel.total_fee floatValue]*[_aModel.discount floatValue]-[_aModel.minus floatValue];
    
    alab.text = [NSString stringWithFormat:@"  %.2f 元",aaa];
    alab.textColor = wRedColor;
    alab.font = Font(22);
    [bgview addSubview:alab];
  
    UIButton * aBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    aBtn.frame = CGRectMake(CGRectGetMaxX(alab.frame), 0, wScreenW/3, 44);
    
    
        if ([RENZHENGZHUANGTAI isEqualToString:@"3"])
        {
            [aBtn setTitle:@"审核中" forState:UIControlStateNormal];
            aBtn.enabled = NO;
            
        }else
        {
            [aBtn setTitle:@"提交" forState:UIControlStateNormal];
            
        }
    
    
    [aBtn setTitleColor:wWhiteColor forState:UIControlStateNormal];
    aBtn.backgroundColor = SHENLANSEcolor;
    
    [aBtn addTarget:self action:@selector(tijiao) forControlEvents:UIControlEventTouchUpInside];
    
    [bgview addSubview:aBtn];
 }

-(void)tijiao
{
        
    [self creatrequestData];
}
-(void)creatrequestData
{
    UITextField * xmtf =[myTab viewWithTag:200];
    UITextField * shenfenzhtf =[myTab viewWithTag:200+1];
//    UITextField * leixingtf =[myTab viewWithTag:600];
//    UITextField * mingchengzhtf =[myTab viewWithTag:600+1];
    UITextField * wangdiantf =[myTab viewWithTag:600+2];
    UITextField * zhiwutf = [myTab viewWithTag:700];
    UITextField * tuijiantf = [myTab viewWithTag:700+1];
  
    
    WS(weakSelf);
    if (KEY&&UID)
    {
        if (xmtf.text.length>+1)
        {
            if ([WBYRequest isPersonIDCardNumber:shenfenzhtf.text])
            {
                if (wangdiantf.text.length>=1||type2.length>=1)
                {
                    if (tuijiantf.text.length>=1)
                    {
                        if ([WBYRequest isMobileNumber:tuijiantf.text])
                        {
                            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
                            
//                            [dic setObject:UID forKey:@"uid"];
                            
                            [dic setObject:xmtf.text forKey:@"name"];
                            [dic setObject:shenfenzhtf.text forKey:@"id_number"];
                            [dic setObject:jigoutype?jigoutype:@"" forKey:@"oid"];
                            [dic setObject:type2?type2:@"" forKey:@"cid"];
                            
                            [dic setObject:LNGONE forKey:@"lng"];
                            [dic setObject:LATTWO forKey:@"lat"];
                            [dic setObject:zhiwutf.text?zhiwutf.text:@"" forKey:@"profession"];
                            [dic setObject:tuijiantf.text?tuijiantf.text:@"" forKey:@"rec_mobile"];
                            [WBYRequest wbyLoginPostRequestDataUrl:@"save_verify" addParameters:dic success:^(WBYReqModel *model)
                             {                                
                                [WBYRequest showMessage:model.info];
                                 [weakSelf fukuan];
                                 
                                if ([model.err isEqualToString:SAME])
                                {
                                    [weakSelf goLogin];
                                }
                            } failure:^(NSError *error) {
                                
                            }];

                            
                        }else
                        {
                            [WBYRequest showMessage:@"请输入推荐人正确的电话号码"];
                        }
                    }else
                    {
                        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
                        
//                    [dic setObject:UID forKey:@"uid"];
                        
                        [dic setObject:xmtf.text forKey:@"name"];
                        [dic setObject:shenfenzhtf.text forKey:@"id_number"];
                        [dic setObject:type2?type2:@"" forKey:@"cid"];
                        [dic setObject:jigoutype?jigoutype:@"" forKey:@"oid"];
                        
                        [dic setObject:LNGONE forKey:@"lng"];
                        [dic setObject:LATTWO forKey:@"lat"];
                        [dic setObject:zhiwutf.text?zhiwutf.text:@"" forKey:@"profession"];
                        [dic setObject:tuijiantf.text?tuijiantf.text:@"" forKey:@"rec_mobile"];
                        [WBYRequest wbyLoginPostRequestDataUrl:@"save_verify" addParameters:dic success:^(WBYReqModel *model)
                        {
                        [WBYRequest showMessage:model.info];
                            
                            [weakSelf fukuan];

                            if ([model.err isEqualToString:SAME])
                            {
                                [weakSelf goLogin];
                            }
                        } failure:^(NSError *error) {
                            
                        }];
                    }
                    
                 }else
                {
            [WBYRequest showMessage:@"请输入保险网点"];
   
                }
                
            }else
            {
                [WBYRequest showMessage:@"请输入合法的身份证号"];
            }
        }else
        {
            [WBYRequest showMessage:@"请输入真实姓名"];
        }
    }else
    {
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要去登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [view show];
    }
}

#pragma mark====弹出框代理方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    UITextField * tf = [self.view viewWithTag:201];

    if (alertView.tag==998)
    {
        if (buttonIndex==1)
        {
//          [tf resignFirstResponder];
            tf.enabled = NO;
            UIViewController * vc = [AipCaptureCardVC ViewControllerWithCardType:CardTypeIdCardFont andDelegate:self];
            [self presentViewController:vc animated:YES completion:nil];
        }else
        {
            tf.text = @"";
            tf.enabled = YES;
            [tf becomeFirstResponder];
        }
        
    }else
    {
        if (buttonIndex==1)
        {
            [self goLogin];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HANGGAO;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * bgView;
    
    if (!bgView)
    {
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0,0, wScreenW, 10)];
        bgView.backgroundColor = RGBwithColor(241,241,241);
        
    }
    
    return bgView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return bigArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [bigArr[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DailirenrenzhengTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.aLab.text = bigArr[indexPath.section][indexPath.row];
    cell.aTf.delegate = self;
    if (indexPath.section==0)
    {
        cell.aTf.tag = 200+indexPath.row;
        
        if ([RENZHENGZHUANGTAI isEqualToString:@"3"])
        {
            //           审核中
            cell.aTf.enabled = NO;
            if (indexPath.row==0)
            {
                cell.aTf.text = _aModel.name;
            }else
            {
                cell.aTf.text = _aModel.id_number;
            }
            
        }else
        {
            cell.aTf.enabled = YES;
            
            if (indexPath.row==0)
            {
                cell.aTf.text = _aModel.name;
            }else
            {
                cell.aTf.placeholder = @"请输入身份证号";
                
                cell.aTf.enabled = NO;
            }
        }
         }
    else if (indexPath.section==1)
    {
        cell.aTf.tag = 600+indexPath.row;

        if ([RENZHENGZHUANGTAI isEqualToString:@"3"])
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            
            cell.aTf.enabled = NO;
            
            if (indexPath.row==0)
            {
                
                if ([_aModel.ctype isEqualToString:@"1"])
                {
                    cell.aTf.text = @"寿险";
                }else if ([_aModel.ctype isEqualToString:@"2"])
                {
                    cell.aTf.text = @"财险";
 
                }else if ([_aModel.ctype isEqualToString:@"9"])
                {
                    cell.aTf.text = @"代理";
                    
                }else if ([_aModel.ctype isEqualToString:@"10"])
                {
                    cell.aTf.text = @"经济";
                    
                }else if ([_aModel.ctype isEqualToString:@"11"])
                {
                    cell.aTf.text = @"公估";
                    
                }
                
            }else if(indexPath.row==1)
            {
                cell.aTf.text = _aModel.cname;
                
            }else
            {
                cell.aTf.text = _aModel.oname;
            }
            

        }else
        {
             cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.aTf.enabled = NO;

            if (indexPath.row==0)
            {
                cell.aTf.placeholder = @"请选择公司类型";
                
            }else if(indexPath.row==1)
            {
                cell.aTf.placeholder = @"请选择公司名称";
                
            }else
            {
                cell.aTf.placeholder = @"请选择保险网点";
            }
        }
        
    }else
    {
        cell.aTf.tag = 700+indexPath.row;
        
        if ([RENZHENGZHUANGTAI isEqualToString:@"3"])
        {
            //           审核中
            cell.aTf.enabled = NO;
            if (indexPath.row==0)
            {
                cell.aTf.text = _aModel.profession;
            }else
            {
                cell.aTf.text = _aModel.rec_mobile;
            }
            
        }else
        {
            if (indexPath.row==0)
            {
                cell.aTf.enabled = NO;
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.aTf.placeholder = @"请选择职务";
            }else
            {
                cell.aTf.placeholder = @"请输入推荐人手机号";
            }
        }
    }
    
    return cell;
}

#pragma mark====textfiled代理方法
//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    
//    if (textField.tag==201&&textField.text.length<1)
//    {
//     
//    }
//    
//}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if ([RENZHENGZHUANGTAI isEqualToString:@"3"])
    {
        //           审核中
    }else
    {
        
        UITextField * xmtf =[myTab viewWithTag:200];
        UITextField * shenfenzhtf =[myTab viewWithTag:200+1];
        UITextField * tuijiantf = [myTab viewWithTag:700+1];
        UITextField * zhiwutf = [myTab viewWithTag:700];
        
        if (indexPath.section==0)
        {
            
            if (indexPath.row==1)
            {
                
                UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"填写身份证还是照相识别？" delegate:self cancelButtonTitle:@"填写" otherButtonTitles:@"照相识别", nil];
                view.tag = 998;
                
                  [view show];
                
            }
            
        }
        
        if (indexPath.section==1)
        {
            [xmtf resignFirstResponder];
            [shenfenzhtf resignFirstResponder];
            
            UITextField * tf = [myTab viewWithTag:600+indexPath.row];
            UITextField * tf1 = [myTab viewWithTag:600];
            UITextField * tf2 = [myTab viewWithTag:600+1];
            if (indexPath.row==0)
            {
                WLeiXingViewController * leixing = [WLeiXingViewController new];
                leixing.allBlock = ^(NSString  * muStr,NSString * shuStr)
                {
                    tf.text = muStr;
                    type1 = shuStr;
                    
                };
                
                [self.navigationController pushViewController:leixing animated:YES];
            }else if(indexPath.row==1)
            {
                
                if (tf1.text.length>1)
                {
                    WBYNEWGSViewController * gongsi = [WBYNEWGSViewController new];
                    
                    gongsi.type = type1;
                    gongsi.myZCid = ^(NSString * myId,NSString*myName)
                    {
                        tf.text = myName;
                        type2 = myId;
                    };
                    [self.navigationController pushViewController:gongsi animated:YES];
                }else
                {
                    [WBYRequest showMessage:@"请选择公司类型"];
                }
            }else
            {
                if (tf2.text.length>1)
                {
                    WbyJIgouViewController * gongsi = [WbyJIgouViewController new];
                    
                    gongsi.type = type2;
                    gongsi.myGongsi = ^(NSString * myId,NSString*myName)
                    {
                        tf.text = myName;
                        
                        jigoutype = myId;
                    };
                    
                    [self.navigationController pushViewController:gongsi animated:YES];
                }else
                {
                    [WBYRequest showMessage:@"请选择公司名字"];
                }
            }
        }
        
        if (indexPath.section==2)
        {
            
            [xmtf resignFirstResponder];
            [shenfenzhtf resignFirstResponder];
            
            if (indexPath.row==0)
            {
                AAzhiwuViewController * zhiwu = [AAzhiwuViewController new];
                zhiwu.zhiwuBlock = ^(NSString * zhiwu)
                {
                    zhiwutf.text = zhiwu;
                };
                [self.navigationController pushViewController:zhiwu animated:YES];
            }
            else
            {
                [tuijiantf resignFirstResponder];
            }
        }
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)fukuan
{

     bigView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH)];
    
    [[[UIApplication sharedApplication].delegate window] addSubview:bigView];
    
    UIView * upview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH-44*6-60)];
    upview.backgroundColor = RGBwithColor(108, 108, 108);
    [bigView addSubview:upview];
   
    UIView * downView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(upview.frame), wScreenW, 44*6+60)];
    downView.backgroundColor = wWhiteColor;
    [bigView addSubview:downView];
    
    UILabel * alab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 60)];
    alab.textColor = wBlackColor;
    alab.text = @"付款详情";
    alab.textAlignment = 1;
    [downView addSubview:alab];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(wScreenW-20-10, 20, 20, 20);
    [btn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e62a", 20, wBlackColor)] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(yichu) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:btn];
    
    NSArray * larr = @[@"应付金额",@"支付说明",@"支付方式",@"",@""];
    
    CGFloat aaa = [_aModel.total_fee floatValue]*[_aModel.discount floatValue]-[_aModel.minus floatValue];
    
//    alab.text = [NSString stringWithFormat:@".2%f",aaa];

    NSArray * rarr = @[[NSString stringWithFormat:@"%.2f",aaa],_aModel.title?_aModel.title:@"代理人VIP认证",@"",@"",@""];

    for (NSInteger i =0; i<5; i++)
    {
        
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 60+44*i, 80,44)];
        lab.textColor = wBlackColor;
        lab.text = larr[i];
        lab.font = Font(14);
        [downView addSubview:lab];
        
        UILabel * alab = [[UILabel alloc] initWithFrame:CGRectMake(90, 60+44*i,wScreenW-80-20,44)];
        alab.textColor = wBlackColor;
        alab.text = rarr[i];
        alab.textAlignment =2;
        alab.font = Font(14);
        [downView addSubview:alab];
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 60+(43.5+0.5)*i, wScreenW, 0.5)];
        view.backgroundColor = FENGEXIANcolor;
        [downView addSubview:view];
    }
    
    UIView * bView = [[UIView alloc] initWithFrame:CGRectMake(0, 60+44*3, wScreenW, 44)];
    [downView addSubview:bView];
    
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 34, 34)];
    img.image = [UIImage imageNamed:@"zhifubao"];
    
    [bView addSubview:img];
    
    UILabel * dLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(img.frame)+10, 0, 80,44)];
    alab.text = @"支付宝";
    alab.textColor = wBlackColor;
    
    [bView addSubview:dLab];
    
    UIButton * ccBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ccBtn.frame = CGRectMake(wScreenW-20-24,10, 24,24);
    
    [ccBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61c", 24, [UIColor orangeColor])] forState:UIControlStateNormal];
    
    
    [bView addSubview:ccBtn];
    
    UIButton * aBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    aBtn.frame = CGRectMake(0, 60+44*5, wScreenW, 44);
    
    [aBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    [aBtn setTitleColor:wWhiteColor forState:UIControlStateNormal];
    aBtn.backgroundColor = SHENLANSEcolor;
    
    [aBtn addTarget:self action:@selector(zhifu) forControlEvents:UIControlEventTouchUpInside];
    
    [downView addSubview:aBtn];
    
}

-(void)zhifu
{
    
    
    [bigView removeFromSuperview];
    /*
     NSString *partner = @"2088321011137575";
     NSString *seller = @"327392652@qq.com";
     NSString *privateKey = @"MIICXAIBAAKBgQDBNma3AjiUReEaeWI/64Ks1AMPJ94819P21WODXJ1sgWivJL44ajMH+ughcn+LbwucdpTH/ECgjOqQnDUk9suwcSR2Hu/JkiDh+ow6CQNPphxUN2pDiOF72ZA+cfE2xLyLUb3qvTtJsVbXnik0pLUHo1aPbgL5uvnbMVzwyccFLQIDAQABAoGAXQCMrKbbCTQhyJaJHm+EtSBQYKk2Jl9VXkkU35RjCmm4NCYhkhI8gijaN89faYSIOEY0E5dunFl4RyeJxUMug+a9UVKEu5qSON58mE4CWTEo97EEvv91w6hE+kFTxxaBU3XoPusWGUUWiK2d2Fl8wMOVrYj+mqKIPtIOCVASatkCQQD0p1rltuPOCk4CJQsOkQZSvlexx21zhySCjNyW9UTJ+em0jPXbOBN+QYFg/bPeVdR3yxVP8DVEaRLkEqLRCveTAkEAyixPwyFg/ebdlcatDNR8bCpqe3Ceo58I6juZgasyP8SclsANWOhAFyLsapgdwmtBxkv9ycWtOnlVvwqOpfqIPwJASfO0dC9+WK+guOE9oF+SC7zhgSmJGhzFmni9zRvCeVMDo8HgJy2iJs3iL9FAZ3qGSNeoT4uKbm1cenhvosSv5QJAB6D+bYWP7GTOzb0OgKJwA4DiPcA1LEVvB6+yDjOQlNltcz7SAh3ZdUYLF8afsNttQvdRH1EHRWKYurnCQj8e7wJBAJUTfAF3cCKU8PmrpGxyXuuyKnznaGBHM/GEspvUx85Ch6arASwasmdAchAnRnI1r4AOhtBate9iXZIfRz8aFcI=";*/
    
    
    NSString *partner = @"2088121127399832";
    NSString *seller = @"kuaibaojia@163.com";
    NSString*privateKey=@"MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCAWm0IlcHH2jomjYszzXAbjVR4bJZ8usztoxtLbSTCeimI/Th69FquZ7icCrlMxzT919W1RdYoFzGGnCkz5e9eqVX27326yNBmQxhGAH7JPczJQLGqhMDLHpYccGLrEk+MnTUkp6k0jqvfyP7ZJdpcEx2QHLX6WoFEH6P8dEuVjCOQ8B5mJbVds6aTqUy/0gLvJPJwxTub38PRAPl37BhW+fmzipws4C38Dk3ZsOSm02tJcjcBdcPD3rtYtHnOOiw/iVYq3mRxdUIpy/ei6ALGIN8Zl8Id47das/TKtPAj7xQYKouA3yOkBpzPzkZxS0IGrIomyZZYET5lbid2rQ5RAgMBAAECggEABEqBoKrZCqRqE0XiJH42xEUKUOhYc50PIta0H+ZrNzE8WD8W901aBsCi9FyLa1yxkdb4ZxIJodd8qWJpIjoKsaB5pkLFckwqY3DUy+pSUsoFIalPB0Ne6quAGz1KoU9AZ5QN5cbRKlemuVmP45SXY0KkV2AOWWtTLQLdyZ/dswcrPeOElqM6b/gRnKCoIS6iiWSZzY5+dthqURgDLKcMwZQfo6o53ZoeLXj1jV/RTc/rxnCp9i+hmNlu914y9gP4W9lFU7CsKmH8jidnXcT+5CPAEiOqbP1H1c6sGRq1y1iqnguYniFT2+uN6vPI/iqVypPK7MVr0Kdtc/JSEQdmkQKBgQC4oeCIi9mA9PJmXBc1/WoP3MO8YUCmf2eymrx+okLNO6gjEWtrL6LuZhljgs5yM/uxqvuW3hI0a0fU3aii6i8hhK4rZJLqUbaw/WcYIZJIgpfv4yrjVyTztu68Wc1ZZAb1+AZBIGyThSBejg/rPOIL5PC0wFZ9QsUxc5eMDDRt/QKBgQCx94BmC9wlFHPzXuo3QpvcKuaBK+AvEZ3nrHkG94Toa0De9CkPl7Svr0ub5lKnEhJPmfjbZPwQSHY0yalNsZNaNBBtJSuYnPsZKSCTp53byBNAFHSEB9w6kwC0M9GibVzYwVu2fLrFuNktBZrXw3l1FyZVoFzUXxzVhJ4rypPH5QKBgQCar2zJmblplE69uWvs3NqOXZxT6Hrcw6MifQdtZQ5omhGdB8wiai+sYjflKkNCZRD7YlAUrws7haIR0n+ltmQ0RdASJNn9nOZd1IAaNI41V8xpu75D58/arCnJ/cbQnMBENT8wMzUkRwW+knD92e1cn7uXBAmyOk2xx7FxMQyAFQKBgQCuZr2NQ1IZhFGczgb44G2c9O2u6DBp7/mub3arPSUiHvkThHI4tZJ8GG0f+jZFQ5BuMZWOawgZbOlqEbW4Taz5WMxAKYzvoebwYT1rdXddSlSTF3iXapyHSkgGUEG/yyyRvesCinj+CofJdxSnHQiJloYao2xVMmAvXicjAwKPgQKBgQCMhAGjw6IG8o1uZXy93s3KpzWz6p43rCFhWmJCZmC57d2tvUaQ2ZbQb2qYFrpaZhSBDtJqoJSNCmptYfBf7YxnO9fqvUYA15invoO+zy0i6F4D3hnYRGymEEzXT6qL1ZiVwGdXXR1FmSVP08W67T54x7K/pp4gfqQvKpCedUvatA==";
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"message:@"缺少partner或者seller或者私钥。"delegate:self cancelButtonTitle:@"确定"otherButtonTitles:nil];
        [alert show];
        
        return;
    }
  
    
    
        //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.sellerID = seller;
    order.outTradeNO = _aModel.out_trade_no; //订单编号
    order.subject =_aModel.title;//商品标题
    order.body = _aModel.remark; //商品描述了；
    CGFloat aaa = [_aModel.total_fee floatValue]*[_aModel.discount floatValue]-[_aModel.minus floatValue];

    order.totalFee = [NSString stringWithFormat:@"%.2f",aaa];
    
//    order.totalFee = [NSString stringWithFormat:@"0.01"];
    
    order.notifyURL = [NSString stringWithFormat:@"http://w.kuaibao365.com/pay/ali"]; //回调URL
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showURL = @"m.alipay.com";
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"fastprotecthome";
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    id <DataSigner> signer = CreateRSADataSigner(privateKey);
    
    NSString *signedString = [signer signString:orderSpec];
    NSString *orderString = nil;
    
    if (signedString != nil)
    {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic)
         {
             NSString*str=resultDic[@"resultStatus"];
             
             if ([str isEqualToString:@"4000"])
             {
                 [WBYRequest showMessage:@"请安装支付宝客户端"];
             }
         }];
    }
}



-(void)yichu
{
    
    [bigView removeFromSuperview];
}

#pragma mark AipOcrResultDelegate
//拍照识别回调
- (void)ocrOnIdCardSuccessful:(id)result
{
    NSLog(@"6666%@", result);
    
    UITextField * tf = [self.view viewWithTag:201];

    NSString *title = nil;
    NSMutableString *message = [NSMutableString string];
    
    
    
    if(result[@"words_result"])
    {
        [result[@"words_result"] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
        {
            [message appendFormat:@"%@: %@\n", key, obj[@"words"]];
            
            
        }];
    }
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        
          alertView.tag = 99999;
        
             [alertView show];
        
        NSString * litdic = result[@"words_result"][@"公民身份号码"][@"words"];
            tf.text = litdic;
        
    }];
    
    
}

//银行卡回调
- (void)ocrOnBankCardSuccessful:(id)result {
    NSLog(@"8888%@", result);
    NSString *title = nil;
    NSMutableString *message = [NSMutableString string];
    title = @"银行卡信息";
    //    [message appendFormat:@"%@", result[@"result"]];
    [message appendFormat:@"卡号：%@\n", result[@"result"][@"bank_card_number"]];
    [message appendFormat:@"类型：%@\n", result[@"result"][@"bank_card_type"]];
    [message appendFormat:@"发卡行：%@\n", result[@"result"][@"bank_name"]];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }];
}

- (void)ocrOnGeneralSuccessful:(id)result {
    NSLog(@"9999%@", result);
    NSMutableString *message = [NSMutableString string];
    if(result[@"words_result"]){
        for(NSDictionary *obj in result[@"words_result"]){
            [message appendFormat:@"%@", obj[@"words"]];
        }
    }else{
        [message appendFormat:@"%@", result];
    }
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[[UIAlertView alloc] initWithTitle:@"识别结果" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    }];
    
}

- (void)ocrOnFail:(NSError *)error
{
    NSLog(@"111111%@", error);
    NSString *msg = [NSString stringWithFormat:@"%li:%@", (long)[error code], [error localizedDescription]];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[[UIAlertView alloc] initWithTitle:@"识别失败" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
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
