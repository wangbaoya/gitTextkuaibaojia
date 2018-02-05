//
//  BaodantijianaaViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BaodantijianaaViewController.h"
#import "WoDeBaoDanViewController.h"
#import "TianjiaxinxianzhongViewController.h"
#import "TijiancanshuViewController.h"

#import "XiuGaiViewController.h"

@interface BaodantijianaaViewController ()
{
    UIButton * oneView;
    UIButton * erbuview;
    UIButton * sanbview;

    UIButton * downBtn;
    
    NSString * dijige;
    UIButton * touxiangImg;
    
    NSString * beibaorenSex;
    NSString * xianzhongs;

    NSString * beibaorenId;
    
    NSString * myimgs;

    DataModel * Amodel;
    
}
@end

@implementation BaodantijianaaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"保单体检";
    
    dijige = @"1";
    [self creatLeftTtem];
    [self creatView];
}

-(void)creatView
{
//    273/2
  
    CGFloat bili = wScreenH/568;
    
    CGFloat getHeight = 136.5 * bili;
    
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, wScreenW,getHeight)];
    img.image = [UIImage imageNamed:@"bandan"];
    
    img.userInteractionEnabled = YES;
    [self.view addSubview:img];
    
    RGBwithColor(255, 234, 10);
    
    
    CAShapeLayer * bblayer = [CAShapeLayer new];
    bblayer.lineWidth = 1;
    bblayer.strokeColor = RGBwithColor(199,231,255).CGColor;
    bblayer.fillColor =  RGBwithColor(255, 234, 10).CGColor;
    
    UIBezierPath *bbpath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(wScreenW/2+25, (getHeight-70)/2+15) radius:10 startAngle:0 endAngle:2*M_PI clockwise:YES];
    bblayer.path = [bbpath CGPath];
    [img.layer addSublayer:bblayer];
    
    
    touxiangImg = [[UIButton alloc] initWithFrame:CGRectMake(wScreenW/2-35, getHeight/2-35, 70, 70)];
//    touxiangImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e62e",70,wWhiteColor)];
    
    [touxiangImg setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e62e",70,wWhiteColor)] forState:UIControlStateNormal];
    touxiangImg.layer.masksToBounds = YES;
    touxiangImg.layer.cornerRadius = 35;
    [touxiangImg addTarget:self action:@selector(huantouxiang) forControlEvents:UIControlEventTouchUpInside];

    [img addSubview:touxiangImg];
    
    
    
    
    CAShapeLayer * layer = [CAShapeLayer new];
    layer.lineWidth = 1;
    layer.strokeColor = RGBwithColor(199,231,255).CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:touxiangImg.center radius:45 startAngle:0 endAngle:2*M_PI clockwise:YES];
    layer.path = [path CGPath];
    [img.layer addSublayer:layer];
    
    
    CAShapeLayer * aalayer = [CAShapeLayer new];
    aalayer.lineWidth = 1;
    aalayer.strokeColor = RGBwithColor(199,231,255).CGColor;
    aalayer.fillColor = [UIColor clearColor].CGColor;
    UIBezierPath *aapath = [UIBezierPath bezierPathWithArcCenter:touxiangImg.center radius:55 startAngle:0 endAngle:2*M_PI clockwise:YES];
    aalayer.path = [aapath CGPath];
    [img.layer addSublayer:aalayer];
    
    
    
    
    UILabel * midLab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW/2-50, CGRectGetMaxY(img.frame)+20, 100, 35)];
    midLab.text = @"开始体检";
    midLab.textAlignment = 1;
    midLab.textColor = wBlackColor;
    midLab.font = Font(18);
    [self.view addSubview:midLab];
    
    CGFloat ww = (wScreenW-100-60*2)/2;
    UILabel * lLab = [[UILabel alloc] initWithFrame:CGRectMake(60, CGRectGetMaxY(img.frame)+20+35/2-0.5, ww, 0.5)];
    lLab.backgroundColor = FENGEXIANcolor;
    
    [self.view addSubview:lLab];
    
    UILabel * rLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(midLab.frame), CGRectGetMaxY(img.frame)+20+35/2-0.5, ww, 0.5)];
    rLab.backgroundColor = FENGEXIANcolor;
    [self.view addSubview:rLab];
    
//    136+55+45
    
    CGFloat hh = (wScreenH-64-getHeight-55-45)/3;
    
    CGFloat  xiaohh = hh/3;
    
     oneView = [UIButton buttonWithType:UIButtonTypeCustom];
    oneView.frame = CGRectMake(0, CGRectGetMaxY(midLab.frame), wScreenW, hh);
    [oneView addTarget:self action:@selector(diyibu) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:oneView];
    
    UIImageView * xiaoImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, (xiaohh-6)/2, 6, 6)];
    xiaoImg.layer.masksToBounds = YES;
    xiaoImg.layer.cornerRadius = 3;
    xiaoImg.backgroundColor = wBlackColor;
    [oneView addSubview:xiaoImg];
    UILabel * upLab = [[UILabel alloc] initWithFrame:CGRectMake(32, 0, wScreenW-32, xiaohh)];
    upLab.textColor = SHENLANSEcolor;
    
    upLab.font = Font(18);
    upLab.text = @"第一步";
    [oneView addSubview:upLab];
    
    UILabel * secmidLab = [[UILabel alloc] initWithFrame:CGRectMake(32, CGRectGetMaxY(upLab.frame), wScreenW-32, xiaohh)];
    secmidLab.textColor = SHENLANSEcolor;
    secmidLab.font = Font(20);
    
    secmidLab.text = @"添加被保人";
    [oneView addSubview:secmidLab];
    
    UILabel * downLab = [[UILabel alloc] initWithFrame:CGRectMake(32, CGRectGetMaxY(secmidLab.frame), wScreenW-32, xiaohh)];
    downLab.textColor = SHENLANSEcolor;
    downLab.font = Font(16);
   
    downLab.text = @"选择你要体检的对象";
    [oneView addSubview:downLab];

    upLab.tag = 101;
    secmidLab.tag = 102;
    downLab.tag = 103;
    
    
    UIView * xianView = [[UIView alloc] initWithFrame:CGRectMake(32, CGRectGetMaxY(downLab.frame)-1, wScreenW-32, 0.5)];
    xianView.backgroundColor = FENGEXIANcolor;
    [oneView addSubview:xianView];
    
    [self creattwo];
}

-(void)creattwo
{
    CGFloat bili = wScreenH/568;
    
    CGFloat getHeight = 136.5 * bili;
    CGFloat hh = (wScreenH-64-getHeight-55-45)/3;
    
    CGFloat  xiaohh = hh/3;
    
    
    erbuview = [UIButton buttonWithType:UIButtonTypeCustom];
    erbuview.frame = CGRectMake(0, CGRectGetMaxY(oneView.frame), wScreenW, hh);
    [erbuview addTarget:self action:@selector(dierbu) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:erbuview];
    
    UIImageView * xiaoImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, (xiaohh-6)/2, 6, 6)];
    xiaoImg.layer.masksToBounds = YES;
    xiaoImg.layer.cornerRadius = 3;
    xiaoImg.backgroundColor = wBlackColor;
    [erbuview addSubview:xiaoImg];
    UILabel * upLab = [[UILabel alloc] initWithFrame:CGRectMake(32, 0, wScreenW-32, xiaohh)];
    upLab.textColor = wBlackColor;
    upLab.font = Font(18);
    upLab.text = @"第二步";
    [erbuview addSubview:upLab];
    
    UILabel * secmidLab = [[UILabel alloc] initWithFrame:CGRectMake(32, CGRectGetMaxY(upLab.frame), wScreenW-32, xiaohh)];
    secmidLab.textColor = wBlackColor;
    secmidLab.font = Font(20);
    secmidLab.text = @"添加险种";
    [erbuview addSubview:secmidLab];
    
    UILabel * downLab = [[UILabel alloc] initWithFrame:CGRectMake(32, CGRectGetMaxY(secmidLab.frame), wScreenW-32, xiaohh)];
    downLab.textColor = QIANZITIcolor;
    downLab.font = Font(16);
    downLab.text = @"选择你要体检的险种(可多选)";
    [erbuview addSubview:downLab];
    
    
    upLab.tag = 201;
    secmidLab.tag = 202;
    downLab.tag = 203;
    
    UIView * xianView = [[UIView alloc] initWithFrame:CGRectMake(32, CGRectGetMaxY(downLab.frame)-1, wScreenW-32, 0.5)];
    xianView.backgroundColor = FENGEXIANcolor;
    [erbuview addSubview:xianView];
   
    [self cretsan];
}


-(void)huantouxiang
{

//    XiuGaiViewController * xiugai = [XiuGaiViewController new];
//    
//    
//    if (Amodel.name.length>=1)
//    {
//        xiugai.xiugaiNumber = 666;
//        xiugai.aModel = Amodel;
//
//    }
//    
//    
//    [self.navigationController pushViewController:xiugai animated:YES];
//
    if (KEY&&UID)
    {
       
        UILabel * lab1 = [self.view viewWithTag:101];
        UILabel * lab2 = [self.view viewWithTag:102];
        UILabel * lab3 = [self.view viewWithTag:103];
        UILabel * alab1 = [self.view viewWithTag:201];
        UILabel * alab2 = [self.view viewWithTag:202];
        UILabel * alab3 = [self.view viewWithTag:203];
        
        
        WoDeBaoDanViewController * bandan = [WoDeBaoDanViewController new];
        bandan.tijian = @"tijian";
        
        bandan.tijianBlock = ^(DataModel * mod)
        {
            
            [downBtn setTitle:@"选择险种" forState:UIControlStateNormal];
            
            [touxiangImg sd_setImageWithURL:[NSURL URLWithString:mod.avatar] forState:UIControlStateNormal placeholderImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e62e", 70, wWhiteColor)]];
            
            dijige = @"2";
            beibaorenSex = mod.sex;
            beibaorenId = mod.id;
            myimgs = mod.avatar;
            
            Amodel = mod;
            lab1.textColor = wBlackColor;
            lab2.textColor = wBlackColor;
            lab3.textColor = QIANZITIcolor;
            
            alab1.textColor = SHENLANSEcolor;
            alab2.textColor = SHENLANSEcolor;
            alab3.textColor = SHENLANSEcolor;
            
            
        };
        [self.navigationController pushViewController:bandan animated:YES];
    
    }
    
    else
    {
        
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要去登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        
         [view show];
    }

    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        
        [self goLogin];
    }
    
    
    
}



-(void)cretsan
{
    CGFloat bili = wScreenH/568;
    
    CGFloat getHeight = 136.5 * bili;
    CGFloat hh = (wScreenH-64-getHeight-55-45)/3;
    
    CGFloat  xiaohh = hh/3;
    sanbview = [UIButton buttonWithType:UIButtonTypeCustom];
    sanbview.frame =CGRectMake(0, CGRectGetMaxY(erbuview.frame), wScreenW, hh);
    
    [sanbview addTarget:self action:@selector(disanbu) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:sanbview];
    
    UIImageView * xiaoImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, (xiaohh-6)/2, 6, 6)];
    xiaoImg.layer.masksToBounds = YES;
    xiaoImg.layer.cornerRadius = 3;
    xiaoImg.backgroundColor = wBlackColor;
    [sanbview addSubview:xiaoImg];
    UILabel * upLab = [[UILabel alloc] initWithFrame:CGRectMake(32, 0, wScreenW-32, xiaohh)];
    upLab.textColor = wBlackColor;
    upLab.font = Font(18);
    upLab.text = @"第三步";
    [sanbview addSubview:upLab];
    
    UILabel * secmidLab = [[UILabel alloc] initWithFrame:CGRectMake(32, CGRectGetMaxY(upLab.frame), wScreenW-32, xiaohh)];
    secmidLab.textColor = wBlackColor;
    secmidLab.font = Font(20);
    secmidLab.text = @"选择险种参数";
    [sanbview addSubview:secmidLab];
    
    UILabel * downLab = [[UILabel alloc] initWithFrame:CGRectMake(32, CGRectGetMaxY(secmidLab.frame), wScreenW-32, xiaohh)];
    downLab.textColor = QIANZITIcolor;
    downLab.font = Font(16);
    downLab.text = @"填写/选择险种参数)";
    [sanbview addSubview:downLab];
    
    upLab.tag = 301;
    secmidLab.tag = 302;
    downLab.tag = 303;
    
    UIView * xianView = [[UIView alloc] initWithFrame:CGRectMake(32, CGRectGetMaxY(downLab.frame)-1, wScreenW-32, 0.5)];
    xianView.backgroundColor = FENGEXIANcolor;
    [sanbview addSubview:xianView];

     downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    downBtn.frame = CGRectMake(0,wScreenH-64-45, wScreenW,45);
    downBtn.backgroundColor = SHENLANSEcolor;
    [downBtn setTitleColor:wWhiteColor forState:UIControlStateNormal];
    [downBtn setTitle:@"添加被保人" forState:UIControlStateNormal];
    downBtn.titleLabel.font = Font(18);
        [downBtn addTarget:self action:@selector(dianjitijian) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:downBtn];
    
}

#pragma mark===第一步 点击事件

-(void)dianjitijian
{
    
    
    if (KEY&&UID)
    {
        UILabel * lab1 = [self.view viewWithTag:101];
        UILabel * lab2 = [self.view viewWithTag:102];
        UILabel * lab3 = [self.view viewWithTag:103];
        UILabel * alab1 = [self.view viewWithTag:201];
        UILabel * alab2 = [self.view viewWithTag:202];
        UILabel * alab3 = [self.view viewWithTag:203];
        
        if ([dijige isEqualToString:@"1"])
        {
            WoDeBaoDanViewController * bandan = [WoDeBaoDanViewController new];
            bandan.tijian = @"tijian";
            
            bandan.tijianBlock = ^(DataModel * mod)
            {
                
                [downBtn setTitle:@"选择险种" forState:UIControlStateNormal];
                
                
                [touxiangImg sd_setImageWithURL:[NSURL URLWithString:mod.avatar] forState:UIControlStateNormal placeholderImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e62e", 70, wWhiteColor)]];
                
                
                NSLog(@"%@%@",mod.avatar,mod.sex);
                dijige = @"2";
                beibaorenSex = mod.sex;
                beibaorenId = mod.id;
                myimgs = mod.avatar;
                
                Amodel = mod;
                lab1.textColor = wBlackColor;
                lab2.textColor = wBlackColor;
                lab3.textColor = QIANZITIcolor;
                
                alab1.textColor = SHENLANSEcolor;
                alab2.textColor = SHENLANSEcolor;
                alab3.textColor = SHENLANSEcolor;
                
                
            };
            [self.navigationController pushViewController:bandan animated:YES];
        }
        
        
        if ([dijige isEqualToString:@"2"])
        {
            
            TianjiaxinxianzhongViewController * tianjia = [TianjiaxinxianzhongViewController new];
            
            tianjia.sex = beibaorenSex;
            tianjia.beibaoid = beibaorenId;
            tianjia.myimg = myimgs;
            tianjia.aModel = Amodel;
            
            [self.navigationController pushViewController:tianjia animated:YES];
            
        }
   
        
    }else
    {
      
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要去登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        
        [view show];
 
        
        
    }
    
    
   
    
    
    
}
-(void)diyibu
{
   
}
-(void)dierbu
{
    
    
}
-(void)disanbu
{
    
    
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
