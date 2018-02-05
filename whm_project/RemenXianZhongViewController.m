//
//  RemenXianZhongViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/7/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RemenXianZhongViewController.h"
#import "XianzhongliebiaoTableViewCell.h"
#import "ChanpinxiangqingViewController.h"

@interface RemenXianZhongViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * myTab;
    NSMutableArray * allArr;
    NSInteger numindex;

    
}
@end

@implementation RemenXianZhongViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"热门险种";
    [self creatLeftTtem];
    allArr = [NSMutableArray array];
    numindex=1;
    
    [self requestData];
    [self creatTab];
}
-(void)creatTab
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 10)];
    
    view.backgroundColor = JIANGEcolor;
    
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, wScreenW, wScreenH - 64) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    [myTab   setSeparatorColor:FENGEXIANcolor];
    myTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [myTab registerClass:[XianzhongliebiaoTableViewCell class] forCellReuseIdentifier:@"cell"];
    myTab.rowHeight = 110;
    
    myTab.tableHeaderView = view;
//    [myTab addHeaderWithTarget:self action:@selector(headerRereshing)];
//    [myTab addFooterWithTarget:self action:@selector(footerRefreshing)];
    //    [myTab setSeparatorInset:UIEdgeInsetsZero];
    //    [myTab setLayoutMargins:UIEdgeInsetsZero];
    
    
    myTab.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    myTab.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
    [self.view addSubview:myTab];
    
    
}

#pragma mark===加载

-(void)headerRereshing
{
    numindex = 1 ;
    
    [self requestData];
    [myTab.mj_header  endRefreshing];
    
}
//下拉
-(void)footerRefreshing
{
    
    numindex ++ ;
    [self requestData];
    [myTab.mj_footer  endRefreshing];

    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return allArr.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XianzhongliebiaoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (allArr)
    {
        DataModel * data = allArr[indexPath.row];
        [cell.lImg sd_setImageWithURL:[NSURL URLWithString:data.img.length>8?data.img:data.logo]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.upLab.text = data.name;
        cell.midL.text = [NSString stringWithFormat:@"投保年龄:%@",data.limit_age_name.length > 1?data.limit_age_name:@"暂无"];  //limit_age_name
        cell.midR.text = [NSString stringWithFormat:@"产品类型:%@",data.pro_type_code_name.length >1 ?data.pro_type_code_name:@"暂无"];
//        NSArray * arr = [data.sign componentsSeparatedByString:@","];
//        
//        if (arr.count >= 1)
//        {
//            cell.downL.hidden = NO;
//            cell.downL.text = [arr firstObject];
//        }else
//        {
////            cell.downL.hidden = YES;
//            
//          cell.downL.text = @"暂无";
//            
//        }
        
        
        
        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==myTab)
    {
        XianzhongliebiaoTableViewCell * acell = (XianzhongliebiaoTableViewCell *)cell;
        acell.lImg.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1);
        
        [UIView animateWithDuration:0.8 animations:^{
            
            acell.lImg.layer.transform = CATransform3DMakeScale(1, 1, 1);
        }];
        
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (allArr.count>=1)
    {
        DataModel * data = allArr[indexPath.row];
        ChanpinxiangqingViewController * chanpin = [ChanpinxiangqingViewController new];
        chanpin.aModel = data;
        chanpin.aid = data.id;
        chanpin.logo = data.logo;
        
        [self.navigationController pushViewController:chanpin animated:YES];
    }
    
}



-(void)requestData
{
    WS(weakSelf);
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
   
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)numindex] forKey:@"p"];
    [dic setObject:@"20" forKey:@"pagesize"];
    
    [WBYRequest wbyPostRequestDataUrl:@"hot_pros" addParameters:dic success:^(WBYReqModel *model)
     {
         if ([model.err isEqualToString:TURE])
         {
             if (numindex == 1)
             {
                 [allArr removeAllObjects];
             }
             [allArr addObjectsFromArray:model.data];
             
             if (allArr.count==0)
             {
                 [WBYRequest showMessage:@"没事有数据"];
                 
                 [weakSelf wushuju];
             }
             
         }else{
             
             [WBYRequest showMessage:model.info];
         }
         
         [myTab reloadData];
     } failure:^(NSError *error) {
         
     } isRefresh:NO];
    
    
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
