//
//  WBYwdzwViewController.m
//  whm_project
//
//  Created by apple on 17/2/8.
//  Copyright © 2017年 chenJw. All rights reserved.
//
#import "WBYwdzwViewController.h"
#import "WBYcaiwuTableViewCell.h"
#import "WHjiluTableViewCell.h"
//#import "WHzhangwuListTableViewController.h"
//#import "WHtixianViewController.h"
//#import "WHshenheViewController.h"
#import "WBYKFPViewController.h"
//#import "WHgetcash.h"
#import "ShenHeTixianViewController.h"
#import "TixianjiemianViewController.h"
#import "WodetuijianliebiaoViewController.h"

@interface WBYwdzwViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * allArray;
//    NSArray * myArr;
    NSInteger numindex;
    NSInteger numindex1;
    UIView * caiwuView;
    UITableView *tableV;
    UILabel * moneyNum;
    UILabel * coinNum;
    UITableView * tableB;
    NSMutableArray * jiluArray;
    UIView* customView;
    UILabel * blackLaber;
    
}

@property(nonatomic,assign)BOOL isTuiJian;


@end

@implementation WBYwdzwViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
        allArray = [NSMutableArray array];
        numindex =  1;
        numindex1 =  1;
//        myArr = [NSArray array];
        jiluArray = [NSMutableArray array];
        _isTuiJian = YES;

//    [self creattuijianrenliebiao];;

    [self requestliebiao];
    [self creattopView];
    [self kaifapiao];
    
    [self caiwucreatLeftTtem];
    
}

-(void)kaifapiao
{


    
    
//    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame=CGRectMake(0, 0, 50, 30);
//
//    [button setTitle:@"发票" forState:UIControlStateNormal];
//    [button setTitleColor:wWhiteColor forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(fapiao) forControlEvents:UIControlEventTouchUpInside];
//    
//    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:button];
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:UID forKey:@"uid"];
   
    
    [WBYRequest wbyLoginPostRequestDataUrl:@"get_bill" addParameters:dic success:^(WBYReqModel *model)
    {
            if ([model.err isEqualToString:@"1400"])
            {
                self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发票" style:UIBarButtonItemStylePlain target:self action:@selector(fapiao)];
            }
 
        
    } failure:^(NSError *error) {
        
    }];
    

    
    
}
#pragma mark===开发票
-(void)fapiao
{
    
    WBYKFPViewController * kaifp = [[WBYKFPViewController alloc]init];
    [self.navigationController pushViewController:kaifp animated:YES];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBar.barTintColor = SHENLANSEcolor;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBar.barTintColor = wWhiteColor;
    
}


-(void)creattopView
{


    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, wScreenW, 44)];
    self.navigationItem.titleView = bgView;
    
    UISegmentedControl*segement=[[UISegmentedControl alloc] initWithItems:@[@"账务",@"记录"]];
    segement.frame =CGRectMake(0, 7, 120, 30);
    segement.center = CGPointMake(bgView.center.x-40, 15+7);
    
           segement.selectedSegmentIndex=0;

    segement.layer.borderColor=SHENLANSEcolor.CGColor;
    segement.layer.borderWidth=2;
    segement.tintColor = [UIColor whiteColor];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:SHENLANSEcolor,NSForegroundColorAttributeName,
                         [UIFont boldSystemFontOfSize:14],
                         NSFontAttributeName,nil];
    
    [segement setTitleTextAttributes:dic forState:UIControlStateSelected];
    
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:wWhiteColor,
                          NSForegroundColorAttributeName,
                          [UIFont boldSystemFontOfSize:14],
                          NSFontAttributeName,nil];
    
    [ segement setTitleTextAttributes:dic1 forState:UIControlStateNormal];
    [segement addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    
    [bgView addSubview:segement];
}

-(void)change:(UISegmentedControl*)segment
{
    NSInteger index=segment.selectedSegmentIndex;
    [tableB removeFromSuperview];
    [tableV removeFromSuperview];
    
    if (index==0)
    {
        _isTuiJian = YES;
        
        [self requestliebiao];
    }
    else
    {
        
        _isTuiJian = NO;
        [self creatRequest];

     }
    
    NSLog(@"===%ld",index);
}


-(void)creattuijianrenliebiao
{
    
        [tableB removeFromSuperview];
        [tableV removeFromSuperview];
    
    

    
            UIView * aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, (wScreenH-64)/3 )];
            UIImageView * jinQianImg = [[UIImageView alloc]init];
            jinQianImg.frame = CGRectMake(wScreenW * 0.21 , 20, wScreenW * 0.08, wScreenW * 0.08);
            jinQianImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e63c", 20, SHENLANSEcolor)];
            [aView addSubview:jinQianImg];
        moneyNum = [[UILabel alloc]init];
        moneyNum.frame = CGRectMake(wScreenW * 0.1, CGRectGetMaxY(jinQianImg.frame)+10, wScreenW * 0.3, CGRectGetHeight(jinQianImg.frame));
        moneyNum.text = _moneyStr;
        moneyNum.textColor = [UIColor redColor];
        moneyNum.textAlignment = NSTextAlignmentCenter;
        [aView addSubview:moneyNum];
        UILabel * lab1 = [[UILabel alloc]init];
        lab1.frame = CGRectMake(CGRectGetMidX(moneyNum.frame)+5, 8, 15, 10);
        lab1.text = @"元";
        lab1.textAlignment = NSTextAlignmentCenter;
        lab1.textColor =UIColorFromHex(0x666666);
        lab1.font = [UIFont systemFontOfSize:10];
        [moneyNum addSubview:lab1];
        UIButton * tiXianBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
        tiXianBut.frame = CGRectMake(wScreenW * 0.15, CGRectGetMaxY(moneyNum.frame)+10, wScreenW * 0.2, CGRectGetHeight(moneyNum.frame));
        [tiXianBut setTitle:@"提现" forState:(UIControlStateNormal)];
            tiXianBut.layer.masksToBounds = YES;
            tiXianBut.layer.cornerRadius = 5;
        [tiXianBut setTintColor:[UIColor whiteColor]];
        tiXianBut.backgroundColor =UIColorFromHex(0x28D68E);
        tiXianBut.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [tiXianBut addTarget:self action:@selector(tiXianAction) forControlEvents:(UIControlEventTouchUpInside)];
        [aView addSubview:tiXianBut];
        UILabel * line1 = [[UILabel alloc]init];
        line1.frame = CGRectMake(wScreenW * 0.5, 10, 1, CGRectGetHeight(aView.frame )-10 -20 );
            line1.backgroundColor =UIColorFromHex(0xF5F7F9);
         [aView addSubview:line1];
        //金币
        UIImageView *coinImg = [[UIImageView alloc]init];
        coinImg.frame = CGRectMake(wScreenW * 0.71, 20, wScreenW * 0.08, wScreenW * 0.08);
        coinImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e6b8", 20, SHENLANSEcolor)];
        [aView addSubview:coinImg];
        coinNum = [[UILabel alloc]init];
        coinNum.frame = CGRectMake(wScreenW * 0.6, CGRectGetMaxY(coinImg.frame)+10, wScreenW * 0.3, CGRectGetHeight(coinImg.frame));
        coinNum.text = @"0";
        coinNum.textColor = [UIColor redColor];
        coinNum.textAlignment = NSTextAlignmentCenter;
        [aView addSubview:coinNum];
        UILabel * lab2 = [[UILabel alloc]init];
        lab2.frame = CGRectMake(CGRectGetMaxX(coinNum.frame)-20, CGRectGetMinY(coinNum.frame)+8, 30, 10);
        lab2.text = @"金币";
            lab2.textColor =UIColorFromHex(0x666666);

        lab2.font = [UIFont systemFontOfSize:10];
        [aView addSubview:lab2];
    
    
        UIButton * coinBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
        coinBut.frame = CGRectMake(wScreenW * 0.65, CGRectGetMaxY(coinNum.frame)+10, wScreenW * 0.2, CGRectGetHeight(coinNum.frame));
        [coinBut setTitle:@"兑换" forState:(UIControlStateNormal)];
        [coinBut setTintColor:[UIColor whiteColor]];
        coinBut.backgroundColor = [UIColor grayColor];
        coinBut.titleLabel.font = [UIFont systemFontOfSize:13.0];
            coinBut.layer.masksToBounds =  YES;
            coinBut.layer.cornerRadius = 5;
    
        [coinBut addTarget:self action:@selector(coinAction) forControlEvents:(UIControlEventTouchUpInside)];
        [aView addSubview:coinBut];
        UILabel * line2 = [[UILabel alloc]init];
        line2.frame = CGRectMake(0, CGRectGetMaxY(line1.frame)+10, wScreenW, 1);
        line2.backgroundColor =UIColorFromHex(0xF5F7F9);
        [aView addSubview:line2];
    
            blackLaber = [[UILabel alloc]init];
            blackLaber.frame = CGRectMake(0, CGRectGetMaxY(line2.frame), wScreenW, CGRectGetMaxY(aView.frame)-CGRectGetMaxY(line2.frame));
            blackLaber.backgroundColor=UIColorFromHex(0xF5F7F9);
 
            [aView addSubview:blackLaber];
    
            
            tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH - 64) style:UITableViewStylePlain];
                tableV.delegate = self;
                tableV.dataSource = self;
    tableV.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    tableV.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
               [tableV registerClass:[WBYcaiwuTableViewCell class] forCellReuseIdentifier:@"cell"];
               tableV.tableHeaderView =aView;
            
                tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
                [self.view addSubview:tableV];
//      }
//        else
//        {
//            [tableV removeFromSuperview];
//           
//        }
}
-(void)headerRereshing
{
    if (_isTuiJian==YES)
    {    numindex = 1 ;
        
        [self creattuijianrenliebiao];
        
    }
    else
    {    numindex1 = 1;
        
        [self creatRequest];
        
    }
    
    [tableV.mj_header endRefreshing];
    [tableB.mj_header endRefreshing];
    
}
//下拉
-(void)footerRefreshing
{
    if (_isTuiJian==YES)
    {
        numindex ++ ;
        
           [self creattuijianrenliebiao];

    }
    else
    {
        numindex1 ++;
        
        [self creatRequest];
        
    }
    [tableV.mj_footer endRefreshing];
    [tableB.mj_footer endRefreshing];
}

#pragma mark====代理方法 数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == tableV)
    {
        return allArray.count;
    }
    else
    {
        return jiluArray.count;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tableV)
    {
        return 70;
    }else
    {
        return 60;}
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == tableV)
    {
        return 44.0;
    }else
    {
        return 0;}
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (tableView == tableV)
    {
        
        
        customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, wScreenW, 40.0)];
        
        customView.backgroundColor = wWhiteColor;
        if (section == 0) {
            
            
            UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero] ;
//            headerLabel.backgroundColor = [UIColor clearColor];
//            headerLabel.opaque = NO;
            headerLabel.textColor = wBlackColor;
//            headerLabel.highlightedTextColor = [UIColor whiteColor];
            headerLabel.font = Font(18);
            headerLabel.frame = CGRectMake(10, 2, wScreenW-20, 36.0);
            headerLabel.text = @"我的推荐";
            
            [customView addSubview:headerLabel];
            
            UILabel * line3 = [[UILabel alloc]init];
            line3.frame = CGRectMake(0, 0, wScreenW, 1);
            line3.backgroundColor = UIColorFromHex(0xF5F7F9) ;
            [customView addSubview:line3];
            UILabel * line4 = [[UILabel alloc]init];
            line4.frame = CGRectMake(0, 38, wScreenW, 1);
            line4.backgroundColor = UIColorFromHex(0xF5F7F9);
            [customView addSubview:line4];
        }
        
        
        return customView;
    }
    else
    {
        [customView removeFromSuperview];
        return nil;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tableB)
    {
        WHjiluTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        DataModel * model = jiluArray[indexPath.row];
        
        cell.moneyLaber.textAlignment = 1;
        cell.daiLiLaber.textAlignment = 1;
        
        if ([model.type isEqualToString:@"1"])
        {
            cell.headImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e647", 20,Wqingse)];
            cell.moneyLaber.text =[NSString stringWithFormat:@"%@元",model.money];
            cell.myTitLaber.text = model.remark;
            cell.daiLiLaber.textColor = [UIColor cyanColor];
            cell.daiLiLaber.text = @"代理人已认证";
            cell.timeLaber.text = [NSString stringWithFormat:@"时间: %@",[WBYRequest timeStr:model.create_time?model.create_time:@""]];
            
            
        }else if ([model.type isEqualToString:@"2"])
        {
            cell.headImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e6b8", 20, SHENLANSEcolor)];
            cell.moneyLaber.text =[NSString stringWithFormat:@"%@金币",model.money];
            cell.myTitLaber.text = model.remark;
            cell.daiLiLaber.textColor = [UIColor cyanColor];
            cell.daiLiLaber.text = @"代理人已认证";
            cell.timeLaber.text = [NSString stringWithFormat:@"时间: %@",[WBYRequest timeStr:model.create_time?model.create_time:@""]];
            
        }else if ([model.type isEqualToString:@"3"])
        {
            cell.myTitLaber.text = model.remark;
            cell.moneyLaber.text =[NSString stringWithFormat:@"%@元",model.money];
            cell.timeLaber.text = [NSString stringWithFormat:@"时间: %@",[WBYRequest timeStr:model.create_time?model.create_time:@""]];
            if ([model.status isEqualToString:@"1"])
            {
                cell.headImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e63d", 20, Wqingse)];
                cell.daiLiLaber.text = @"成功提现";
                cell.daiLiLaber.textColor = Wqingse;
                
            }else if ([model.status isEqualToString:@"2"])
            {            cell.headImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e6cb", 20, RGBwithColor(255, 186, 0))];

                cell.daiLiLaber.text = @"提现申请中";
                cell.daiLiLaber.textColor = RGBwithColor(255, 186, 0);
                
                
            }else
            {     cell.headImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e63d", 20,Wqingse)];;
                cell.daiLiLaber.text = @"已汇款80%";
                cell.daiLiLaber.textColor = Wqingse;
            }
            
        }else
        {
            cell.headImg.image = [UIImage imageNamed:@"aascxf"];
            cell.moneyLaber.text =[NSString stringWithFormat:@"%@金币",model.money];
            cell.myTitLaber.text = model.remark;
            cell.daiLiLaber.textColor = [UIColor redColor];
            cell.daiLiLaber.text = @"商城消费使用";
            cell.timeLaber.text = [NSString stringWithFormat:@"时间%@",[WBYRequest timeStr:model.create_time?model.create_time:@""]];
        }
        return cell;
        
    }
    else
    {
        WBYcaiwuTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        DataModel * mod= allArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLaber.text = mod.name?mod.name:@"暂无";
        cell.dateLaber.text = mod.birthday;
        [cell.headImg sd_setImageWithURL:[NSURL URLWithString:mod.avatar] placeholderImage:[UIImage imageNamed:@"city"]];
        NSString * b = mod.type;
        
        if ([b isEqualToString:@"0"])
        {
            cell.renzhengLaber.text = @"普通用户";
        }
        else{
            if ([mod.status isEqualToString:@"0"]) {
                cell.renzhengLaber.text = @"未认证";
            }
            else if ([mod.status isEqualToString:@"1"])
            {
                cell.renzhengLaber.text = @"已认证";
            }
            else if ([mod.status isEqualToString:@"2"])
            {
                cell.renzhengLaber.text = @"认证驳回";
            }
            else
            {
                cell.renzhengLaber.text = @"审核中";
            }
        }
        NSInteger  c = [mod.rec_count integerValue];
        if (c <= 99)
        {
            cell.tuiJianLaber.text = [NSString stringWithFormat:@"推荐\n%@",mod.rec_count];
        }
        else
        {
            cell.tuiJianLaber.text = @"推荐\n99+";
        }
        cell.telLaber.text = mod.mobile?mod.mobile :@"暂无";
        return cell;
        
        
    }    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    if (tableView == tableB)
    {
         TixianjiemianViewController * tixian = [TixianjiemianViewController new];
        DataModel * model = jiluArray[indexPath.row];
        tixian.aModel = model;
        [self.navigationController pushViewController:tixian animated:YES];

    }else
    {
        WodetuijianliebiaoViewController * tixian = [WodetuijianliebiaoViewController new];
        DataModel * model = allArray[indexPath.row];
        tixian.aModel = model;
        [self.navigationController pushViewController:tixian animated:YES];
  
        
       
    }
    
}



#pragma mark===提现
-(void)tiXianAction
{
    ShenHeTixianViewController * shenhe = [ShenHeTixianViewController new];
    
    shenhe.money = _moneyStr;
    
    [self.navigationController pushViewController:shenhe animated:YES];
}

#pragma mark
-(void)coinAction
{
    
}

#pragma mark===推荐人列表

-(void)requestliebiao
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    [dic setObject:UID forKey:@"uid"];
    
    WS(weakSelf);
    [WBYRequest wbyLoginPostRequestDataUrl:@"get_rec_user" addParameters:dic success:^(WBYReqModel *model)
     {
         
         [weakSelf.beijingDateView removeFromSuperview];
         if ([model.err isEqualToString:TURE])
         {
             if (numindex == 1)
             {
                 [allArray removeAllObjects];
             }
             [allArray addObjectsFromArray:model.data];
             

         }
         [weakSelf creattuijianrenliebiao];

         
         
         
         
         
     } failure:^(NSError *error) {
         
     }];
    
    
    
    
}


#pragma mark===财务记录

-(void)creatRequest
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:UID forKey:@"uid"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)numindex] forKey:@"p"];
    [dic setObject:@"10" forKey:@"pagesize"];
    
    WS(weakSelf);
    [WBYRequest wbyLoginPostRequestDataUrl:@"get_finance" addParameters:dic success:^(WBYReqModel *model)
    {
        if ([model.err isEqualToString:TURE])
        {
            if (numindex == 1)
            {
                [jiluArray removeAllObjects];
            }
            [jiluArray addObjectsFromArray:model.data];
              [weakSelf creatcaiwujilu];
           
        }

        //         if (allArray.count<1)
        //         {
        //
        //             [weakSelf wushuju];
        //         }
 
        
        
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)creatcaiwujilu
{
    [tableB removeFromSuperview];
    [tableV removeFromSuperview];
    
    
    if (jiluArray.count >= 1)
    {
        //DataModel * mod = jiluArray[0];
        tableB = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH - 64) style:UITableViewStylePlain];
        tableB.delegate = self;
        tableB.dataSource = self;
                
        tableB.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
        tableB.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];

        [tableB registerClass:[WHjiluTableViewCell class] forCellReuseIdentifier:@"cell1"];
        [tableB setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        [self.view addSubview:tableB];
        
    }else
    {
        [WBYRequest showMessage:@"没有数据"];
    }
  
    
}





@end
