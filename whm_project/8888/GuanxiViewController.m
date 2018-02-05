//
//  GuanxiViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "GuanxiViewController.h"

@interface GuanxiViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * mytab;
    NSArray * guanxiArr;
}
@end

@implementation GuanxiViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"被保人关系";
    guanxiArr = @[@"本人",@"配偶",@"子女",@"兄弟姐妹",@"父母",@"其他"];
    
    [self creatLeftTtem];
    [self creatView];
    
}

-(void)creatView
{
    mytab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,wScreenW, wScreenH - 64) style:UITableViewStylePlain];
    mytab.delegate = self;
    mytab.dataSource = self;
    mytab.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mytab];
    
    mytab.tableFooterView = [UIView new];
    
    mytab.rowHeight = HANGGAO;
    [mytab setSeparatorInset:UIEdgeInsetsZero];
    [mytab setLayoutMargins:UIEdgeInsetsZero];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return guanxiArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"formCell" ];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"formCell"];
        
        cell.textLabel.textColor = wBlackColor;
        cell.textLabel.font = newFont(16);
        cell.textLabel.text = guanxiArr[indexPath.row];
        
    }
    
    return cell;
}
//选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    self.mblock2(guanxiArr[indexPath.row],[NSString stringWithFormat:@"%ld",indexPath.row]);
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
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
