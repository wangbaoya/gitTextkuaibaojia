//
//  XitongshezhiViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XitongshezhiViewController.h"

@interface XitongshezhiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableV;

@end

@implementation XitongshezhiViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"清除缓存";
    [self creatLeftTtem];
    [self set_p];
    
}
-(void)set_p
{
    
    UIView * aaview= [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 10)];
    aaview.backgroundColor = JIANGEcolor;
    
    
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableV.backgroundColor = JIANGEcolor;
    _tableV.rowHeight =HANGGAO;
    _tableV.bounces = NO;
    
    _tableV.tableHeaderView = aaview;
    
    _tableV.tableFooterView = [UIView new];
    [self.view addSubview:_tableV];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"formCell" ];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"formCell"];
        if (indexPath.row == 0 )
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.textColor = wBlackColor;

            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = daFont;
            
        }
        cell.textLabel.text = @"清除缓存";
        
    }
    
    
    return cell;
}
//选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger size=[[SDImageCache sharedImageCache]getSize];
    
    [WBYRequest showMessage:[NSString stringWithFormat:@"清除缓存%@",[WBYRequest fileSizeOfLength:size]]];
    
    //    [[SDImageCache sharedImageCache] clearDisk];
    //    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
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
