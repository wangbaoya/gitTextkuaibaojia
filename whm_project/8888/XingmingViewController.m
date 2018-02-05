//
//  XingmingViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XingmingViewController.h"

@interface XingmingViewController ()<UITextFieldDelegate>
{
    UITextField * tf;
}
@end

@implementation XingmingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"真实姓名";
    
    [self creatLeftTtem];
    
    [self creatUi];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [tf becomeFirstResponder];

}
-(void)creatUi
{
    tf = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, wScreenW-20, 40)];
    tf.delegate = self;
    tf.placeholder = _name?_name:@"请输入姓名";
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    [tf addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    
    
    [self.view addSubview:tf];
    
    UIView * aview = [[UIView alloc] initWithFrame:CGRectMake(10, 40, wScreenW-20, 1)];
    aview.backgroundColor = QIANLANSEcolor;
    [self.view addSubview:aview];
    
    UILabel * alab = [[UILabel alloc] initWithFrame:CGRectMake(10,41 , wScreenW-20, 20)];
    alab.font = Font(10);
    alab.textColor = QIANZITIcolor;
    alab.text = @"真实姓名用于代理认证，财务管理提现";
    
    [self.view addSubview:alab];
    
    
    UIButton * downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    downBtn.frame = CGRectMake(10,CGRectGetMaxY(alab.frame)+50, wScreenW-20,40);
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
    if (tf.text.length<1)
    {
        tf.text = tf.placeholder;
    }
    
    self.myXingmingBlock(tf.text);
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)textFieldDidChange
{
       CGFloat maxLength = 4;
        NSString *toBeString = tf.text;
        
        //获取高亮部分
        UITextRange *selectedRange = [tf markedTextRange];
        UITextPosition *position = [tf positionFromPosition:selectedRange.start offset:0];
        if (!position || !selectedRange)
        {
            if (toBeString.length > maxLength)
            {
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxLength];
                if (rangeIndex.length == 1)
                {
                    tf.text = [toBeString substringToIndex:maxLength];
                }
                else
                {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
                    tf.text = [toBeString substringWithRange:rangeRange];
                }
            }
        }
  
    

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
