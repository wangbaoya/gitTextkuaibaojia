//
//  XinwenxiangqingViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XinwenxiangqingViewController.h"
#import "YBPopupMenu.h"

@interface XinwenxiangqingViewController ()<UIWebViewDelegate,UIScrollViewDelegate,YBPopupMenuDelegate>
{
    NSArray * myArr;
    UIScrollView * myScroll;
    NSInteger oldOffset;
    UIWebView * web;
}
@end

@implementation XinwenxiangqingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"新闻详情";
    self.view.backgroundColor = wBaseColor;

    myArr = [NSArray array];    
    [self request];
    
    [self creatbtn];
}

-(void)creatRightItemWith:(UIImage *)backImg withFrame:(CGRect)frame
{
    UIButton * button =[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=frame;
    [button setBackgroundImage:backImg forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fenxiang:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:button];
}

-(void)fenxiang:(UIButton*)sender
{
    
    CGPoint point = CGPointMake(sender.center.x, sender.center.y+40);
    
    //    CGPointMake(wScreenW-25, 60)
    [YBPopupMenu showAtPoint:point titles:@[@"收藏",@"分享"] icons:@[@"wh_collect",@"wh_share"] menuWidth:120 otherSettings:^(YBPopupMenu *popupMenu)
     {
         //        popupMenu.dismissOnSelected = NO;
         //        popupMenu.isShowShadow = YES;
         popupMenu.delegate = self;
         //        popupMenu.offset = 10;
         //        popupMenu.type = YBPopupMenuArrowDirectionNone;
         //        popupMenu.rectCorner = UIRectCornerBottomLeft | UIRectCornerBottomRight;
         
         popupMenu.textColor = wWhiteColor;
     }];
    
    
}
#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu
{
//    DataModel * myModel = allArr.count >=1 ? allArr[0]:@"";
    
    if (index==0)
    {
        if (index==0)
        {
            NSString * token = KEY;
            
            if (token.length>5)
            {
                [self shoucangcreatrequest];
                
            }else
            {
                UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要去登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [view show];
            }
            
        }
    }else
    {
        if (myArr.count>0)
        {
            DataModel * model = [myArr firstObject];
            [MyShareSDK shareLogo:@"" baseaUrl:ZIXUNBASEURL xianzhongID:_myId touBiaoti:model.title.length>=1?model.title:@"新闻详情"];
        }else
        {
        [MyShareSDK shareLogo:@"" baseaUrl:ZIXUNBASEURL xianzhongID:_myId touBiaoti:@"新闻详情"];
            
        }
        
        
//        [MyShareSDK shareLogo:@"" baseaUrl:ZIXUNBASEURL xianzhongID:_myId touBiaoti:@"新闻详情"];
    }
}

-(void)shoucangcreatrequest
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:_myId?_myId:@"" forKey:@"type_id"];
    [dic setObject:@"news" forKey:@"type"];
    [dic setObject:UID?UID:@"" forKey:@"uid"];
    
    [WBYRequest wbyLoginPostRequestDataUrl:@"collect"  addParameters:dic success:^(WBYReqModel *model)
     {
         [WBYRequest showMessage:model.info];
         
     } failure:^(NSError *error)
     {
         
     }];
}
-(void)creatbtn
{
    [self creatLeftTtem];
    [self creatRightItemWith:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e611", 25,wBlackColor)] withFrame:CGRectMake(0, 0,23, 25)];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self qufengexian];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    
    [self jiafengexian];
}



-(void)request
{
    WS(weakSelf);
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setObject:_myId?_myId:@"" forKey:@"nid"];
    
    [dic setObject:UID?UID:@"" forKey:@"uid"];
    
    [WBYRequest wbyPostRequestDataUrl:@"news_detail" addParameters:dic success:^(WBYReqModel *model)
     {
         if ([model.err isEqualToString:TURE])
         {
             myArr = model.data;
             [weakSelf creatmyview];
         }
         
     } failure:^(NSError *error) {
         
     } isRefresh:NO];
}


-(void)creatmyview
{
    
    DataModel * model = [myArr firstObject];
    
    myScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, wScreenW, wScreenH-64)];
    myScroll.bounces = NO;
    myScroll.delegate = self;
//    myScroll.userInteractionEnabled = YES;
    myScroll.showsVerticalScrollIndicator = NO;

    myScroll.contentSize = CGSizeMake(wScreenW, wScreenH-64+100);
    [self.view addSubview:myScroll];

    
    UILabel * myLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, wScreenW-60, 50)];
    myLab.font = biaoTiFont;
    myLab.textColor = [UIColor blackColor];
    myLab.numberOfLines = 0;
    myLab.text = model.title;
    [myScroll addSubview:myLab];
    
    UILabel * amyLab = [[UILabel alloc] initWithFrame:CGRectMake(30,CGRectGetMaxY(myLab.frame), wScreenW-160, 30)];
    amyLab.font = zhongFont;
    amyLab.textColor = QIANZITIcolor;
    amyLab.text = [NSString stringWithFormat:@"%@ %@",model.source,[WBYRequest timeStr:model.created_time]];
    [myScroll addSubview:amyLab];
    
    
    UILabel * bmyLab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW-70, 50+10,60, 30)];
    bmyLab.font = Font(14);
    bmyLab.textColor = wWhiteColor;
    bmyLab.textAlignment = 1;
    bmyLab.backgroundColor = wRedColor;
    bmyLab.text = [NSString stringWithFormat:@" %@ 阅读",model.mycount];
    [myScroll addSubview:bmyLab];
    
    UIView* aview = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bmyLab.frame)+10, wScreenW, 10)];
    aview.backgroundColor = wWhiteColor;
    [myScroll addSubview:aview];
    
    web = [[UIWebView alloc] initWithFrame:CGRectMake(0,100+10, wScreenW,wScreenH-64)];
    web.delegate = self;
    web.scrollView.bounces = NO;
    web.scrollView.showsVerticalScrollIndicator = NO;
    [web loadHTMLString:model.content?model.content:@"" baseURL:nil];
    
    web.scrollView.scrollEnabled = NO;
    [myScroll addSubview:web];
  
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView==myScroll)
    {
        if (scrollView.contentOffset.y>oldOffset)
        {
            NSLog(@"===向上");
            if (scrollView.contentOffset.y>=1)
            {
                [UIView animateWithDuration:0.5 animations:^{
                    myScroll.contentOffset = CGPointMake(0,100);
                   web.scrollView.contentOffset = CGPointMake(0,1);
                    web.scrollView.scrollEnabled = YES;
                }];
            }
            
        }else
        {
            if (scrollView.contentOffset.y>=1)
            {
                [UIView animateWithDuration:0.5 animations:^{
                    myScroll.contentOffset = CGPointMake(0,0);
                    web.scrollView.contentOffset = CGPointMake(0,0);
                    web.scrollView.scrollEnabled = NO;
                }];
            }
        }
        oldOffset = scrollView.contentOffset.y;
    }
    
    if (scrollView==web.scrollView)
    {
        if (scrollView.contentOffset.y<1)
        {
            [UIView animateWithDuration:0.5 animations:^{
                myScroll.contentOffset = CGPointMake(0,0);
                web.scrollView.scrollEnabled = NO;
            }];
        }
    }
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSString *js=@"var script = document.createElement('script');"
    "script.type = 'text/javascript';"
    "script.text = \"function ResizeImages() { "
    "var myimg,oldwidth;"
    "var maxwidth = %f;"
    "for(i=0;i <document.images.length;i++){"
    "myimg = document.images[i];"
    "if(myimg.width > maxwidth){"
    "oldwidth = myimg.width;"
    "myimg.width = %f;"
    "}"
    "}"
    "}\";"
    "document.getElementsByTagName('head')[0].appendChild(script);";
    js=[NSString stringWithFormat:js,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.width-15];
    
    [webView stringByEvaluatingJavaScriptFromString:js];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
   
    
}


-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '95%'"];
    //字体颜色
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= 'gray'"];
    
    NSString *js=@"var script = document.createElement('script');"
      "script.type = 'text/javascript';"
      "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth;"
        "var maxwidth = %f;"
      "for(i=0;i <document.images.length;i++){"
        "myimg = document.images[i];"
        "if(myimg.width > maxwidth){"
      "oldwidth = myimg.width;"
         "myimg.width = %f;"
         "}"
        "}"
       "}\";"
        "document.getElementsByTagName('head')[0].appendChild(script);";
        js=[NSString stringWithFormat:js,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.width-15];
    
        [webView stringByEvaluatingJavaScriptFromString:js];
       [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
    
    
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
