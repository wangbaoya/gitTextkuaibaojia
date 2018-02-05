//
//  WLeiXingViewController.m
//  whm_project
//
//  Created by apple on 17/1/5.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WLeiXingViewController.h"


@interface WLeiXingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * myTab;
    NSArray * tiArr;
    NSArray * shuziArr;
    NSArray * youbianArr;
    
}

@end

@implementation WLeiXingViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tiArr = @[@"保险公司",@"保险公司",@"专业中介结构",@"专业中介结构",@"专业中介机构"];
    youbianArr = @[@"人身险",@"财产险",@"代理公司",@"经纪公司",@"公估公司"];

    shuziArr = @[@"1",@"2",@"9",@"10",@"11"];
    
    self.navigationItem.title = @"公司类型";
    [self creatLeftTtem];
    
    [self creatmyui];
    
}
-(void)creatmyui
{
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0,0,wScreenW, wScreenH - 64) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    myTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    [myTab registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:myTab];
    
    myTab.rowHeight = HANGGAO;
    myTab.tableFooterView = [UIView new];
    [myTab setLayoutMargins:UIEdgeInsetsZero];
    [myTab setSeparatorInset:UIEdgeInsetsZero];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tiArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell)
    {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.font = daFont;
        cell.detailTextLabel.font = daFont;       
        
    }
    cell.textLabel.text = tiArr[indexPath.row];
    cell.detailTextLabel.text = youbianArr[indexPath.row];
    cell.textLabel.textColor = wBlackColor;
    cell.detailTextLabel.textColor = QIANZITIcolor;
    
    

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.allBlock(youbianArr[indexPath.row] ,shuziArr[indexPath.row]);
    
    
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
