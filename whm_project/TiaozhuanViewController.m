//
//  TiaozhuanViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/7/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TiaozhuanViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <Picidae.h>
#import "ShangchengdetileViewController.h"

@interface TiaozhuanViewController ()
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) JSContext *context;
@property (nonatomic,strong) PICBridge * bridge;

@end

@implementation TiaozhuanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString * str = @"http://cloud.kuaibao365.com";
    
    NSString * astr = [_myDic objectForKey:@"urls"];
    
    [self creatSecondWebview:[NSString stringWithFormat:@"%@%@",str,astr]];
    
}
-(void)creatSecondWebview:(NSString *)aurl
{
    
    UIView*view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 20)];
    view.backgroundColor = wBlue;    
    [self.view addSubview:view];

    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,20, wScreenW, wScreenH-20)];
//    self.webView.delegate = self;
    self.webView.scrollView.bounces = NO;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?is_app=%@&uid=%@&key=%@",aurl,@"1",UID?UID:@"",KEY?KEY:@""]];
    
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
         
         if ( [weakSelf.myDic[@"id"] isEqualToString:@"car"]||[weakSelf.myDic[@"id"] isEqualToString:@"/car"])
         {
             [weakSelf.navigationController popToRootViewControllerAnimated:YES];
             
         }else
         {
             ShangchengdetileViewController * shangcheng = [ShangchengdetileViewController new];
             
             shangcheng.myId = weakSelf.myDic[@"id"];
             
             [weakSelf.navigationController pushViewController:shangcheng animated:YES];
         }
         
      }];
    
       self.context[@"bridge"] = self.bridge;
    
    [self.context setExceptionHandler:^(JSContext * context, JSValue * value) {
        
        NSLog(@"%@",[value toObject]);
    }];
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
