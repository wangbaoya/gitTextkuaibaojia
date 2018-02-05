//
//  TixianjiemianViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TixianjiemianViewController.h"

@interface TixianjiemianViewController ()

@end

@implementation TixianjiemianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"提现";

    [self creatLeftTtem];
    [self creatUI];
}

-(void)creatUI
{
    
    UILabel * shenLaber = [[UILabel alloc]init];
    shenLaber.frame = CGRectMake(wScreenW/2-45, 20, 90, 90);
    shenLaber.textAlignment = NSTextAlignmentCenter;
    shenLaber.font = Font(15);
    shenLaber.layer.masksToBounds = YES;
    shenLaber.layer.cornerRadius = 45;
    shenLaber.layer.borderWidth = 1;
    
    [self.view addSubview:shenLaber];

    
    if ([_aModel.status isEqualToString:@"1"])
    {
            shenLaber.text = @"已汇款";
            shenLaber.textColor = Wqingse;
        shenLaber.layer.borderColor = Wqingse.CGColor;
    }else if ([_aModel.status isEqualToString:@"2"])
    {
        shenLaber.text = @"审核中";
        shenLaber.textColor = RGBwithColor(255, 186, 0);
        shenLaber.layer.borderColor = RGBwithColor(255, 186, 0).CGColor;
    }else
    {
        shenLaber.text = @"已汇款80%";
        shenLaber.textColor = Wqingse;
        shenLaber.layer.borderColor = Wqingse.CGColor;

    }
    
    UILabel *  moneyLaber = [[UILabel alloc]init];
    moneyLaber.frame = CGRectMake(10, CGRectGetMaxY(shenLaber.frame)+10,wScreenW-20, 20);
    moneyLaber.textColor = QIANZITIcolor;
    moneyLaber.text = @"提现金额(最低600元)";
    moneyLaber.font = zhongFont;
    [self.view addSubview:moneyLaber];
    
    
    
    
  UITextField *  moneyText = [[UITextField alloc]init];
    moneyText.frame = CGRectMake(10, CGRectGetMaxY(moneyLaber.frame)+2, wScreenW - 20 , 40);
    moneyText.borderStyle = UITextBorderStyleNone;
   
    moneyText.enabled = NO;
    moneyText.text = _aModel.money;
    moneyText.textColor = wBlackColor;
    moneyText.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [self.view addSubview:moneyText];
 
    UIView*  lineView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(moneyText.frame), wScreenW - 20, 1)];
    lineView.backgroundColor = QIANZITIcolor;
    [self.view addSubview:lineView];
  
    
    UILabel *  bankLaber = [[UILabel alloc]init];
    bankLaber.frame = CGRectMake(10, CGRectGetMaxY(lineView.frame)+10, wScreenW -40, CGRectGetHeight(moneyLaber.frame));
    bankLaber.font = zhongFont;
    bankLaber.text = @"银行账号";
    bankLaber.textColor = QIANZITIcolor;
    [self.view addSubview:bankLaber];
  
    
   UITextField *  bankNum = [[UITextField alloc]init];
    bankNum.frame = CGRectMake(10, CGRectGetMaxY(bankLaber.frame)+2, wScreenW-40 , 40);
    bankNum.borderStyle = UITextBorderStyleNone;
    bankNum.enabled = NO;
    bankNum.text = _aModel.remark;
    bankNum.textColor = wBlackColor;
    bankNum.font = zhongFont;
    
    [self.view addSubview:bankNum];
 
    UIView * lineView1 = [[UIView alloc]init];
    lineView1.frame = CGRectMake(10, CGRectGetMaxY(bankNum.frame), wScreenW-20, 1);
    lineView1.backgroundColor = QIANZITIcolor;
    [self.view addSubview:lineView1];

    UILabel *  nameLaber = [[UILabel alloc]init];
    nameLaber.frame = CGRectMake(10, CGRectGetMaxY(lineView1.frame)+ 10, wScreenW * 0.7,  CGRectGetHeight(moneyLaber.frame));
    nameLaber.textColor = QIANZITIcolor;
    nameLaber.text = @"开户行姓名(认证不可修改)";
    nameLaber.font = zhongFont;
    [self.view addSubview:nameLaber];
    
    
  UITextField *  nameText = [[UITextField alloc]init];
    nameText.frame = CGRectMake(10, CGRectGetMaxY(nameLaber.frame)+2, CGRectGetWidth(bankNum.frame), CGRectGetHeight(bankNum.frame));
    nameText.borderStyle = UITextBorderStyleNone;
    nameText.text = XINGMING;
    nameText.enabled = NO;
//    nameText.font = Font(15);
    nameText.textColor = wBlackColor;
    [self.view addSubview:nameText];
 
    UIView * lineView2 = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(nameText.frame), CGRectGetWidth(lineView1.frame), 1)];
    lineView2.backgroundColor = QIANZITIcolor;
    [self.view addSubview:lineView2];
    
    UILabel *  shijianLaber = [[UILabel alloc]init];
    shijianLaber.frame = CGRectMake(10, CGRectGetMaxY(lineView2.frame)+ 10, wScreenW * 0.7,  CGRectGetHeight(moneyLaber.frame));
    shijianLaber.textColor = QIANZITIcolor;
    shijianLaber.text = @"提交时间";
    shijianLaber.font = zhongFont;
    [self.view addSubview:shijianLaber];
    
    UILabel *  timeLaber = [[UILabel alloc]init];
    timeLaber.frame = CGRectMake(10, CGRectGetMaxY(shijianLaber.frame), wScreenW * 0.7, CGRectGetHeight(bankNum.frame));
    timeLaber.textColor = wBlackColor;
    timeLaber.text = [WBYRequest timeStr:_aModel.create_time];
    timeLaber.font = zhongFont;
    [self.view addSubview:timeLaber];
    
    
    UIView * lineView3 = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(timeLaber.frame), CGRectGetWidth(lineView1.frame), 1)];
    lineView3.backgroundColor = QIANZITIcolor;
    [self.view addSubview:lineView3];
 
    
  UILabel *  zhuyiLaber = [[UILabel alloc]init];
    zhuyiLaber.frame = CGRectMake(50, CGRectGetMaxY(lineView3.frame)+20, wScreenW-100 , 10);
    zhuyiLaber.textColor = QIANZITIcolor;
    zhuyiLaber.font = xiaoFont;
    zhuyiLaber.text = @"注:提现需要提供全额发票";
    zhuyiLaber.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:zhuyiLaber];
    
 UILabel *   fenLaber = [[UILabel alloc]init];
    fenLaber.frame = CGRectMake(70, CGRectGetMaxY(zhuyiLaber.frame)+3, wScreenW - 140  , 10);
    fenLaber.textColor = QIANZITIcolor;
    fenLaber.text = @"提现额度会暂扣20%";
    fenLaber.textAlignment = NSTextAlignmentCenter;
    fenLaber.font = xiaoFont;
    [self.view addSubview:fenLaber];
    
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
