//
//  ShangchengViewController.m
//  Created by apple on 17/5/11.
//  Copyright © 2017年 apple. All rights reserved.

#import "ShangchengViewController.h"
#import "MyTabbarviewconstrerViewController.h"
#import "LoginViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <Picidae.h>
#import "YshangchengViewController.h"
#import "TiaozhuanViewController.h"
#import "DailirenzhengxinxiViewController.h"
#import "XianZhongXiangQingDetileViewController.h"


@interface ShangchengViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) JSContext *context;
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) PICBridge * bridge;

@end

@implementation ShangchengViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = wBlue;
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,20, wScreenW,wScreenH-49-20)];
    self.webView.delegate = self;
    self.webView.scrollView.bounces = NO;
    [self.view addSubview:self.webView];
    
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(captureJSContext) name:@"DidCreateContextNotification" object:nil];
}

-(void)captureJSContext
{
    self.context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.bridge =[[PICBridge alloc] init];
    __weak typeof(self) weakSelf = self;
  
    [self.bridge addActionHandler:@"Login" forCallBack:^(NSDictionary *params, void (^errorCallBack)(NSError *error), void (^successCallBack)(NSDictionary *responseDict))
     {
         NSString * str = KEY;
         NSString * strqq = UID;
         
         weakSelf.denglumyDic = params;
         NSLog(@"===%@===%@",str,strqq);
         if (str.length<5&&strqq.length<1)
         {
             
             weakSelf.successCallBack = successCallBack;
             weakSelf.errorCallBack = errorCallBack;
             
             UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否去登陆?" delegate:weakSelf cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                  view.tag = 888;
                     [view show];
             
         }else
         {
             
             
             [weakSelf creatrequestData:params];
        }
          
         
    }];
    
    
    
    [self.bridge addActionHandler:@"Skip" forCallBack:^(NSDictionary *params, void (^errorCallBack)(NSError *error), void (^successCallBack)(NSDictionary *responseDict))
     {
        
         XianZhongXiangQingDetileViewController * xianzhong = [XianZhongXiangQingDetileViewController new];
         
         xianzhong.myDic = params;
         
         [weakSelf.navigationController pushViewController:xianzhong animated:YES];
     }];

    
    
    
    self.context[@"bridge"] = self.bridge;
    [self.context setExceptionHandler:^(JSContext * context, JSValue * value)
    {
        
        NSLog(@"%@",[value toObject]);
    }];
}

-(void)creatrequestData:(NSDictionary*)params
{
    
    WS(weakSelf);

    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [WBYRequest wbyLoginPostRequestDataUrl:@"get_user" addParameters:dic success:^(WBYReqModel *model)
     {
         if ([model.err isEqualToString:TURE])
         {
             
             DataModel * user = [model.data firstObject];
             NSUserDefaults * stand = [NSUserDefaults standardUserDefaults];
             [stand setObject:user.status forKey:@"renzhengzhuangtai"];
             [stand setObject:user.type forKey:@"type"];
             [stand synchronize];
             
             NSString * astr = [params objectForKey:@"id"];
             
             if (![user.type isEqualToString:@"0"]&&[user.status isEqualToString:@"1"])
             {
                 TiaozhuanViewController * tiaozhuan = [TiaozhuanViewController new];
                 tiaozhuan.myDic = params;
                 
                 [weakSelf.navigationController pushViewController:tiaozhuan animated:YES];
                 
             }else
             {
                 if ([astr isEqualToString:@"car"])
                 {
                    UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"代理人未认证,请认证" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                             [view show];
                 }else
                 {
                     TiaozhuanViewController * tiaozhuan = [TiaozhuanViewController new];
                     tiaozhuan.myDic = params;
                     
                     [weakSelf.navigationController pushViewController:tiaozhuan animated:YES];
                     
                 }
             }
         }
         
         
         if ([model.err isEqualToString:SAME])
         {
             
             [WBYRequest showMessage:model.info];

             [self goLogin];
         }         
         
     } failure:^(NSError *error) {
         
     }];
 
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if (alertView.tag==888)
    {
        if (buttonIndex==1)
        {
            LoginViewController * login = [LoginViewController new];
            login.successCallBack = _successCallBack;
            login.errorCallBack = _errorCallBack;
            login.isTabBar = NO;
            login.myStr = @"shouye";
            login.myDic = _denglumyDic;
            
            [self.navigationController pushViewController:login animated:YES];
        }
        
    }else
    {
        if (buttonIndex==1)
        {
            
            [self dailirenzhengrequest];
        }
   
        
    }
    
    
}

-(void)dailirenzhengrequest
{
    
    WS(weakSelf);
    //    if (KEY&&UID)
    //    {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [WBYRequest wbyLoginPostRequestDataUrl:@"get_verify" addParameters:dic success:^(WBYReqModel *model)
     {
         if ([model.err isEqualToString:TURE])
         {
            
             DataModel * mod = [model.data firstObject];
             DailirenzhengxinxiViewController * daili = [DailirenzhengxinxiViewController new];
             daili.aModel = mod;
             [weakSelf.navigationController pushViewController:daili animated:YES];
             
         }
         
         if ([model.err isEqualToString:SAME])
         {
             UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要去登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
             
             [view show];
         }
         
     } failure:^(NSError *error) {
         
     }];
   }




-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
//    NSString *currentURL = [_webView stringByEvaluatingJavaScriptFromString:@"window.location.href"];
//    NSLog(@"=====%@",currentURL);
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
//    NSString *currentURL = [_webView stringByEvaluatingJavaScriptFromString:@"window.location.href"];
//    
//    NSLog(@"=====kaishi%@",currentURL);
 
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    NSString * str = @"http://cloud.kuaibao365.com/";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?is_app=%@&uid=%@&key=%@&upper=1",str,@"1",UID?UID:@"",KEY?KEY:@""]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(captureJSContext) name:@"DidCreateContextNotification" object:nil];
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"DidCreateContextNotification" object:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

@implementation NSObject (pic_uiwebViewDelegator)

- (void)webView:(id)unuse didCreateJavaScriptContext:(JSContext *)ctx forFrame:(id)frame
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DidCreateContextNotification" object:ctx];
}
@end





