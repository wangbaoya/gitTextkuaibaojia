//
//  ShezhiViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ShezhiViewController.h"
#import "MyTabbarviewconstrerViewController.h"
#import "XitongshezhiViewController.h"
#import "ZhanghuxiangqingViewController.h"


@interface ShezhiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableV;

@end

@implementation ShezhiViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self creatLeftTtem];
    self.navigationItem.title = @"设置";
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.bounces = NO;
    _tableV.backgroundColor = wBaseColor;
    
    [self.view addSubview:_tableV];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * bgView;
    
    if (!bgView)
    {
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0,0, wScreenW, 15)];
        bgView.backgroundColor = wBaseColor;
        
    }
    
    return bgView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HANGGAO;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 4;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"formCell" ];
    
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"formCell"];
        cell.textLabel.textColor = wBlackColor;
        
        cell.textLabel.font = daFont;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (indexPath.row == 0 && indexPath.section == 0)
    {
        cell.textLabel.text = @"账户详情";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.section == 1 && indexPath.row == 0)
    {
        cell.textLabel.text = @"系统设置";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
    }
    
    if (indexPath.section==2&&indexPath.row==0)
    {
        cell.textLabel.text = @"推荐人";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
//        NSString * name = RENZHENGMINGZI;
        NSString * phone = TUiJIANRENDIANHUA;
      
        if (![WBYRequest isMobileNumber:phone])
        {
            cell.detailTextLabel.text = @"暂无推荐人";
        }else
        {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@(%@)",TUiJIANRmingzi?TUiJIANRmingzi:@"",TUiJIANRENDIANHUA?TUiJIANRENDIANHUA:@""];
        }
    }
    if (indexPath.section==3&&indexPath.row==0)
    {
        cell.textLabel.text = @"退出账号";
        cell.textLabel.textColor =  RGBwithColor(244, 70, 51);
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==3&&indexPath.row==0)
    {
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要退出" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
                  [view show];
    }
    
    if (indexPath.section==0&&indexPath.row==0)
    {
        
        ZhanghuxiangqingViewController * zhanghu = [ZhanghuxiangqingViewController new];
        
        [self.navigationController pushViewController:zhanghu animated:YES];
    }
    
    if (indexPath.section==1&&indexPath.row==0)
    {
        XitongshezhiViewController * xitong = [XitongshezhiViewController new];
        
        [self.navigationController pushViewController:xitong animated:YES];
    }    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        NSUserDefaults * defau = [NSUserDefaults standardUserDefaults];
        
        [defau removeObjectForKey:@"key"];
        [defau removeObjectForKey:@"uid"];
        [defau removeObjectForKey:@"xingming"];
        [defau removeObjectForKey:@"type"];
        [defau removeObjectForKey:@"renzhengzhuangtai"];
        [defau removeObjectForKey:@"renzhengmingzi"];
       
        [defau synchronize];
        
      
    MyTabbarviewconstrerViewController*view=[[MyTabbarviewconstrerViewController alloc] init];
        
        
        view.dijici = 888;
        
        [[UIApplication sharedApplication].delegate window].rootViewController = view;
        

       
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
