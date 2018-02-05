//
//  XiangxidizhiViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XiangxidizhiViewController.h"
#import "LYYTextView.h"

@interface XiangxidizhiViewController ()
{
    LYYTextView *textView;
}

@end

@implementation XiangxidizhiViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"详细地址";
    
    [self creatLeftTtem];
    [self creatui];
}

-(void)creatui
{
    textView = [[LYYTextView alloc]initWithFrame:CGRectMake(10, 0, wScreenW-20, 100)];
    
    textView.text = [NSString stringWithFormat:@"%@",_dizhi];
    
    [self.view addSubview:textView];

    UIButton * downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    downBtn.frame = CGRectMake(10,CGRectGetMaxY(textView.frame)+50, wScreenW-20,40);
    downBtn.backgroundColor = SHENLANSEcolor;
    [downBtn setTitleColor:wWhiteColor forState:UIControlStateNormal];
    [downBtn setTitle:@"保存" forState:UIControlStateNormal];
    downBtn.layer.masksToBounds = YES;
    downBtn.layer.cornerRadius = 5;
    [downBtn addTarget:self action:@selector(baocun) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:downBtn];
    
}

-(void)baocun
{
    if (textView.text.length<1)
    {
        textView.text = textView.placeholder;
    }
    
    self.mydizhiBlock(textView.text);
    
    [self.navigationController popViewControllerAnimated:YES];
    
}






-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
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
