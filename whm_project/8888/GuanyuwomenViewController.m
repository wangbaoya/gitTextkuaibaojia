//
//  GuanyuwomenViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "GuanyuwomenViewController.h"

@interface GuanyuwomenViewController ()
@property(nonatomic,strong)UIWebView * scw;

@end

@implementation GuanyuwomenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatLeftTtem];
    [self setUp];
}
-(void)setUp
{
    self.title = @"关于我们";
    self.scw = [[UIWebView alloc]init];
    self.scw.frame = CGRectMake(0, 0, wScreenW , wScreenH-64);
    NSURL * url = [[NSBundle mainBundle]URLForResource:@"indexaboutaaaa.html" withExtension:nil];
    self.scw.backgroundColor = wWhiteColor;
    self.scw.scrollView.bounces = NO;
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [self.scw loadRequest:request];
    [self.view addSubview:_scw];
    
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
