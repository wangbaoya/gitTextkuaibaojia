//
//  LiuyanliebiaoViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "LiuyanliebiaoViewController.h"
#import "LiuyancellTableViewCell.h"
#import "HuifuliuyanViewController.h"

@interface LiuyanliebiaoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * allArr;
    UITableView * myTab;

}
@end

@implementation LiuyanliebiaoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"留言列表";
    allArr = [NSMutableArray array];
    
    [self requestData];
    
    [self creatUi];
}

-(void)requestData
{
    WS(weakSelf);
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:_agentId?_agentId:@"" forKey:@"res_uid"];
    [dic setObject:UID forKey:@"uid"];
    [dic setObject:@"1" forKey:@"p"];
    [dic setObject:@"100" forKey:@"pagesize"];
    
    [WBYRequest wbyLoginPostRequestDataUrl:@"get_messages" addParameters:dic success:^(WBYReqModel *model)
    {
        [weakSelf.beijingDateView removeFromSuperview];
        
        if ([model.err isEqualToString:TURE])
        {
            allArr = model.data;
        }
        if (allArr.count==0)
        {
            [weakSelf wushujuSecond];
        }
    
        [myTab reloadData];
    } failure:^(NSError *error) {
        
    }];
}

-(void)creatUi
{
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, wScreenW, wScreenH - 64) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    
    myTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [myTab registerClass:[LiuyancellTableViewCell class] forCellReuseIdentifier:@"cell"];
    myTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [self.view addSubview:myTab];
    
    myTab.tableFooterView = [UIView new];
 }

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        return 50;
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return allArr.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LiuyancellTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (allArr.count>=1)
    {
        DataModel * mod = allArr[indexPath.row];
    
        cell.oneLab.text = mod.message?mod.message:@"暂无留言";
        cell.twoLab.text = mod.city_name?[NSString stringWithFormat:@"来自:%@",mod.city_name]:@"暂无";
        cell.threeLab.text = [WBYRequest timeStr:mod.create_time];
        
        if ([mod.reply_statu isEqualToString:@"0"])
        {
           cell.huifuLab.text = @"未回复";
            
        }else
        {
            cell.huifuLab.text = @"已回复";
            
        }
        
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (allArr.count>=1)
    {
        DataModel * mod = allArr[indexPath.row];
    
        HuifuliuyanViewController * liuyan = [HuifuliuyanViewController new];
        
        liuyan.IDS = mod.id;
        
        [self.navigationController pushViewController:liuyan animated:YES];
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
