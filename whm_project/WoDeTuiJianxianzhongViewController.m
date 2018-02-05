//
//  WoDeTuiJianxianzhongViewController.m
//  whm_project
//
//  Created by apple on 17/7/18.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WoDeTuiJianxianzhongViewController.h"
#import "liuyanViewController.h"
#import "WeizhanTableViewCell.h"
#import "ChanpinxiangqingViewController.h"
#import "XianZhongLieBiaoTuijinanViewController.h"

@interface WoDeTuiJianxianzhongViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString * tel;
    UITableView * myTab;
    NSMutableArray * allData;
    NSInteger numindex;
}
@end

@implementation WoDeTuiJianxianzhongViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"推荐险种";
    
    allData = [NSMutableArray array];
    [self creatLeftTtem];
    
    [self creatui];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [allData removeAllObjects];

    [self request];
}


-(void)creatui
{
        UIButton * aabutton =[UIButton buttonWithType:UIButtonTypeCustom];
        aabutton.frame=CGRectMake(0, 0, 40, 25);
        [aabutton setTitle:@"添加" forState:UIControlStateNormal];
    
        [aabutton setTitleColor:wWhiteColor forState:UIControlStateNormal];
        aabutton.backgroundColor = RGBwithColor(40, 210, 89);
        aabutton.titleLabel.font = Font(14);
        [aabutton addTarget:self action:@selector(tianji) forControlEvents:UIControlEventTouchUpInside];
    
        UIBarButtonItem *aanegativeSpacer =[[UIBarButtonItem alloc] initWithCustomView:aabutton];
        self.navigationItem.rightBarButtonItems = @[aanegativeSpacer];
    
    
      [self creattab];
}

-(void)tianji
{
    XianZhongLieBiaoTuijinanViewController * xianzhong = [XianZhongLieBiaoTuijinanViewController new];
       
    [self.navigationController pushViewController:xianzhong animated:YES];
}


-(void)creattab
{
    
  myTab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, wScreenW,wScreenH-64) style:UITableViewStylePlain];
    
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
    if (UID&&KEY)
    {
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        [dic setObject:[NSString stringWithFormat:@"%ld",numindex] forKey:@"p"];
        [dic setObject:@"20" forKey:@"pagesize"];
        
        [dic setObject:UID?UID:@"" forKey:@"agent_uid"];
        
        [WBYRequest wbyLoginPostRequestDataUrl:@"get_rec" addParameters:dic success:^(WBYReqModel *model) {
            
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
//                [allData removeAllObjects];
                
                [WBYRequest showMessage:model.info];
            }
            
            if (allData.count==0)
            {
                [weakSelf wushujuSecond];
            }
            
            [myTab reloadData];
            
        } failure:^(NSError *error) {
            
        }];
        
        
    }else
    {
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要去登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [view show];
    }
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
        cell.titLaber.text = model.short_name?model.short_name:model.name;
        cell.ageLaber.text = [NSString stringWithFormat:@"投保年龄:%@",model.limit_age_name?model.limit_age_name:@"暂无"];
        cell.chanpin.text = [NSString stringWithFormat:@"产品类型:%@",model.prod_type_code_name?model.prod_type_code_name:@"暂无"];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        DataModel * model = allData[indexPath.row];

        [self delectxianzhong:model.id?model.id:@""];
        
//        [allData removeObject:model];
    }
 }


-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return @"删除";
}



-(void)delectxianzhong:(NSString*)ids
{
    numindex=1;
    NSMutableDictionary* dic= [NSMutableDictionary dictionary];
    WS(weakSelf);
    [dic setObject:ids forKey:@"rec_ids"];
    [WBYRequest wbyLoginPostRequestDataUrl:@"del_rec" addParameters:dic success:^(WBYReqModel *model)
    {
        [WBYRequest showMessage:model.info];
        
        
        [weakSelf request];
    } failure:^(NSError *error) {
        
    }];
    
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (allData.count>=1)
    {
        DataModel * model = allData[indexPath.row];
        
        ChanpinxiangqingViewController * chanpin = [ChanpinxiangqingViewController new];
        
        chanpin.aid = model.pid;
        chanpin.logo = model.logo;
        [self.navigationController pushViewController:chanpin animated:YES];
        
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
