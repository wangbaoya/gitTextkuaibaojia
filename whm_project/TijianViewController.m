//
//  TijianViewController.m
//  MYTEXT
//
//  Created by apple on 17/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TijianViewController.h"
#import "BaodantijianaaViewController.h"

@interface TijianViewController ()
{
    NSArray * tittlArr;
    NSString * mystr;
}
@end

@implementation TijianViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title= @"客户保单体检服务";
    
    [self mycreataview];
    [self qufengexian];
    
//    [self request];
    
 }

-(void)mycreataview
{
    WS(weakSelf);
    
    
    [WBYRequest wbyPostRequestDataUrl:@"get_policy_count" addParameters:nil success:^(WBYReqModel *model)
    {
        DataModel * amodel = [model.data firstObject];
        NSLog(@"====%@",amodel.count_m);
        
        [weakSelf creatView:amodel.count_m];

    } failure:^(NSError *error)
    {
        
    } isRefresh:NO];
    
    
  
}


-(void)request
{
    
    UILabel * alab = [self.view viewWithTag:501];
    
    [WBYRequest wbyPostRequestDataUrl:@"get_policy_count" addParameters:nil success:^(WBYReqModel *model)
     {
         DataModel * amodel = [model.data firstObject];
         NSLog(@"====%@",amodel.count_m);
         
  
         alab.text =amodel.count_m?amodel.count_m:@"99";
         
     } failure:^(NSError *error)
     {
         
     } isRefresh:NO];
    
}



-(void)creatView:(NSString*)str
{
//    127 218
//    CGFloat xx = (wScreenW-218)/2;
//    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(xx, 10, 218, 127)];
//    
//    img.image = [UIImage imageNamed:@"tijianaa"];
//    
//    [self.view addSubview:img];
    
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 320, 127)];
    img.image = [UIImage imageNamed:@"baodaner"];
    img.center = CGPointMake(self.view.center.x,10+127/2);
    [self.view addSubview:img];
    
    CGFloat bili = wScreenH/568;
    
    if (wScreenH>568)
    {
        
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(img.frame), wScreenW-100, 130*bili)];
        lab.numberOfLines = 0;
        lab.textAlignment = 1;
        lab.font = Font(14*bili);
        lab.textColor = QIANZITIcolor;
        
        lab.text = @"为了更好地进行财务管理，使家庭获得更加完善的保障，以便在万一发生不测，能保障自己及家人的生活安全。让我们帮你为家中保单做次全方面的“体检”吧！";
        
        [self.view addSubview:lab];
        
        tittlArr = @[@"已经有",str?str:@"99",@"人使用本系统进行保单年检"];
        
        for (NSUInteger i=0; i<tittlArr.count; i++)
        {
            UILabel * myLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lab.frame)+(25*bili+5)*i, wScreenW,25*bili)];
            myLab.font = i==0||i==2?Font(18*bili):Font(35*bili);
            myLab.numberOfLines=0;
            myLab.textColor = QIANLANSEcolor;
            myLab.text = tittlArr[i];
            myLab.textAlignment = 1;
            [self.view addSubview:myLab];
        }
        
        UIButton * downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        downBtn.frame = CGRectMake(30,CGRectGetMaxY(lab.frame)+30*3*bili+30, wScreenW-60,40*bili);
        downBtn.backgroundColor = SHENLANSEcolor;
        [downBtn setTitleColor:wWhiteColor forState:UIControlStateNormal];
        [downBtn setTitle:@"点击体验保单体检服务" forState:UIControlStateNormal];
        downBtn.titleLabel.font = Font(18*bili);
        downBtn.layer.masksToBounds = YES;
        downBtn.layer.cornerRadius = 5;
        [downBtn addTarget:self action:@selector(dianjitijian) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:downBtn];
        
    }else
    {
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(img.frame), wScreenW-100, 130)];
        lab.numberOfLines = 0;
        lab.textAlignment = 1;
        lab.font = Font(14);
        lab.textColor = QIANZITIcolor;
        lab.text = @"为了更好地进行财务管理，使家庭获得更加完善的保障，以便在万一发生不测，能保障自己及家人的生活安全。让我们帮你为家中保单做次全方面的“体检”吧！";
        
        [self.view addSubview:lab];
        
        tittlArr = @[@"已经有",str?str:@"666",@"人使用本系统进行保单体检"];
        
        for (NSUInteger i=0; i<tittlArr.count; i++)
        {
            UILabel * myLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lab.frame)+(25+5)*i, wScreenW,25)];
            myLab.font = i==0||i==2?Font(18):Font(35);
            myLab.numberOfLines=0;
            
            myLab.tag = 500 + i;
            myLab.textColor = QIANLANSEcolor;
            myLab.text = tittlArr[i];
            myLab.textAlignment = 1;
            [self.view addSubview:myLab];
            
        }
        
        UIButton * downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        downBtn.frame = CGRectMake(30,CGRectGetMaxY(lab.frame)+30*3+30, wScreenW-60,40);
        downBtn.backgroundColor = SHENLANSEcolor;
        [downBtn setTitleColor:wWhiteColor forState:UIControlStateNormal];
        [downBtn setTitle:@"点击体验保单体检服务" forState:UIControlStateNormal];
        downBtn.titleLabel.font = Font(18);
        downBtn.layer.masksToBounds = YES;
        downBtn.layer.cornerRadius = 5;
        [downBtn addTarget:self action:@selector(dianjitijian) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:downBtn];
        
    }
    
    
    
    
}


-(void)dianjitijian
{
    [self.navigationController pushViewController:[BaodantijianaaViewController new] animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];

    [self request];
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
