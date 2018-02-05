//
//  BaseViewController.m
//  KuiBuText
//
//  Created by Baoya on 16/2/25.
//  Copyright © 2016年 Baoya. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];

    //关闭scroll的自适应
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.navigationController.navigationBar.translucent = NO;
   self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationController.navigationBar.translucent = NO;
//     [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:23.0/255 green:160.0/255 blue:229.0/225 alpha:1]];
    
//     [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:68.0/255 green:104.0/255 blue:255.0/225 alpha:1]];
    
    //如果这个视图有导航栏 并且 不是导航控制器的根视图控制器
    //为视图控制器创建左侧的返回Item按钮
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:Font(20),
       NSForegroundColorAttributeName:wBlackColor}];
    
//    if (self.navigationController && self != self.navigationController.viewControllers[0])
//    {
//       [self creatLiftItemWith:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e60e", 23, wBlackColor)] withFrame:CGRectMake(0, 0, 23, 25)];
//    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
}

//处理内存警告
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if ([self isViewLoaded] && !self.view.window)
    {
        self.view = nil;
    }

}

#pragma mark - custom method

-(void)creatLeftTtem
{
    [self creatLiftItemWith:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e60e",23,wBlackColor)] withFrame:CGRectMake(0,0,23,25)];
}
-(void)caiwucreatLeftTtem
{
    [self creatLiftItemWith:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e60e", 25,wWhiteColor)] withFrame:CGRectMake(0, 0,23, 25)];
}
-(void)liaanniu
{
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 23, 25);
    [button setBackgroundImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e60e", 25, wBlackColor)] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * button1 =[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(CGRectGetMaxX(button.frame)+25, 2, 22, 22);
    
    [button1 setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e62a",22, wBlackColor)] forState:UIControlStateNormal];

    
    
    [button1 addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *btn_right=[[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *negativeSpacer =[[UIBarButtonItem alloc] initWithCustomView:button1];
//    negativeSpacer.width = -5;
    
    UIBarButtonItem * aanagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace                                                                                   target:nil action:nil];
    aanagetiveSpacer.width = -10;//这个值可以根据自己需要自己调整

    
    UIBarButtonItem * bbnagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace                                                                                   target:nil action:nil];
    bbnagetiveSpacer.width = 12;//这个值可以根据自己需要自己调整

    
    self.navigationItem.leftBarButtonItems = @[aanagetiveSpacer,btn_right,bbnagetiveSpacer,negativeSpacer];
    
}

-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)fanhui
{
    UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你确定要返回首页吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
                        [view show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
     }
}

-(void)creatLiftItemWith:(UIImage *)backImg withFrame:(CGRect)frame
{
    UIButton * button =[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=frame;
    [button setBackgroundImage:backImg forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *leftBarButtonItems = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    //解决按钮不靠左 靠右的问题.
    
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace                                                                                   target:nil action:nil];
    
    nagetiveSpacer.width = -5;//这个值可以根据自己需要自己调整
    
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, leftBarButtonItems];
    
//    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:button];
}

-(void)creatRightItemWith:(UIImage *)backImg withFrame:(CGRect)frame
{
    UIButton * button =[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=frame;
    [button setBackgroundImage:backImg forState:UIControlStateNormal];
    //    [button addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:button];
}

//导航栏左按钮(返回按钮) - 触发事件
- (void)backButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}


-(void)callPhone:(NSString *)str
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否拨打电话" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.keyboardType = UIKeyboardTypeDecimalPad;
         
         [textField canResignFirstResponder];
         
        textField.text = str;
     
     }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
    {
        return ;
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"打电话" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
    {
        
        NSString * phone = [alertController.textFields firstObject].text;
        
//        if ([WBYRequest isMobileNumber:phone])
//        {
            NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",phone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

            
//        }else
//        {
//            [WBYRequest showMessage:@"电话号码不合法"];
//        }
        
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [[alertController.textFields firstObject] resignFirstResponder];

    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)wushuju
{
    [_beijingDateView removeFromSuperview];
    _beijingDateView = [[UIView alloc]init];
    _beijingDateView.frame = CGRectMake(0, 0, wScreenW, wScreenH-64);
    _beijingDateView.backgroundColor = RGBwithColor(241, 241, 241);

    [self.view addSubview:_beijingDateView];
    
    UIImageView * noDateImg = [[UIImageView alloc] init];
    noDateImg.frame = CGRectMake((wScreenW-200)/2,(wScreenH-210-64)/2-50, 200,210);
    noDateImg.image = [UIImage imageNamed:@"wutupian"];
    [_beijingDateView addSubview:noDateImg];
    
}
-(void)wushujuSecond
{
    [_beijingDateView removeFromSuperview];
    _beijingDateView = [[UIView alloc]init];
    _beijingDateView.frame = CGRectMake(0, 70, wScreenW, wScreenH-64-70);
    _beijingDateView.backgroundColor = wWhiteColor;
    [self.view addSubview:_beijingDateView];
    
    UIImageView * noDateImg = [[UIImageView alloc] init];
     noDateImg.frame = CGRectMake((wScreenW-200)/2,(wScreenH-210-64)/2-50, 200,210);
    noDateImg.image = [UIImage imageNamed:@"wutupian"];
    
    [_beijingDateView addSubview:noDateImg];
    
}




#pragma mark===去分割线
-(void)qufengexian
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        NSArray *list=self.navigationController.navigationBar.subviews;
        
        for (id obj in list)
        {
            if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0)
            {//10.0的系统字段不一样
                UIView *view =   (UIView*)obj;
                for (id obj2 in view.subviews)
                {
                    if ([obj2 isKindOfClass:[UIImageView class]])
                    {
                        UIImageView *image =  (UIImageView*)obj2;
                        image.hidden = YES;
                    }
                }
            }else
            {
                if ([obj isKindOfClass:[UIImageView class]])
                {
                    UIImageView *imageView=(UIImageView *)obj;
                    NSArray *list2=imageView.subviews;
                    for (id obj2 in list2)
                    {
                        if ([obj2 isKindOfClass:[UIImageView class]])
                        {
                            UIImageView *imageView2=(UIImageView *)obj2;
                            imageView2.hidden=YES;
                        }
                    }
                }
            }
        }
        
    }
    
}

-(void)jiafengexian
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        NSArray *list=self.navigationController.navigationBar.subviews;
        
        for (id obj in list)
        {
            if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0)
            {//10.0的系统字段不一样
                UIView *view =   (UIView*)obj;
                for (id obj2 in view.subviews)
                {
                    if ([obj2 isKindOfClass:[UIImageView class]])
                    {
                        UIImageView *image =  (UIImageView*)obj2;
                        image.hidden = NO;
                    }
                }
            }else
            {
                if ([obj isKindOfClass:[UIImageView class]])
                {
                    UIImageView *imageView=(UIImageView *)obj;
                    NSArray *list2=imageView.subviews;
                    for (id obj2 in list2)
                    {
                        if ([obj2 isKindOfClass:[UIImageView class]])
                        {
                            UIImageView *imageView2=(UIImageView *)obj2;
                            imageView2.hidden=NO;
                        }
                    }
                }
            }
        }
        
    }
    
}

#pragma mark失去第一相应
-(void)shiqudiyixiangying
{
    //轻扫
    UITapGestureRecognizer *swipe = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    
    
    
    [self.view addGestureRecognizer:swipe];
    
}



-(void)swipe:(UISwipeGestureRecognizer*)sender
{
    
    [[[UIApplication sharedApplication].delegate window] endEditing:YES];
}




-(void)goLogin
{
    
    [self.navigationController pushViewController:[LoginViewController new] animated:YES];
    
    
    
    
    
}









@end
