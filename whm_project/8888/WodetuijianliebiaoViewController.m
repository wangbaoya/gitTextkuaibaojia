//
//  WodetuijianliebiaoViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WodetuijianliebiaoViewController.h"
#import "WBYcaiwuTableViewCell.h"

@interface WodetuijianliebiaoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * allArray;
    //    NSArray * myArr;
    NSInteger numindex;
    UITableView * tableV;
}
@end

@implementation WodetuijianliebiaoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatLeftTtem];
    allArray = [NSMutableArray array];
    numindex =  1;

    self.title = [NSString stringWithFormat:@"%@的推荐",_aModel.name] ;
    [self requestliebiao];
    [self creattab];
}

-(void)creattab
{
    tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH - 64) style:UITableViewStylePlain];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    tableV.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];

    [tableV registerClass:[WBYcaiwuTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableV];
  
    
    
}

-(void)headerRereshing
{
       numindex = 1 ;
        
        [self requestliebiao];
        
    
    [tableV.mj_header endRefreshing];
    
}
//下拉
-(void)footerRefreshing
{
   
        numindex ++ ;
        
    
        [self requestliebiao];
        
   
    [tableV.mj_footer endRefreshing];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
        return allArray.count;
       
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        return 70;
    
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
//    WBYcaiwuTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    
//    DataModel * mod= allArray[indexPath.row];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    
//    cell.nameLaber.text = mod.name;
//    cell.dateLaber.text = mod.birthday;
//    [cell.headImg sd_setImageWithURL:[NSURL URLWithString:mod.avatar] placeholderImage:[UIImage imageNamed:@"city"]];
//    NSString * b = mod.type;
//    
//    if ([b isEqualToString:@"0"])
//    {
//        cell.renzhengLaber.text = @"普通用户";
//    }
//    if ([b isEqualToString:@"1"])
//    {
//        if ([mod.status isEqualToString:@"0"]) {
//            cell.renzhengLaber.text = @"未认证";
//        }
//        else if ([mod.status isEqualToString:@"1"])
//        {
//            cell.renzhengLaber.text = @"已认证";
//        }
//        else if ([mod.status isEqualToString:@"2"])
//        {
//            cell.renzhengLaber.text = @"认证驳回";
//        }
//        else
//        {
//            cell.renzhengLaber.text = @"审核中";
//        }
//    }
//    NSInteger  c = [mod.rec_count integerValue];
//    if (c <= 99)
//    {
//        cell.tuiJianNum.text = mod.rec_count;
//    }
//    else
//    {
//        cell.tuiJianNum.text = @"99+";
//    }
//    
//    cell.telLaber.text = mod.mobile? mod.mobile :@"暂无";
    
    
    
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
    cell.telLaber.text = mod.mobile?mod.mobile:@"暂无";
    return cell;

 
    
    
    
}





-(void)requestliebiao
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:_aModel.id?_aModel.id:@"" forKey:@"uid"];
    [dic setObject:[NSString stringWithFormat:@"%ld",numindex] forKey:@"p"];
    [dic setObject:@"10" forKey:@"pagesize"];
    
    WS(weakSelf);
    [WBYRequest wbyLoginPostRequestDataUrl:@"get_rec_user" addParameters:dic success:^(WBYReqModel *model)
     {
         
         [weakSelf.beijingDateView removeFromSuperview];
         
         [allArray removeAllObjects];
         if ([model.err isEqualToString:TURE])
         {
            
             
             [allArray addObjectsFromArray:model.data];
             
         }
         
         
         if (allArray.count==0)
         {
             
             [weakSelf wushuju];
         }
         
         [tableV reloadData];
     } failure:^(NSError *error) {
         
     }];
    
    
    
    
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
