//
//  NianlingViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NianlingViewController.h"

@interface NianlingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * myTab;
    
}
@end

@implementation NianlingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"选择年龄";
    [self creatLeftTtem];
    [self creatui];
}

-(void)creatui
{
    
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH - 64) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    myTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    [myTab registerClass:[WBYduibiiiTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:myTab];
    
    [myTab setSeparatorInset:UIEdgeInsetsZero];
    
    [myTab setLayoutMargins:UIEdgeInsetsZero];
    
    
 }

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell)
    {
     
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@" %ld",indexPath.row];
    
    cell.textLabel.textColor  = wBlackColor;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    self.getAge([NSString stringWithFormat:@"%ld",indexPath.row]);
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
