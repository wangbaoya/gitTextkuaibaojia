//
//  ShangchengdetileViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/7/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ShangchengdetileViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <Picidae.h>
#import "TiaozhuanViewController.h"
#import "LoginViewController.h"
#import "MyTabbarviewconstrerViewController.h"

@interface ShangchengdetileViewController ()<UIWebViewDelegate>
{
    NSDictionary * aUrl;
    
}
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) JSContext *context;
@property (nonatomic,strong) PICBridge * bridge;

@end

@implementation ShangchengdetileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = wBlue;

    [self creatLeftTtem];
//    self.navigationItem.title = @"详情";

    NSString * str = @"http://cloud.kuaibao365.com/pro/detail/";
    [self creatWebview:str];
}

-(void)creatWebview:(NSString *)aurl
{
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20, wScreenW, wScreenH-20)];
    self.webView.delegate = self;
    self.webView.scrollView.bounces = NO;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?is_app=%@&uid=%@&key=%@",aurl,_myId,@"1",UID?UID:@"",KEY?KEY:@""]];
    
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

       
        MyTabbarviewconstrerViewController  * shangcheng = [MyTabbarviewconstrerViewController new];
        shangcheng.dijici = 666;
        shangcheng.selectedIndex = 2;
        [[UIApplication sharedApplication].delegate window].rootViewController = shangcheng;
        
    }];
    
    
    [self.bridge addActionHandler:@"Login" forCallBack:^(NSDictionary *params, void (^errorCallBack)(NSError *error), void (^successCallBack)(NSDictionary *responseDict))
     
    {
        NSLog(@"===%@",params);
        
        aUrl = params;
        
        NSString * str = KEY;
        
        NSString * strqq = UID;

        NSLog(@"===%@===%@",str,strqq);

        if (str.length<5&&strqq.length<1)
        {
//            TiaozhuanViewController * login = [TiaozhuanViewController new];
//            login.myDic = params;
//            [weakSelf.navigationController pushViewController:login animated:YES];
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要去登录" delegate:weakSelf cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [view show];
            
        }else
        {
            TiaozhuanViewController * tiaozhuan = [TiaozhuanViewController new];
            tiaozhuan.myDic = params;
            
            [weakSelf.navigationController pushViewController:tiaozhuan animated:YES];
        }
        
      
    
    }];
    
    self.context[@"bridge"] = self.bridge;
    [self.context setExceptionHandler:^(JSContext * context, JSValue * value) {
        
        NSLog(@"%@",[value toObject]);
    }];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        LoginViewController * login = [LoginViewController new];
        
        login.myDic = aUrl;
        login.myStr = @"666";
        
         [self.navigationController pushViewController:login animated:YES];
        
    }
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
//    NSString *currentURL = [_webView stringByEvaluatingJavaScriptFromString:@"window.location.href"];
//    NSLog(@"=====%@",currentURL);
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
//    NSString *currentURL = [_webView stringByEvaluatingJavaScriptFromString:@"window.location.href"];
    
//    NSLog(@"=====kaishi%@",currentURL);
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(captureJSContext) name:@"DidCreateContextNotification" object:nil];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];

    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
[[NSNotificationCenter defaultCenter] removeObserver:self name:@"DidCreateContextNotification" object:nil];
  [self.navigationController setNavigationBarHidden:NO animated:NO];
    
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
