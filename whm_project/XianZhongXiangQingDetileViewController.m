//
//  XianZhongXiangQingDetileViewController.m
//  whm_project
//  Created by apple on 17/8/1.
//  Copyright © 2017年 chenJw. All rights reserved.


#import "XianZhongXiangQingDetileViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <Picidae.h>
#import "LoginViewController.h"
#import "TiaozhuanViewController.h"

@interface XianZhongXiangQingDetileViewController ()
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) JSContext *context;
@property (nonatomic,strong) PICBridge * bridge;
@end

@implementation XianZhongXiangQingDetileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = wBlue;
    UIView*view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 20)];
    view.backgroundColor = wBlue;
    
    [self.view addSubview:view];
    
    
    [self creatSecondWebview];
}

-(void)creatSecondWebview
{
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,20, wScreenW, wScreenH-20)];

    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.scrollView.bounces = NO;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_myDic[@"urls"]]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    
}

-(void)captureJSContext
{
    
    self.context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.bridge =[[PICBridge alloc]init];
    __weak typeof(self) weakSelf = self;
    
    
    [self.bridge addActionHandler:@"Goback" forCallBack:^(NSDictionary *params, void (^errorCallBack)(NSError *error), void (^successCallBack)(NSDictionary *responseDict))
     {
         NSLog(@"===%@",params);
         
//         if ( [weakSelf.myDic[@"id"] isEqualToString:@"car"])
//         {
//             
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
         
//         }else
//         {
//             ShangchengdetileViewController * shangcheng = [ShangchengdetileViewController new];
//             
//             shangcheng.myId = weakSelf.myDic[@"id"];
//             
//             [weakSelf.navigationController pushViewController:shangcheng animated:YES];
//             
//             
//         }
         
     }];
    
    [self.bridge addActionHandler:@"Login" forCallBack:^(NSDictionary *params, void (^errorCallBack)(NSError *error), void (^successCallBack)(NSDictionary *responseDict))
     {
         NSString * str = KEY;
         NSString * strqq = UID;
         NSLog(@"===%@===%@",str,strqq);
         
         weakSelf.denglumyDic = params;
         
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

     self.context[@"bridge"] = self.bridge;
    
    [self.context setExceptionHandler:^(JSContext * context, JSValue * value) {
        
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
             
             TiaozhuanViewController * tiaozhuan = [TiaozhuanViewController new];
             tiaozhuan.myDic = params;
             [weakSelf.navigationController pushViewController:tiaozhuan animated:YES];
          
             
         }
         if ([model.err isEqualToString:SAME])
         {
             
             [WBYRequest showMessage:model.info];
             
             [self.navigationController pushViewController:[LoginViewController new] animated:YES];
             

         }
         
     } failure:^(NSError *error) {
         
     }];
    
    
}







-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(captureJSContext) name:@"DidCreateContextNotification" object:nil];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    
      [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"DidCreateContextNotification" object:nil];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
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
            login.myStr = @"666";
           login.myDic = _denglumyDic;
            
            
            [self.navigationController pushViewController:login animated:YES];
        }
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
@implementation NSObject (pic_uiwebViewDelegator)

- (void)webView:(id)unuse didCreateJavaScriptContext:(JSContext *)ctx forFrame:(id)frame
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DidCreateContextNotification" object:ctx];
    
}
@end
