//
//  LoginViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "LoginViewController.h"
#import "TianXieyanzhengmaViewController.h"
#import "MyTabbarviewconstrerViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    UIImageView*img;
    UIImageView * aaImg;
    
}
@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHiden:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [self shiqudiyixiangying];
    [self creatView];
    
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

    
    UILabel * aLab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW/2-30, 0, 60,44)];
    aLab.textAlignment = 1;
    aLab.font = Font(20);
    aLab.text = @"登录";
    aLab.textColor = SHENZITIcolor;
    [myView addSubview:aLab];
    
    
    CGFloat hh = ((wScreenH-64)/2-100)/2;
    
    img=[[UIImageView alloc] initWithFrame:CGRectMake((wScreenW-120)/2,CGRectGetMaxY(myView.frame)+60, 100, 100)];
    img.userInteractionEnabled = YES;
    img.layer.masksToBounds = YES;
    img.layer.cornerRadius = 50;
    img.backgroundColor = RGBwithColor(248, 248, 248);
    img.center = CGPointMake(self.view.center.x,hh+50);
    [self.view addSubview:img];

    //[img makeDraggable];
    
    
    UIView*upView=[[UIView alloc] initWithFrame:CGRectMake(30, wScreenH/2, wScreenW-60, 40)];
    upView.layer.borderColor = QIANZITIcolor.CGColor;
    upView.layer.borderWidth = 0.6;
    upView.layer.masksToBounds = YES;
    upView.tag = 10086;
    upView.layer.cornerRadius = 40/2;
    upView.backgroundColor = RGBwithColor(244, 244, 244);
    [self.view addSubview:upView];
    
    aaImg = [[UIImageView alloc] initWithFrame:CGRectMake(10,10,20,20)];
    
    aaImg.image=[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e62b", 20, QIANZITIcolor)];
    
    [upView addSubview:aaImg];
    
    
    NSString * place = ZHEGEDIANHUA;
    
    UITextField*tf=[[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(renImg.frame)+5,0,wScreenW-40-20-10-10-30,40)];
    tf.tag=1330;
    tf.delegate=self;
    tf.backgroundColor = RGBwithColor(244, 244, 244);
    
    
    
    tf.keyboardType=UIKeyboardTypeNumberPad;
    tf.clearButtonMode  = UITextFieldViewModeWhileEditing;

    [tf addTarget:self action:@selector(jianting:) forControlEvents:UIControlEventEditingChanged];
    [tf setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    [upView addSubview:tf];
   
    UIButton*btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(30, CGRectGetMaxY(upView.frame)+40, wScreenW-60,40);
    [btn setTitle:@"立即获取验证码" forState:UIControlStateNormal];
    
    btn.tag=1313;
    [btn setBackgroundColor:RGBwithColor(244, 244, 244)];
    
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 40/2;
    
    if ([WBYRequest isMobileNumber:place])
    {
        tf.placeholder=ZHEGEDIANHUA;
        btn.enabled=YES;
        [btn setBackgroundColor:SHENLANSEcolor];
        [btn setTitleColor:wWhiteColor forState:UIControlStateNormal];
        
//        aaImg.image=[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e62b", 20, QIANLANSEcolor)];
        
 [img sd_setImageWithURL:[NSURL URLWithString:TOUXIANG] placeholderImage:[UIImage imageNamed:@"gongsilo"]];
        
    }else
    {
        tf.placeholder=@"请输入手机号";
        [btn setTitleColor:TIDAIZITIcolor forState:UIControlStateNormal];
        btn.enabled=NO;
        img.image=[UIImage imageNamed:@"gongsilo"];
    }
    
    btn.titleLabel.font=[UIFont systemFontOfSize:17 weight:16];
    [btn addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

-(void)queding
{
    UITextField * tf = [self.view viewWithTag:1330];
    
    if (tf.text.length<2)
    {
        tf.text = tf.placeholder;
    }
    
    if ([WBYRequest isMobileNumber:tf.text])
    {
        [self requestData:tf.text];
    }
}

-(void)jianting:(UITextField*)tf
{
    
    CGFloat maxLength = 11;
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
    UIView * view = [self.view viewWithTag:10086];
    
    
    if (tf.text.length>=1)
    {
        
        view.layer.borderColor = QIANLANSEcolor.CGColor;
        
//        view.layer.shadowColor = QIANLANSEcolor.CGColor;//shadowColor阴影颜色
//        view.layer.shadowOffset = CGSizeMake(6,6);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
//        view.layer.shadowOpacity = 0.5;//阴影透明度，默认0
//        view.layer.shadowRadius = 4;//阴影半径，默认3
        
        
   aaImg.image=[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e62b", 20, QIANLANSEcolor)];
    }else
    {
        view.layer.borderColor = QIANZITIcolor.CGColor;
      aaImg.image=[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e62b", 20, QIANZITIcolor)];
    }
    
    if ([WBYRequest isMobileNumber:tf.text])
    {
        btn.enabled=YES;

        [btn setBackgroundColor:SHENLANSEcolor];
        [btn setTitleColor:wWhiteColor forState:UIControlStateNormal];
        
        [self requestouxiang:tf.text];
        
    }else
    {
        [btn setBackgroundColor:RGBwithColor(244, 244, 244)];
        [btn setTitleColor:TIDAIZITIcolor forState:UIControlStateNormal];

        if (tf.text.length>=11)
        {
            [WBYRequest showMessage:@"请输入正确的电话号码"];
        }
    }
}

-(void)requestouxiang:(NSString *)str
{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:str forKey:@"mobile"];
    
    [WBYRequest wbyPostRequestDataUrl:@"get_avatar" addParameters:dic success:^(WBYReqModel *model)
     {
         if ([model.err isEqualToString:TURE])
         {
             DataModel * data = [model.data firstObject];
             [img sd_setImageWithURL:[NSURL URLWithString:data.avatar] placeholderImage:[UIImage imageNamed:@"logooo"]];
             NSUserDefaults * stand = [NSUserDefaults standardUserDefaults]; 
             [stand setObject:data.avatar forKey:@"touxiang"];
             [stand synchronize];
             
         }
         
     } failure:^(NSError *error)
     {
         
     } isRefresh:NO];

}

-(void)requestData:(NSString *)str
{
    WS(weakSelf);
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:str forKey:@"mobile"];
    
    [WBYRequest wbyPostRequestDataUrl:@"sms" addParameters:dic success:^(WBYReqModel *model)
    {
        if ([model.err isEqualToString:TURE])
        {
            TianXieyanzhengmaViewController * tianxie = [TianXieyanzhengmaViewController new];
            tianxie.phone = str;
            
            tianxie.isTabBar = weakSelf.isTabBar;
            
            tianxie.myStr = weakSelf.myStr;
            
            tianxie.amyDic = weakSelf.myDic;

            
            if ([weakSelf.myStr isEqualToString:@"666"])
            {
                tianxie.myBlock = ^(NSDictionary * aDic,NSError*str)
                {
                    self.successCallBack(aDic);
                    self.successCallBack(nil);
                    
                };
            }
            
            if ([weakSelf.myStr isEqualToString:@"shouye"])
            {
                tianxie.myBlock = ^(NSDictionary * aDic,NSError*str)
                {
                    self.successCallBack(aDic);
                    self.successCallBack(nil);
                    
                };
            }
 
            
            
            
            
            [weakSelf.navigationController pushViewController:tianxie animated:YES];
            
            [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"zhegedianhua"];
            [[NSUserDefaults standardUserDefaults] synchronize];

        }else
        {
            [WBYRequest showMessage:model.info];
        }
        
    } failure:^(NSError *error)
    {
        
    } isRefresh:NO];
 }




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
//    TianXieyanzhengmaViewController * tianxie = [TianXieyanzhengmaViewController new];
//        self.successCallBack(@{@"phone": @"430"});
//        self.successCallBack(nil);
//    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [img removeDraggable];
}

-(void)fanhui
{
    
//    if ([_myStr isEqualToString:@"666"])
//    {
        [self.navigationController popViewControllerAnimated:YES];
        
//    }else
//    {
//        MyTabbarviewconstrerViewController * mytab = [MyTabbarviewconstrerViewController new];
//        mytab.dijici = 888;
//        [[UIApplication sharedApplication].delegate window].rootViewController =  mytab;
//    }
    
    
    
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
