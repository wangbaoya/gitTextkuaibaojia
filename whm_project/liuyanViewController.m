//
//  liuyanViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "liuyanViewController.h"

@interface liuyanViewController ()<UITextViewDelegate>
@property(nonatomic,strong)UITextView * Mytextview;
@property(nonatomic,strong)UIButton * myBut;

@end

@implementation liuyanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"留言";
    [self creatLeftTtem];
    
    
    [self setUI];
}


-(void)setUI
{
    self.Mytextview = [[UITextView alloc]init];
    self.Mytextview.frame = CGRectMake(10, 10, CGRectGetWidth([UIScreen mainScreen].bounds)-20, CGRectGetHeight([UIScreen mainScreen].bounds)*0.3);
    self.Mytextview.textColor = [UIColor grayColor];
    self.Mytextview.font = [UIFont fontWithName:@"Arial" size:16.0];//设置字体名字和字体大小
    self.Mytextview.layer.masksToBounds = YES;
    self.Mytextview.layer.borderColor = wGrayColor2.CGColor;
    self.Mytextview.layer.borderWidth = 0.6;
    
    self.Mytextview.delegate = self;//设置它的委托方法
    
    self.Mytextview.backgroundColor = [UIColor whiteColor];//设置它的背景颜色
    self.Mytextview.scrollEnabled = YES;//是否可以拖动
    self.Mytextview.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    
    [self.view addSubview:_Mytextview];
    
    
    self.myBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.myBut.frame = CGRectMake(10,CGRectGetMaxY(self.Mytextview.frame)+10, CGRectGetWidth([UIScreen mainScreen].bounds)-20, 40);
    [self.myBut setTitle:@"提交" forState:(UIControlStateNormal)];
//    self.myBut.layer.shadowOffset = CGSizeMake(1, 1);
//    self.myBut.layer.shadowOpacity = 0.8;
    self.myBut.backgroundColor =SHENLANSEcolor;
    [self.myBut setTitleColor:wWhiteColor forState:UIControlStateNormal];
    [self.myBut addTarget:self action:@selector(myButAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.myBut.layer.cornerRadius = 20.0;
    [self.view addSubview:_myBut];
    
}

-(void)myButAction:(UIButton *)sender
{
    NSString * str = CHENGSHI?CHENGSHI:@"";
    
    if (self.Mytextview.text.length<1)
    {
        [WBYRequest showMessage:@"请输入留言"];
        
    }else
    {
        WS(weakSelf);
       
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        [dic setObject:_jieshourenid?_jieshourenid:@"" forKey:@"res_uid"];
        [dic setObject:UID?UID:@"" forKey:@"req_uid"];
        
        [dic setObject:_Mytextview.text?_Mytextview.text:@"" forKey:@"message"];
        [dic setObject:@"0" forKey:@"message_id"];
        [dic setObject:str?str:@"" forKey:@"city_name"];
        
        [dic setObject:XINGMING?XINGMING:@"" forKey:@"req_name"];
        [WBYRequest wbyLoginPostRequestDataUrl:@"save_message" addParameters:dic success:^(WBYReqModel *model) {
            if ([model.err isEqualToString:TURE])
            {
                
                [weakSelf.navigationController popViewControllerAnimated:YES];
                
            }
//            else
//            {
                [WBYRequest showMessage:model.info];
//            }
            if ([model.err isEqualToString:SAME])
            {
                [weakSelf goLogin];
            }
        } failure:^(NSError *error) {
            
        }];
        
        
        
    }
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self.Mytextview becomeFirstResponder];
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
