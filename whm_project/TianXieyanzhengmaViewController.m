

//
//  TianXieyanzhengmaViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TianXieyanzhengmaViewController.h"
#import "MyTabbarviewconstrerViewController.h"
#import "TiaozhuanViewController.h"


@interface TianXieyanzhengmaViewController ()<UITextFieldDelegate>
{
    UIImageView*img;
    UIImageView * aaImg;
    
}
@property(nonatomic,strong)NSTimer * timer;
@property(nonatomic,strong)NSTimer * yitimer;

@property(nonatomic,assign)NSInteger sec;

@end

@implementation TianXieyanzhengmaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHiden:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    
   
    [self shiqudiyixiangying];
    [self creatView];
 
    
}


-(void)shouci
{
    UIButton*myBtn=[self.view viewWithTag:5566];
    self.sec--;
    if (self.sec > 0)
    {
        myBtn.enabled = NO;
        
        [myBtn setTitle:[NSString stringWithFormat:@"%ld秒后重发",(long)self.sec] forState:UIControlStateDisabled];
        
    }
    else
    {
        self.yitimer.fireDate = [NSDate distantFuture];
        myBtn.enabled = YES;
        if (self.yitimer.isValid)
        {
            self.yitimer = nil;
        }
        self.sec = 60;
        [myBtn setTitle:@"重新发送验证码" forState:(UIControlStateDisabled)];
        [myBtn setTitle:@"重新发送验证码" forState:UIControlStateNormal];
    }
  
    
    
}

#pragma mark---输入框代理方法
//键盘将要展示的时候 -- 视图上移
- (void)keyBoardShow:(NSNotification*)noti
{
    
    WS(weakSelf);
    [UIView animateWithDuration:0.23 animations:^{
        
        UIButton * mybtn=[weakSelf.view viewWithTag:1313];
        
        CGRect endF = [[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
        CGFloat h = wScreenH-CGRectGetMaxY(mybtn.frame)-20;
        CGFloat sub = -endF.size.height+h;
        if (sub >= 0)
        {
            sub = 0;
        }
        self.view.frame = CGRectMake (0,sub,wScreenW,wScreenH-20);
    }];
}
-(void)keyBoardHiden:(NSNotification*)noti
{
    [UIView animateWithDuration:0.23 animations:^{
        self.view.frame = CGRectMake (0,0,wScreenW, wScreenH-20);
    }];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)creatView
{
    UIView * myView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, wScreenW, 44)];
    
    [self.view addSubview:myView];
    
    UIButton*renImg=[UIButton buttonWithType:UIButtonTypeCustom];
    renImg.frame =CGRectMake(10,12,20,20);
   [renImg setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e62a", 18, QIANZITIcolor)] forState:0];
    
    [renImg addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    
    [myView addSubview:renImg];
    
    UILabel * aLab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW/2-60, 0, 120,44)];
    aLab.textAlignment = 1;
    aLab.font = Font(20);
    aLab.text = @"填写验证码";
    aLab.textColor = SHENZITIcolor;
    [myView addSubview:aLab];
    
    
    CGFloat hh = ((wScreenH-64)/2-100)/2;
    
    img=[[UIImageView alloc] initWithFrame:CGRectMake((wScreenW-120)/2,CGRectGetMaxY(myView.frame)+60, 100, 100)];
//    img.image=[UIImage imageNamed:@"logooo"];
    
    
    [img sd_setImageWithURL:[NSURL URLWithString:TOUXIANG?TOUXIANG:@""] placeholderImage:[UIImage imageNamed:@"logooo"]];
    img.userInteractionEnabled = YES;
    img.layer.masksToBounds = YES;
    img.layer.cornerRadius = 50;
    img.backgroundColor = RGBwithColor(248, 248, 248);
    img.center = CGPointMake(self.view.center.x,hh+50);
    [self.view addSubview:img];
    
    [img makeDraggable];
    
    UILabel * dianhuaLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(img.frame)+30, wScreenW,20)];
    dianhuaLab.textAlignment = 1;
    dianhuaLab.font = Font(26);
    dianhuaLab.text = _phone;
    dianhuaLab.textColor = SHENZITIcolor;
    [self.view addSubview:dianhuaLab];
  
    UILabel * yanzhenghuaLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(dianhuaLab.frame)+10, wScreenW,15)];
    yanzhenghuaLab.textAlignment = 1;
    yanzhenghuaLab.font = Font(16);
    yanzhenghuaLab.text = @"已发送验证码到该号码";
    yanzhenghuaLab.textColor = SHENZITIcolor;
    [self.view addSubview:yanzhenghuaLab];

        UITextField*tf=[[UITextField alloc] initWithFrame:CGRectMake(wScreenW/2-90,CGRectGetMaxY(yanzhenghuaLab.frame)+20,180,45)];
        tf.tag=1330;
        tf.delegate=self;
    
    tf.layer.masksToBounds = YES;
    tf.layer.cornerRadius = 45/2;
    tf.backgroundColor = RGBwithColor(244, 244, 244);
    tf.textAlignment = 1;
    tf.font = Font(23);
        tf.placeholder=@"请输入验证码";
        tf.keyboardType=UIKeyboardTypeNumberPad;
        tf.clearButtonMode  = UITextFieldViewModeWhileEditing;
    
    [tf addTarget:self action:@selector(jianting:) forControlEvents:UIControlEventEditingChanged];
        [self.view addSubview:tf];

    
   
    self.sec = 60;

    UIButton * myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    myBtn.frame = CGRectMake(0, CGRectGetMaxY(tf.frame)+30,wScreenW, 30);
    [myBtn addTarget:self action:@selector(huoquyanzhng:) forControlEvents:UIControlEventTouchUpInside];
    
    [myBtn setTitleColor:SHENLANSEcolor forState:0];
    [myBtn setTitleColor:QIANZITIcolor forState:UIControlStateDisabled];

    myBtn.enabled = NO;
 [myBtn setTitle:[NSString stringWithFormat:@"%ld秒后重发",self.sec] forState:UIControlStateDisabled];
    myBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    myBtn.layer.masksToBounds = YES;
    myBtn.tag = 5566;
    myBtn.layer.cornerRadius = 30/2;
    
    [self.view addSubview:myBtn];
 
    self.yitimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(shouci) userInfo:nil repeats:YES];
    self.sec=60;
    
        UIButton*btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(30, CGRectGetMaxY(myBtn.frame)+20, wScreenW-60,40);
        [btn setTitle:@"确定" forState:UIControlStateNormal];
    
        btn.tag=1313;
        [btn setBackgroundColor:RGBwithColor(244, 244, 244)];
    
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 40/2;
        [btn setTitleColor:TIDAIZITIcolor forState:UIControlStateNormal];
        btn.enabled=NO;
        btn.titleLabel.font=[UIFont systemFontOfSize:17 weight:16];
        [btn addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
}


-(void)queding
{
    
//    [self request:str];
    UITextField * myTf = [self.view viewWithTag:1330];
    
    if (myTf.text.length==4)
    {
        [self request:myTf.text];
    }
    
    
    
    
}


-(void)jianting:(UITextField*)tf
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
    
    UIButton * btn = [self.view viewWithTag:1313];
    if (tf.text.length==4)
    {
        
        [self.view endEditing:YES];
        btn.enabled=YES;
        [btn setBackgroundColor:SHENLANSEcolor];
        [btn setTitleColor:wWhiteColor forState:UIControlStateNormal];
        
    }else
    {
        [btn setBackgroundColor:RGBwithColor(244, 244, 244)];
        [btn setTitleColor:TIDAIZITIcolor forState:UIControlStateNormal];
        btn.enabled=NO;
        
    }
    
}


-(void)fanhui
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)huoquyanzhng:(UIButton*)btn
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeButton) userInfo:nil repeats:YES];
    
    self.sec = 60;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    UITextField * myTf = [self.view viewWithTag:1330];

    [myTf becomeFirstResponder];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
//        UIButton*myBtn=[self.view viewWithTag:5566];
//    [myBtn setTitle:@"60s" forState:UIControlStateNormal];
//    myBtn.enabled = YES;

    
    
}

-(void)changeButton
{
    UIButton*myBtn=[self.view viewWithTag:5566];
    self.sec--;
    if (self.sec > 0)
    {
        myBtn.enabled = NO;
        
          [myBtn setTitle:[NSString stringWithFormat:@"%ld秒后重发",self.sec] forState:UIControlStateDisabled];

    }
    else
    {
        self.timer.fireDate = [NSDate distantFuture];
        myBtn.enabled = YES;
        
        if (self.timer.isValid)
        {
            self.timer = nil;
        }
        self.sec = 60;
        [myBtn setTitle:@"重新发送验证码" forState:(UIControlStateDisabled)];
        [myBtn setTitle:@"重新发送验证码" forState:UIControlStateNormal];
    }
}

-(void)request:(NSString * )str
{
    WS(weakSelf);
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:_phone forKey:@"mobile"];
    
    [dic setObject:str forKey:@"captcha"];

    [WBYRequest wbyPostRequestDataUrl:@"sign" addParameters:dic success:^(WBYReqModel *model)
     {
         if ([model.err isEqualToString:TURE])
         {
             
             DataModel * user = [model.data firstObject];
             NSUserDefaults * stand = [NSUserDefaults standardUserDefaults];
             [stand setObject:user.name forKey:@"xingming"];
             [stand setObject:user.company_name?user.company_name:@"" forKey:@"gongsi"];
             [stand setObject:user.key forKey:@"key"];
             [stand setObject:user.uid forKey:@"uid"];
             [stand setObject:user.type forKey:@"type"];
             [stand setObject:user.city?user.city:@"" forKey:@"cityid"];
             [stand setObject:user.status forKey:@"renzhengzhuangtai"];
             [stand setObject:user.status_name forKey:@"renzhengmingzi"];
             
             [stand setObject:user.avatar?user.avatar:@"" forKey:@"touxiang"];
             [stand setObject:user.rec_uid?user.rec_uid:@"" forKey:@"tuijianren"];
             [stand setObject:user.rec_name?user.rec_name:@"" forKey:@"tuijianrenmingzi"];
             [stand setObject:user.rec_mobile?user.rec_mobile:@"" forKey:@"tuijianrendianhua"];
             [stand synchronize];
             
             if ([weakSelf.myStr isEqualToString:@"666"])
             {
                weakSelf.myBlock(@{@"uid":user.uid?user.uid:@"",@"key":user.key?user.key:@""},nil);

                 TiaozhuanViewController * tiaozhuan = [TiaozhuanViewController new];
                 tiaozhuan.myDic = weakSelf.amyDic;
                 
                 [weakSelf.navigationController pushViewController:tiaozhuan animated:YES];
                 
//                [self.navigationController popToRootViewControllerAnimated:YES];
                 
             }else if ([weakSelf.myStr isEqualToString:@"shouye"])
             {
                 
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                 
             }else
             {
                 if (weakSelf.isTabBar==YES)
                 {
                     MyTabbarviewconstrerViewController*view=[[MyTabbarviewconstrerViewController alloc] init];
                     view.dijici = 888;
                     [[UIApplication sharedApplication].delegate window].rootViewController = view;
                     
                 }else
                 {
                     
                     [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                 }
             }
         }else
         {
             [WBYRequest showMessage:model.info];
         }
         NSLog(@"%@",model.err);
         
     } failure:^(NSError *error)
     {
         
     } isRefresh:NO];

}



-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    
    UIButton*myBtn=[self.view viewWithTag:5566];
    myBtn.enabled = YES;

    self.timer.fireDate = [NSDate distantFuture];
    if (self.timer.isValid)
    {
        self.timer = nil;
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
