//
//  zhonganViewController.m
//  whm_project
//
//  Created by apple on 17/7/18.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "zhonganViewController.h"

@interface zhonganViewController ()<UIWebViewDelegate>

@end

@implementation zhonganViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = _tittle;
    
    [self creatLeftTtem];
    [self request];
}

-(void)request
{
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH-64)];
    webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_str]];//创建URL
    webView.delegate = self;
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [webView loadRequest:request];//加载
    [self.view addSubview:webView];
    
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // NOTE: ------  对alipays:相关的scheme处理 -------
    // NOTE: 若遇到微信相关scheme，则跳转到本地微信App
    NSString* reqUrl = request.URL.absoluteString;
    if ([reqUrl hasPrefix:@"weixin://"])
    {
        // NOTE: 跳转微信App
        BOOL bSucc = [[UIApplication sharedApplication]openURL:request.URL];
        
        if (!bSucc) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"未检测到微信，请安装后重试" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
            [alert show];
        }else if ([reqUrl hasPrefix:@"alipays://"] || [reqUrl hasPrefix:@"alipay://"]) {
            // NOTE: 跳转支付宝App
            BOOL bSucc = [[UIApplication sharedApplication]openURL:request.URL];
            
            // NOTE: 如果跳转失败，则跳转itune下载支付宝App
            if (!bSucc) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"未检测到支付宝，请安装后重试" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
                [alert show];
            }

        
        
        return NO;
        
        }

    }
    return YES;
}



- (void)webView:(UIWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(UIWebView *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
- (void)webView:(UIWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(UIWebView *)frame completionHandler:(void (^)(BOOL))completionHandler{
    //    DLOG(@"msg = %@ frmae = %@",message,frame);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)webView:(UIWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(UIWebView *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    
    
    
    [self presentViewController:alertController animated:YES completion:nil];
    
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
