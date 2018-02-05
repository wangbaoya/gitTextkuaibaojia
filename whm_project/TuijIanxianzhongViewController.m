//
//  TuijIanxianzhongViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TuijIanxianzhongViewController.h"
#import "liuyanViewController.h"
#import "WeizhanTableViewCell.h"
#import "ChanpinxiangqingViewController.h"

@interface TuijIanxianzhongViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString * tel;
    UITableView * myTab;
    NSMutableArray * allData;
    NSInteger numindex;    
}
@end

@implementation TuijIanxianzhongViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"推荐险种";
    
    allData = [NSMutableArray array];
    [self creatLeftTtem];
    [self request];
    [self creatui];
}
-(void)creatui
{
    
    if (_weizhanjin==666)
    {
        
    }else
    {
        DataModel * data =[_allArr firstObject];
        
        UIView * topview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 70)];
        topview.backgroundColor = JIANGEcolor;
        [self.view addSubview:topview];
        
        UIButton * litview = [UIButton buttonWithType:UIButtonTypeCustom];
        litview.frame = CGRectMake(0, 10, wScreenW, 60);
        litview.backgroundColor = wWhiteColor;
        [topview addSubview:litview];
        
        UIImageView * aimg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        aimg.layer.masksToBounds = YES;
        aimg.layer.cornerRadius = 20;
        
        [litview addSubview:aimg];
        
        UILabel * nameLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(aimg.frame)+10, 10, 80, 20)];
        nameLab.textColor = wBlackColor;
        nameLab.font = ZT14;
        [litview addSubview:nameLab];
        
        UILabel * xiangqingLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(aimg.frame)+10, CGRectGetMaxY(nameLab.frame), wScreenW - 10-10-40-70-10, 20)];
        xiangqingLab.font = ZT12;
        xiangqingLab.textColor = QIANZITIcolor;
        
        NSInteger nianling = [WBYRequest getAge:data.agent_info.birthday];
        
        
        [litview addSubview:xiangqingLab];
        
        
        [aimg sd_setImageWithURL:[NSURL URLWithString:data.agent_info.avatar] placeholderImage:[UIImage imageNamed:@"city"]];
        xiangqingLab.text = [NSString stringWithFormat:@"%@ %ld岁 %@ %@",[data.agent_info.sex isEqualToString:@"1"]?@"男":@"女",nianling,data.agent_info.cityn,data.agent_info.cname];
        nameLab.text = data.agent_info.name;
        
        
        
        UIView * rView = [[UIView alloc] initWithFrame:CGRectMake(wScreenW-90,0, 90, 60)];
        [litview addSubview:rView];
        
        NSArray * imgArr = @[@"\U0000e62d",@"\U0000e628"];        
        
        for (NSInteger i=0; i<imgArr.count; i++)
        {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame= CGRectMake((30+10)*(i%3),15, 30, 30);
            [btn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(imgArr[i], 30,[UIColor orangeColor])] forState:UIControlStateNormal];
            btn.tag = 666+i;
            [btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
            [rView addSubview:btn];
        }
    }
    [self creattab];
}

-(void)creattab
{
    
    if (_weizhanjin==666)
    {
        myTab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, wScreenW,wScreenH-64) style:UITableViewStylePlain];
    }else
    {
        myTab = [[UITableView alloc] initWithFrame:CGRectMake(0,70, wScreenW,wScreenH-64-70) style:UITableViewStylePlain];
    }
    
    myTab.delegate = self;
    myTab.dataSource = self;
    myTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    myTab.separatorColor = FENGEXIANcolor;
    [myTab registerClass:[WeizhanTableViewCell class] forCellReuseIdentifier:@"cell"];
    myTab.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    myTab.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];

    [myTab setSeparatorInset:UIEdgeInsetsZero];
    [myTab setLayoutMargins:UIEdgeInsetsZero];
    [self.view addSubview:myTab];
    
    myTab.tableFooterView = [UIView new];
}
-(void)headerRereshing
{
    numindex = 1 ;
    
    [self request];
    [myTab.mj_header endRefreshing];
    
}
//下拉
-(void)footerRefreshing
{
    
    numindex ++ ;
    [self request];
    [myTab.mj_footer endRefreshing];
    
}

-(void)request
{
    WS(weakSelf);
//    DataModel * data =[_allArr firstObject];

    
//    if (UID&&KEY)
//    {
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        [dic setObject:[NSString stringWithFormat:@"%ld",numindex] forKey:@"p"];
        [dic setObject:@"10" forKey:@"pagesize"];
        [dic setObject:_myuid?_myuid:@"" forKey:@"agent_uid"];
    
    
    
    [WBYRequest wbyPostRequestDataUrl:@"get_rec" addParameters:dic success:^(WBYReqModel *model)
     {
         [weakSelf.beijingDateView removeFromSuperview];
         
         if ([model.err isEqualToString:TURE])
         {
             if (numindex == 1)
             {
                 [allData removeAllObjects];
             }
             [allData addObjectsFromArray:model.data];
             
         }else if ([model.err isEqualToString:@"1400"])
         {
             
             [WBYRequest showMessage:model.info];
         }
         
         if (allData.count==0)
         {
             [weakSelf wushujuSecond];
         }
         
         [myTab reloadData];

         
    } failure:^(NSError *error) {
        
    } isRefresh:NO];
    
    
    
        
//        [WBYRequest wbyLoginPostRequestDataUrl:@"get_rec" addParameters:dic success:^(WBYReqModel *model) {
//            
//            [weakSelf.beijingDateView removeFromSuperview];
//            
//            if ([model.err isEqualToString:TURE])
//            {
//                if (numindex == 1)
//                {
//                    [allData removeAllObjects];
//                }
//                [allData addObjectsFromArray:model.data];
//                
//            }else if ([model.err isEqualToString:@"1400"])
//            {
//                
//                [WBYRequest showMessage:model.info];
//            }
//            
//            if (allData.count==0)
//            {
//                [weakSelf wushujuSecond];
//            }
//            
//            [myTab reloadData];
//            
//        } failure:^(NSError *error) {
//            
//        }];
//   
//    
//    }else
//    {
//        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要去登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        
//        [view show];
//    }



 }





-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return allData.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 90;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        WeizhanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (allData.count>=1)
        {
            DataModel * model = allData[indexPath.row];
            [cell.companyImage sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"city"]];
            cell.titLaber.text = model.short_name.length>=1?model.short_name:model.name;
            cell.ageLaber.text = [NSString stringWithFormat:@"投保年龄:%@",model.limit_age_name.length>=1?model.limit_age_name:@"暂无"];
            cell.chanpin.text = [NSString stringWithFormat:@"产品类型:%@",model.prod_type_code_name.length>=1?model.prod_type_code_name:@"暂无"];
        }
        return cell;
}

-(void)onClick:(UIButton*)btn
{
    DataModel * dataModel =[_allArr firstObject];

    if (btn.tag==666)
    {
        //    留言
        NSString * token = KEY;
        
        if (token.length>5)
        {
            liuyanViewController * liuyan = [liuyanViewController new];
            liuyan.jieshourenid = dataModel.agent_info.uid;
            [self.navigationController pushViewController:liuyan animated:YES];
        }else
        {
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要登陆" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [view show];
            
        }
    }else
    {
        //    电话
        if ([WBYRequest isMobileNumber:dataModel.agent_info.mobile])
        {
            tel = dataModel.agent_info.mobile;
            
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要拨打电话" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            view.tag = 6868;
            [view show];
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==6868)
    {
        if (buttonIndex==1)
        {
            NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",tel];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
    }else{
        
        if (buttonIndex==1)
        {
            [self goLogin];
        }else
        {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        DataModel * model = allData[indexPath.row];
        ChanpinxiangqingViewController * chanpin = [ChanpinxiangqingViewController new];
    
        chanpin.aid = model.pid;
        chanpin.logo = model.logo;
        [self.navigationController pushViewController:chanpin animated:YES];
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
