//
//  YaoqingViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "YaoqingViewController.h"

@interface YaoqingViewController ()
@property(nonatomic,strong)UIWebView * scw ;
@property(nonatomic,strong)UIButton * myButton;

@end

@implementation YaoqingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = wWhiteColor;
    self.title = @"邀请";
    
    [self creatLeftTtem];
    [self creatView];
}

-(void)creatView
{
    self.scw = [[UIWebView alloc]init];
    self.scw.frame = CGRectMake(0, 0, wScreenW,wScreenH-64);
    self.scw.backgroundColor = wWhiteColor;
    self.scw.scrollView.bounces = NO;
    
    NSURL * url = [[NSBundle mainBundle] URLForResource:@"index11.html" withExtension:nil];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [self.scw loadRequest:request];
    
    [self.view addSubview:_scw];
 
    
    self.myButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.myButton.frame = CGRectMake(wScreenW*0.15, wScreenH* 0.38, wScreenW * 0.7, 46);
    self.myButton.backgroundColor = [UIColor clearColor];
    [self.scw addSubview:_myButton];
    [self.myButton addTarget:self action:@selector(myButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
 
    
    
}

-(void)myButtonAction
{
    [MyShareSDK shareLogo:@"https://www.kuaibao365.com/static/images/ios_logo.png" baseaUrl:@"https://www.kuaibao365.com/share/reg" xianzhongID:UID?UID:@"" touBiaoti:@"快保家推荐注册有惊喜"];
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
