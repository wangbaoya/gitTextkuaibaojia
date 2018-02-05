//
//  WBYfpjcViewController.m
//  whm_project
//
//  Created by apple on 17/1/19.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WBYfpjcViewController.h"

#import "MyTabbarviewconstrerViewController.h"
@interface WBYfpjcViewController ()

@end

@implementation WBYfpjcViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发票寄出";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatUI];
    [self creatBtn];
    
}

-(void)creatUI
{
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake((wScreenW - 150)/2, 40, 150, 150)];
    img.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e63d", 150, Wqingse)];

    [self.view addSubview:img];
    
    UILabel * midLab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW/4, CGRectGetMaxY(img.frame) + 30,2*wScreenW/3-30, 40)];
    midLab.textColor = [UIColor colorWithRed:42 / 255.0 green:209 / 255.0 blue:123.0 / 255.0 alpha:1.0];
    midLab.font = [UIFont systemFontOfSize:34.f];
    midLab.text = @"发票已开取";
    [self.view addSubview:midLab];
    
    
    
    
    UILabel * xmLab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW/4, CGRectGetMaxY(midLab.frame)+5, 2*wScreenW/3-30, 20)];
    xmLab.textColor = wGrayColor;
    xmLab.font = [UIFont systemFontOfSize:14.f];
    xmLab.text = [NSString stringWithFormat:@"姓名:%@",XINGMING];
    [self.view addSubview:xmLab];
    
    UILabel * lllLab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW/4, CGRectGetMaxY(xmLab.frame)+10,40,30)];
    lllLab.textColor = wGrayColor;
    lllLab.font = [UIFont systemFontOfSize:14.f];
    if ([_zhuangtai isEqualToString:@"dianzi"])
    {
        lllLab.text = [NSString stringWithFormat:@"邮箱:"];
        
    }else
    {
        lllLab.text = [NSString stringWithFormat:@"地址:"];
    }
    [self.view addSubview:lllLab];
    
    
    UILabel * dzLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lllLab.frame), CGRectGetMaxY(xmLab.frame), 2*wScreenW/3-30-60, 50)];
    dzLab.textColor = wGrayColor;
    dzLab.numberOfLines = 0;
    dzLab.font = [UIFont systemFontOfSize:14.f];
    
    dzLab.text = [NSString stringWithFormat:@"%@",_dizhi];
    
    [self.view addSubview:dzLab];
 
    
    
    
   
    
}



-(void)creatBtn
{
    UIButton * button =[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=CGRectMake(0,0,30, 30);
    
    [button setBackgroundImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e60d", 30, QIANZITIcolor)] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(left) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:button];
    
}
-(void)left
{
    
//    [[UIApplication sharedApplication].delegate window].rootViewController=[MyTabbarviewconstrerViewController new];
    
    MyTabbarviewconstrerViewController*view=[[MyTabbarviewconstrerViewController alloc] init];
    
    view.dijici = 888;
    
    [[UIApplication sharedApplication].delegate window].rootViewController = view;
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
