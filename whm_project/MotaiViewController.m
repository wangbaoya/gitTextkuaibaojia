//
//  MotaiViewController.m
//  whm_project
//
//  Created by apple on 17/7/25.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "MotaiViewController.h"

@interface MotaiViewController ()<UIWebViewDelegate>

@end

@implementation MotaiViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatLeftTtem];
    [self request];
  
}

-(void)request
{
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH-64)];

    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_url]]];//创建
    
    [webView loadRequest:request];
    
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
