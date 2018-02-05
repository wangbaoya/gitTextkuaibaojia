//
//  ShenHeTixianViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ShenHeTixianViewController.h"

@interface ShenHeTixianViewController ()<AipOcrDelegate>
{
    UITextField * moneyText;
    UITextField * bankNum;
    UITextField * nameText;
    UILabel *  yinhang;
}
@end

@implementation ShenHeTixianViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"提现";
    [self creatLeftTtem];
    [self creatUI];
}

-(void)creatUI
{
    
  UILabel *  moneyLaber = [[UILabel alloc]init];
    moneyLaber.frame = CGRectMake(10, 20,wScreenW-20, 20);
    moneyLaber.textColor = wBlackColor;
    moneyLaber.text = @"提现金额(最低600元)";
    moneyLaber.font = zhongFont;
    [self.view addSubview:moneyLaber];
    
   
    
    
    moneyText = [[UITextField alloc] init];
    moneyText.frame = CGRectMake(10, CGRectGetMaxY(moneyLaber.frame)+2, wScreenW - 20 , 40);
    moneyText.borderStyle = UITextBorderStyleNone;
    moneyText.placeholder =[NSString stringWithFormat:@"￥最多提现%.2f",[_money floatValue]];
    [moneyText addTarget:self action:@selector(qian:) forControlEvents:UIControlEventEditingChanged];
    moneyText.clearButtonMode = UITextFieldViewModeWhileEditing;
 
    [self.view addSubview:moneyText];

  
    UIView*  lineView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(moneyText.frame), wScreenW - 20, 1)];
    lineView.backgroundColor = QIANZITIcolor;
    [self.view addSubview:lineView];
 
  UILabel *  bankLaber = [[UILabel alloc]init];
    bankLaber.frame = CGRectMake(10, CGRectGetMaxY(lineView.frame)+10, 150, CGRectGetHeight(moneyLaber.frame));
    bankLaber.font = zhongFont;
    bankLaber.text = @"银行账号";
    bankLaber.textColor = wBlackColor;
    [self.view addSubview:bankLaber];
 
    
    UIButton * ocrbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ocrbtn.frame = CGRectMake(wScreenW-100-10,CGRectGetMaxY(lineView.frame) ,100,CGRectGetHeight(moneyLaber.frame)+10);
    
    [ocrbtn setTitle:@"扫描银行卡" forState:UIControlStateNormal];
    ocrbtn.titleLabel.font = zhongFont;
    
    [ocrbtn setTitleColor:wBlackColor forState:UIControlStateNormal];
    [ocrbtn addTarget:self action:@selector(kahao:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ocrbtn];
    
    
    bankNum = [[UITextField alloc]init];
    bankNum.frame = CGRectMake(10, CGRectGetMaxY(bankLaber.frame)+2, wScreenW-20-wScreenW/3 , 40);
    bankNum.borderStyle = UITextBorderStyleNone;
    bankNum.placeholder = @"请输入银行账号";
    
    [bankNum addTarget:self action:@selector(zhanghao:) forControlEvents:UIControlEventEditingChanged];
    bankNum.clearButtonMode = UITextFieldViewModeWhileEditing;
    bankNum.keyboardType = UIKeyboardTypeNumberPad;
    bankNum.font = zhongFont;
    
    [self.view addSubview:bankNum];
    
     yinhang = [[UILabel alloc]init];
    yinhang.frame = CGRectMake(CGRectGetMaxX(bankNum.frame), CGRectGetMaxY(bankLaber.frame)+2, wScreenW/3, 40);
    yinhang.font = zhongFont;
    yinhang.textColor = QIANZITIcolor;
    [self.view addSubview:yinhang];
    
    
 
 UIView * lineView1 = [[UIView alloc]init];
    lineView1.frame = CGRectMake(10, CGRectGetMaxY(bankNum.frame), wScreenW-20, 1);
    lineView1.backgroundColor = QIANZITIcolor;
    [self.view addSubview:lineView1];
   
  UILabel *  nameLaber = [[UILabel alloc]init];
    nameLaber.frame = CGRectMake(10, CGRectGetMaxY(lineView1.frame)+ 10, wScreenW * 0.7,  CGRectGetHeight(moneyLaber.frame));
    nameLaber.textColor = wBlackColor;
    nameLaber.text = @"开户行姓名(认证不可修改)";
    nameLaber.font = zhongFont;
    [self.view addSubview:nameLaber];

    nameText = [[UITextField alloc]init];
    nameText.frame = CGRectMake(10, CGRectGetMaxY(nameLaber.frame)+2, CGRectGetWidth(bankNum.frame), CGRectGetHeight(bankNum.frame));
    nameText.borderStyle = UITextBorderStyleNone;
    nameText.text = XINGMING;
    nameText.enabled = NO;
    nameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameText.font = zhongFont;
    nameText.textColor = QIANZITIcolor;
    [self.view addSubview:nameText];

  UIView * lineView2 = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(nameText.frame), CGRectGetWidth(lineView1.frame), 1)];
    lineView2.backgroundColor = QIANZITIcolor;
    [self.view addSubview:lineView2];
  
 UIButton * tixianBut = [UIButton buttonWithType:UIButtonTypeCustom];
    tixianBut.frame = CGRectMake(30, CGRectGetMaxY(lineView2.frame)+20, wScreenW-60, 36);
    [tixianBut setTitle:@"确定提现" forState:(UIControlStateNormal)];
    tixianBut.backgroundColor = SHENLANSEcolor;
    
    [tixianBut setTintColor:[UIColor whiteColor]];
    tixianBut.layer.masksToBounds = YES;
    tixianBut.layer.cornerRadius = 18.0;
    [tixianBut addTarget:self action:@selector(tixianAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view  addSubview:tixianBut];

  UILabel *  zhuyiLaber = [[UILabel alloc]init];
    zhuyiLaber.frame = CGRectMake(20, CGRectGetMaxY(tixianBut.frame)+20, wScreenW-40 - 30,  CGRectGetHeight(moneyLaber.frame));
    zhuyiLaber.textColor = QIANZITIcolor;
    zhuyiLaber.font = xiaoFont;
    zhuyiLaber.text = @"注:提现需要提供全额发票提现额度会暂扣";
    zhuyiLaber.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:zhuyiLaber];
    
  UILabel *  fenLaber = [[UILabel alloc]init];
    fenLaber.frame = CGRectMake(CGRectGetMaxX(zhuyiLaber.frame), CGRectGetMinY(zhuyiLaber.frame), 30,  CGRectGetHeight(moneyLaber.frame));
    fenLaber.textColor = [UIColor redColor];
    fenLaber.text = @"20%";
    fenLaber.textAlignment = NSTextAlignmentLeft;
    fenLaber.font = xiaoFont;
    [self.view addSubview:fenLaber];
    
}

-(void)kahao:(UIButton*)btn
{
    UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"填写身份证还是照相识别？" delegate:self cancelButtonTitle:@"填写" otherButtonTitles:@"照相识别", nil];
    view.tag = 998;
    
    [view show];
    
}
#pragma mark====弹出框代理方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{   
        if (buttonIndex==1)
        {
           
            UIViewController * vc = [AipCaptureCardVC ViewControllerWithCardType:CardTypeBankCard andDelegate:self];
            [self presentViewController:vc animated:YES completion:nil];
            
        }else
        {
             [bankNum becomeFirstResponder];
             [self dismissViewControllerAnimated:YES completion:nil];
        }
        
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
        
        bankNum.text =result[@"result"][@"bank_card_number"];
        yinhang.text = result[@"result"][@"bank_name"];
        
    }];
}




-(void)qian:(UITextField*)tf
{
    
    if (tf.text.length>9)
    {
        [WBYRequest showMessage:@"钱输入的太多了"];
        tf.text = [tf.text substringToIndex:9];
        
    }
 }

- (NSString *)returnBankName:(NSString*) idCard
{
    
    if(idCard==nil || idCard.length<16 || idCard.length>19){
        
        [WBYRequest showMessage: @"卡号不合法"];
        return @"";
        
    }
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"bank" ofType:@"plist"];
    NSDictionary* resultDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSArray *bankBin = resultDic.allKeys;
    
    //6位Bin号
    NSString* cardbin_6 = [idCard substringWithRange:NSMakeRange(0, 6)];
    //8位Bin号
    NSString* cardbin_8 = [idCard substringWithRange:NSMakeRange(0, 8)];
    
    if ([bankBin containsObject:cardbin_6])
    {
        [WBYRequest showMessage:[resultDic objectForKey:cardbin_6]];
        
        return [resultDic objectForKey:cardbin_6];
    }else if ([bankBin containsObject:cardbin_8]){
        return [resultDic objectForKey:cardbin_8];
    }else{
        [WBYRequest showMessage:@"该文件中不存在请自行添加对应卡种"];
        return @"";
    }
    return @"";
    
}

-(void)zhanghao:(UITextField *)tf
{
    CGFloat maxLength = 19;
    NSString *toBeString = tf.text;
    
    //获取高亮部分
    UITextRange *selectedRange = [tf markedTextRange];
    UITextPosition *position = [tf positionFromPosition:selectedRange.start offset:0];
    if (!position || !selectedRange)
    {
        if (toBeString.length > maxLength)
        {
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

    
    
    if (tf.text.length>=16)
    {
        if ([WBYRequest IsBankCard:tf.text])
        {
            NSString * str =[self returnBankName:tf.text];
            yinhang.text = str;
            
        }else
        {
            yinhang.text = @"";
            
        }
  }
    
}

-(void)tixianAction
{
    WS(weakSelf);

    
    NSString *numStr = [bankNum.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([moneyText.text floatValue]>=600)
    {
        
        if ([moneyText.text floatValue]<=[_money floatValue])
        {
                    if ([WBYRequest IsBankCard:numStr])
                    {
                    
                        NSString * str =[self returnBankName:numStr];
            
                    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
            
                        [dic setObject:UID forKey:@"uid"];
            
                        [dic setObject:moneyText.text forKey:@"money"];
                        [dic setObject:numStr forKey:@"card_num"];
            
                        [dic setObject:nameText.text forKey:@"name"];
                        [dic setObject:str?str:@"" forKey:@"bank"];
            
                        [WBYRequest wbyLoginPostRequestDataUrl:@"extract_cash" addParameters:dic success:^(WBYReqModel *model)
                         {
                             if ([model.err isEqualToString:TURE])
                             {
                                 [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                             }else
                             {
            
                                 [WBYRequest showMessage:model.info];
                             }
                             
                         } failure:^(NSError *error) {
                        
                             
                         }];
                     }else
                    {
                        
                        [WBYRequest showMessage:@"请输入合法的银行卡号"];
                    }
            }else
        {
            [WBYRequest showMessage:[NSString stringWithFormat:@"提款额要小于%@",_money]];
        }
        
    }else
    {
        
        [WBYRequest showMessage:@"提款要大于600"];
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
