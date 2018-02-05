//
//  WodeViewController.m
//  MYTEXT
//
//  Created by apple on 17/5/11.
//  Copyright © 2017年 apple. All rights reserved.


#import "WodeViewController.h"
#import "WodeTableViewCell.h"
#import "YaoqingViewController.h"
#import "ShezhiViewController.h"
#import "GuanyuwomenViewController.h"
#import "WodeguanzhuViewController.h"
#import "ZhanghuxiangqingViewController.h"
#import "DailirenzhengxinxiViewController.h"
#import "WoDeBaoDanViewController.h"
#import "WBYwdzwViewController.h"
#import "WeizhantuijianViewController.h"
#import "MyTabbarviewconstrerViewController.h"


@interface WodeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * myTab;
    NSArray * imgArr;
    NSArray * textArr;
    NSArray * myArr;
    
    NSArray * renzhengArr;
}
@end

@implementation WodeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = wWhiteColor;
    myArr = [NSArray array];
    imgArr = @[@"\U0000e626",@"\U0000e60b",@"\U0000e627",@"\U0000e61d"];
    textArr = @[@"我的关注",@"邀请有奖",@"关于我们",@"设置"];
    renzhengArr = [NSArray array];


}


-(void)creatupview
{
    [myTab removeFromSuperview];
    
    UIImageView * myImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, wScreenW,200)];
    myImg.image = [UIImage imageNamed:@"dabeijing"];
    myImg.userInteractionEnabled = YES;
//    [self.view addSubview:myImg];
    
    UIButton * myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    myBtn.frame = CGRectMake(6.5, 28+2.5, 50, 50);
    myBtn.layer.masksToBounds = YES;
    myBtn.layer.cornerRadius = 25;
    [myBtn addTarget:self action:@selector(touxiang) forControlEvents:UIControlEventTouchUpInside];
    
    [myImg addSubview:myBtn];
    
    UILabel * upMidLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(myBtn.frame)+6.5, 28+8, wScreenW/2, 20)];
    upMidLab.font = Font(16);
    upMidLab.textColor = wWhiteColor;
    [myImg addSubview:upMidLab];
    
    UIView * downMidview = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(myBtn.frame)+6.5, CGRectGetMaxY(upMidLab.frame), wScreenW*0.42, 20)];
    [myImg addSubview:downMidview];
    
    
    UILabel * denglukekan = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, wScreenW*0.42, 20)];
    denglukekan.textColor = QIANLANSEcolor;
    denglukekan.font = Font(12);
    [downMidview addSubview:denglukekan];
    
    
    
    UIImageView * rImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    rImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e629", 20, QIANLANSEcolor)];
    [downMidview addSubview:rImg];
    
    UILabel * baojianLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(rImg.frame)+6.5,0,65,20)];
 

    baojianLab.textColor = QIANLANSEcolor;
    baojianLab.font = Font(10);
    [downMidview addSubview:baojianLab];
    
    UIImageView * lImg = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(baojianLab.frame)+6.5, 0, 20, 20)];
    lImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e62c", 20, QIANLANSEcolor)];
    [downMidview addSubview:lImg];
    
    UILabel * rLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lImg.frame)+3, 0, 65,20)];
    rLab.font = Font(10);
       rLab.textColor = QIANLANSEcolor;
    [downMidview addSubview:rLab];
    
    
    UIButton * rrBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rrBtn.frame = CGRectMake(wScreenW - 70, 28+5, 70+22.5, 45);
    rrBtn.layer.masksToBounds = YES;
    rrBtn.layer.cornerRadius = 45/2;
    rrBtn.backgroundColor = RGBwithColor(65, 147, 227);
//    114 181 237 65 147 227
    rrBtn.layer.borderColor = RGBwithColor(114, 181, 237).CGColor;
    rrBtn.layer.borderWidth = 0.5;
    rrBtn.titleLabel.font = Font(13);
    [rrBtn setTitleColor:wWhiteColor forState:UIControlStateNormal];
    [rrBtn addTarget:self action:@selector(dailirenzheng:) forControlEvents:UIControlEventTouchUpInside];
    rrBtn.titleEdgeInsets = UIEdgeInsetsMake(0,-10, 0, 5);
    
    [myImg addSubview:rrBtn];
    
    UILabel * midlab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW/2, 200-60-25, 1, 60)];
    midlab.backgroundColor = RGBwithColor(107, 175, 236);
    [myImg addSubview:midlab];
    
    UIButton * oneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    oneBtn.frame = CGRectMake(0, 200-25-55, wScreenW/2, 50);
    [oneBtn addTarget:self action:@selector(beibaoren) forControlEvents:UIControlEventTouchUpInside];
    
    [myImg addSubview:oneBtn];
    
    
    UIButton * twoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    twoBtn.frame = CGRectMake(wScreenW/2, 200-25-55, wScreenW/2, 50);
    [twoBtn addTarget:self action:@selector(caiwuguanli) forControlEvents:UIControlEventTouchUpInside];
    
    [myImg addSubview:twoBtn];
    
    UILabel * ldaLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 200-25-55, wScreenW/2, 35)];
    ldaLab.font = Font(30);
    ldaLab.textColor = wWhiteColor;
    ldaLab.textAlignment = 1;
    
    [myImg addSubview:ldaLab];
  
    UILabel * downLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(ldaLab.frame), wScreenW/2,15)];
    downLab.font = [UIFont systemFontOfSize:14];
    
    downLab.textAlignment = 1;
    downLab.textColor = wWhiteColor;
    [myImg addSubview:downLab];
    
    
    
    
    UILabel * rdaLab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW/2, 200-25-55, wScreenW/2, 35)];
    rdaLab.font = Font(30);
    rdaLab.textColor = wWhiteColor;
    rdaLab.textAlignment = 1;
   
    [myImg addSubview:rdaLab];
  
    
    UILabel * rdownLab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW/2, CGRectGetMaxY(rdaLab.frame), wScreenW/2,15)];
    rdownLab.font = [UIFont systemFontOfSize:14];
    rdownLab.textAlignment = 1;
    rdownLab.textColor = wWhiteColor;
    [myImg addSubview:rdownLab];
    
    downLab.text = @"被保人及保单";
    rdownLab.text = @"账务管理(元)";
    
    
    NSString * key = KEY;
    NSString * type = TYPE;
    
    if (myArr.count>=1||key.length>5)
    {
        DataModel * data = [myArr firstObject];
        denglukekan.hidden = YES;
        upMidLab.text = data.name;
        [myBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:data.avatar] forState:UIControlStateNormal placeholderImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e625", 25, wWhiteColor)]];
        ldaLab.text = data.rela_count?data.rela_count:@"0";
        rdaLab.text = data.money?data.money:@"0";
        
        if ([type isEqualToString:@"0"])
        {
            [rrBtn setTitle:@"代理认证" forState:UIControlStateNormal];
            baojianLab.text = @"保监会未认证";
            rLab.text = @"快保家未认证";
            
        }else
        {
 
            if ([RENZHENGZHUANGTAI isEqualToString:@"0"])
            {
                [rrBtn setTitle:@"代理认证" forState:UIControlStateNormal];
                baojianLab.text = @"保监会未认证";
                rLab.text = @"快保家未认证";
                
            }else if ([RENZHENGZHUANGTAI isEqualToString:@"1"])
            {
                [rrBtn setTitle:@"我的微站" forState:UIControlStateNormal];
                rrBtn.backgroundColor = UIColorFromHex(0xFFF607);
                [rrBtn setTitleColor:SHENLANSEcolor forState:UIControlStateNormal];
                baojianLab.textColor = wWhiteColor;
                rLab.textColor = wWhiteColor;
                baojianLab.text = @"保监会认证";
                rLab.text = @"快保家认证";
                
            }else if ([RENZHENGZHUANGTAI isEqualToString:@"2"])
            {
                [rrBtn setTitle:@"认账驳回" forState:UIControlStateNormal];
                baojianLab.text = @"保监会未认证";
                rLab.text = @"快保家未认证";
                
            }else if ([RENZHENGZHUANGTAI isEqualToString:@"3"])
            {
                [rrBtn setTitle:@"审核中" forState:UIControlStateNormal];
                baojianLab.text = @"保监会未认证";
                rLab.text = @"快保家审核中";
            }
         }
        
    }else
    {
        [myBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal placeholderImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e625", 25, wWhiteColor)]];

        
        upMidLab.text = @"未登录";
        ldaLab.text = @"0";
        rdaLab.text = @"0";
        [rrBtn setTitle:@"立即登录" forState:UIControlStateNormal];
        baojianLab.hidden = YES;
        rLab.hidden = YES;
        
        rImg.hidden = YES;
        lImg.hidden = YES;
        denglukekan.text = @"登录后可查看认证状态";
        
    }
    
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0,20, wScreenW, wScreenH - 20 ) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    myTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [myTab registerClass:[WodeTableViewCell class] forCellReuseIdentifier:@"cell"];
    myTab.backgroundColor = JIANGEcolor;
    myTab.separatorColor = FENGEXIANcolor;
    myTab.bounces = NO;
    myTab.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:myTab];
    
    myTab.tableHeaderView = myImg;
    
    [myTab setSeparatorInset:UIEdgeInsetsZero];
    [myTab setLayoutMargins:UIEdgeInsetsZero];    
    
}

-(void)dailirenzheng:(UIButton*)btn
{
    
    if (myArr.count>=1)
    {
        NSLog(@"====%@",btn.titleLabel.text);
        if ([btn.titleLabel.text isEqualToString:@"代理认证"]||[btn.titleLabel.text isEqualToString:@"审核中"])
        {
            DataModel * mod = [renzhengArr firstObject];
            DailirenzhengxinxiViewController * daili = [DailirenzhengxinxiViewController new];
            daili.aModel = mod;
            [self.navigationController pushViewController:daili animated:YES];
            
         }else if([btn.titleLabel.text isEqualToString:@"我的微站"])
        {
            WeizhantuijianViewController * tuijian = [WeizhantuijianViewController new];
            [self.navigationController pushViewController:tuijian animated:YES];
        }
        
    }
    else
    {
        
        if ([btn.titleLabel.text isEqualToString:@"立即登录"])
        {
            
            [self goLogin];
            
        }
        
    }
    
}




//被保人

-(void)beibaoren
{
        if (KEY&&UID)
        {
            WoDeBaoDanViewController * daili = [WoDeBaoDanViewController new];
            [self.navigationController pushViewController:daili animated:YES];
        }
       else
        {
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要去登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
               [view show];
        }
   
}
//财务管理
-(void)caiwuguanli
{
    if (KEY&&UID&&myArr.count>=1)
    {
        DataModel * data = [myArr firstObject];
        WBYwdzwViewController * daili = [WBYwdzwViewController new];
        daili.moneyStr = data.money?data.money:@"0";
        [self.navigationController pushViewController:daili animated:YES];
        
    }
    else
    {
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要去登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [view show];
    }

    
    
}


-(void)touxiang
{
    if (KEY&&UID)
    {
        ZhanghuxiangqingViewController * zhanghu = [ZhanghuxiangqingViewController new];
        [self.navigationController pushViewController:zhanghu animated:YES];
        
    }
    else
    {
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要去登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [view show];
    }
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return HANGGAO;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * aView;
    
    if (!aView)
    {
        aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 10)];
        aView.backgroundColor = JIANGEcolor;
    }
    
    return aView;
 
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WodeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.lefLab.font = daFont;
    cell.lefLab.textColor = wBlackColor;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section==0)
    {
        cell.myImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(imgArr[indexPath.row],25,SHENLANSEcolor)];
        cell.lefLab.text = textArr[indexPath.row];
        
    }else
    {
        cell.myImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(imgArr[indexPath.row+2],25,SHENLANSEcolor)];
        cell.lefLab.text = textArr[indexPath.row+2];
    }
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        
        if (KEY&&UID)
        {
            if (indexPath.row==0)
            {
                [self.navigationController pushViewController:[WodeguanzhuViewController new] animated:YES];
            }else
            {
                [self.navigationController pushViewController:[YaoqingViewController new] animated:YES];
            }
            
        }
        else
        {
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要去登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [view show];
        }
        
    }else
    {
        if (indexPath.row==0)
        {
           [self.navigationController pushViewController:[GuanyuwomenViewController new] animated:YES];
        }else
        {
            
            if (KEY&&UID&&myArr.count>=1)
            {
                DataModel * model = [myArr firstObject];
                ShezhiViewController * shezhi = [ShezhiViewController new];
                shezhi.perMod = model;
                [self.navigationController pushViewController:shezhi animated:YES];
                
            }
            else
            {
                UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要去登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [view show];
            }
    }
     }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self dailirenzhengrequest];
    [self creatrequestData];

    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
-(void)dailirenzhengrequest
{
    
//    if (KEY&&UID)
//    {
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        
        [WBYRequest wbyLoginPostRequestDataUrl:@"get_verify" addParameters:dic success:^(WBYReqModel *model)
         {
             if ([model.err isEqualToString:TURE])
             {
                 renzhengArr = model.data;
             }
             
//             if ([model.err isEqualToString:SAME])
//                         {
//                             UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要去登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//             
//                             [view show];
//                         }
//             
             
             
             [myTab reloadData];
         } failure:^(NSError *error) {
             
         }];
//    }
    
//    else
//    {
//        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要去登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        
//        [view show];
//    }

}

-(void)creatrequestData
{
    
    WS(weakSelf);
//    if (KEY&&UID)
//    {
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        [WBYRequest wbyLoginPostRequestDataUrl:@"get_user" addParameters:dic success:^(WBYReqModel *model)
         {
            if ([model.err isEqualToString:TURE])
            {
                myArr = model.data;
                
                DataModel * user = [model.data firstObject];
                NSUserDefaults * stand = [NSUserDefaults standardUserDefaults];
                [stand setObject:user.status forKey:@"renzhengzhuangtai"];
                [stand setObject:user.type forKey:@"type"];
                [stand synchronize];

            }
             

             if ([model.err isEqualToString:SAME])
             {
                 NSUserDefaults * defau = [NSUserDefaults standardUserDefaults];
                 
                 [defau removeObjectForKey:@"key"];
                 [defau removeObjectForKey:@"uid"];
                 [defau removeObjectForKey:@"xingming"];
                 [defau removeObjectForKey:@"type"];
                 [defau removeObjectForKey:@"renzhengzhuangtai"];
                 [defau removeObjectForKey:@"renzhengmingzi"];
                 [defau synchronize];

                 [WBYRequest showMessage:model.info];
                
                 [weakSelf goLogin];
                 
             }
             
             [weakSelf creatupview];


        } failure:^(NSError *error) {
            
        }];
 
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        [self goLogin];
        
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
