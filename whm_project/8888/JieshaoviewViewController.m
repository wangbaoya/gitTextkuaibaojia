//
//  JieshaoviewViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "JieshaoviewViewController.h"
#import "XYTextView.h"

@interface JieshaoviewViewController ()
{
    NSArray * allArr;
    NSString * jieshao;
}
//myBut
@property(strong, nonatomic)XYTextView * textView;
@property(strong, nonatomic)UIButton * myBut;

@end

@implementation JieshaoviewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人介绍";
    [self creatLeftTtem];
    
    [self requestdata];
    [self creatright];
}

-(void)creatright
{
    UIButton * aabutton =[UIButton buttonWithType:UIButtonTypeCustom];
    aabutton.frame=CGRectMake(0, 0, 50, 30);
    [aabutton setTitle:@"完成" forState:UIControlStateNormal];
    
    [aabutton setTitleColor:wWhiteColor forState:UIControlStateNormal];
    aabutton.backgroundColor = SHENLANSEcolor;
    aabutton.titleLabel.font = Font(14);
    [aabutton addTarget:self action:@selector(myButAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *aanegativeSpacer =[[UIBarButtonItem alloc] initWithCustomView:aabutton];
    
    self.navigationItem.rightBarButtonItems = @[aanegativeSpacer];
    
}



-(void)creatui
{
    _textView = [[XYTextView alloc]initWithFrame:CGRectMake(20, 20, self.view.frame.size.width - 40, 150)];
    
    if (jieshao.length>1)
    {
        _textView.text = jieshao;
  
    }else
    {
        _textView.placeholder = @"请输入介绍";
 
    }
    
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.font = [UIFont systemFontOfSize:14.f];
    _textView.textColor = [UIColor blackColor];
    _textView.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_textView];

//    self.myBut = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.myBut.frame = CGRectMake(20,CGRectGetMaxY(self.textView.frame)+30, wScreenW-40, 40);
//    [self.myBut setTitle:@"提交修改" forState:(UIControlStateNormal)];
//  
//    self.myBut.backgroundColor =SHENLANSEcolor;
//    [self.myBut setTitleColor:wWhiteColor forState:UIControlStateNormal];
//    [self.myBut addTarget:self action:@selector(myButAction) forControlEvents:(UIControlEventTouchUpInside)];
//    self.myBut.layer.cornerRadius = 20.0;
//    [self.view addSubview:_myBut];
    
}

-(void)myButAction
{
    WS(weakSelf);
    if (self.textView.text.length<1)
    {
        [WBYRequest showMessage:@"请输入介绍"];
        
    }else
    {
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        
        [dic setObject:UID?UID:@"" forKey:@"uid"];
        [dic setObject:self.textView.text.length>=1?self.textView.text:@"" forKey:@"introduce"];        
        [WBYRequest wbyLoginPostRequestDataUrl:@"save_introduce" addParameters:dic success:^(WBYReqModel *model)
         {
             
            [WBYRequest showMessage:model.info];
        
             if ([model.err isEqualToString:TURE])
             {
                 
                 [weakSelf.navigationController popToRootViewControllerAnimated:YES];
             }
             
             
         } failure:^(NSError *error) {
             
         }];
 
        
        
    }
    
    
    
}


-(void)requestdata
{
    WS(weakSelf);
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setObject:UID?UID:@"" forKey:@"uid"];
    
    [WBYRequest wbyLoginPostRequestDataUrl:@"get_introduce" addParameters:dic success:^(WBYReqModel *model)
    {
        
        [weakSelf.beijingDateView removeFromSuperview];
        
        if ([model.err isEqualToString:TURE])
        {
            allArr = model.data;
            DataModel *mod = [model.data firstObject];
            jieshao = mod.introduce;
//     jieshao = @"  支付密码必须为6位数字组合。\n您可依次进入 '功能列表' -> '安全中心' 修改支付密码。";
            
            [weakSelf creatui];
        }else if ([model.err isEqualToString:@"1400"])
        {
            
            [WBYRequest showMessage:model.info];
        }
       
        
    } failure:^(NSError *error) {
        
    }];
    
  
    
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
