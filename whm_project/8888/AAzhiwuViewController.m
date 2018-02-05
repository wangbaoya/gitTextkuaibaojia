//
//  AAzhiwuViewController.m
//  whm_project
//
//  Created by apple on 17/3/24.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "AAzhiwuViewController.h"




@interface AAzhiwuViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * myTab;
    NSArray * tiArr;
    NSArray * shuziArr;
}

@end

@implementation AAzhiwuViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tiArr = @[@"客户经理",@"业务总监",@"业务主管",@"业务经理",@"其他"];
    
    self.navigationItem.title = @"职务";
    [self creatLeftTtem];
    
    [self creatmyui];
    
}
-(void)creatmyui
{
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0,0,wScreenW, wScreenH - 64) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    myTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [myTab registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:myTab];
    
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
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = tiArr[indexPath.row];
    cell.textLabel.textColor = wGrayColor2;
    cell.textLabel.font = Font(18);
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return HANGGAO;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    _zhiwuBlock(tiArr[indexPath.row]);
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
