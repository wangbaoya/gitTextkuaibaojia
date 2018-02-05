//
//  DuibiwebPageViewController.m
//  whm_project
//
//  Created by apple on 17/3/13.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "DuibiwebPageViewController.h"

@interface DuibiwebPageViewController ()

@end

@implementation DuibiwebPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"险种对比";
    [self liaanniu];
    [self creatvreatView];
    
}

-(void)creatvreatView
{
//    https://www.kuaibao365.com/product/app_compare/580,584
    
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH-64)];
    webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_str]];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [webView loadRequest:request];//加载
    
    
    [self.view addSubview:webView];
    
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
