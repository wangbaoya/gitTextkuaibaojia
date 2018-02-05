//
//  WeizhantuijianViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WeizhantuijianViewController.h"
#import "TuijIanxianzhongViewController.h"
#import "WeizhanViewController.h"
#import "JieshaoviewViewController.h"
#import "RongyuzizhiViewController.h"

#import "WoDeTuiJianxianzhongViewController.h"

@interface WeizhantuijianViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    NSArray * allArr;
    
    NSArray * tuijianxianzhArr;
    
}
@property (nonatomic, strong) UITableView *tableV;

@end

@implementation WeizhantuijianViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的微站";
    
    [self creatLeftTtem];
    

    tuijianxianzhArr = [NSArray array];
    [self creatRequest];
    
    allArr = @[@"我的推荐",@"个人介绍",@"荣誉资质"];
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.bounces = NO;
    _tableV.backgroundColor = JIANGEcolor;
    
    [self.view addSubview:_tableV];


    UIButton * aabutton =[UIButton buttonWithType:UIButtonTypeCustom];
    aabutton.frame=CGRectMake(0, 0, 50, 30);
    [aabutton setTitle:@"预览" forState:UIControlStateNormal];
    
    [aabutton setTitleColor:wWhiteColor forState:UIControlStateNormal];
    aabutton.backgroundColor = SHENLANSEcolor;
    aabutton.titleLabel.font = Font(14);
    [aabutton addTarget:self action:@selector(LookAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:aabutton];
 
    
    
}

-(void)LookAction
{
    WeizhanViewController * weizhan = [WeizhanViewController new];
    weizhan.agentId = UID?UID:@"";
    
    [self.navigationController pushViewController:weizhan animated:YES];
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
        bgView.backgroundColor = JIANGEcolor;
    }
    
    return bgView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HANGGAO;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return allArr.count;
    
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
        cell.textLabel.textColor = QIANZITIcolor;
    }
    
    cell.textLabel.font = daFont;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = allArr[indexPath.section];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
       
       WoDeTuiJianxianzhongViewController  * tuijian = [WoDeTuiJianxianzhongViewController new];
        tuijian.myuid = UID?UID:@"";
        tuijian.allArr = tuijianxianzhArr;
        
        [self.navigationController pushViewController:tuijian animated:YES];

    }else if (indexPath.section==1)
    {
        JieshaoviewViewController * jieshao = [JieshaoviewViewController new];
        
        [self.navigationController pushViewController:jieshao animated:YES];
    }else
    {
        RongyuzizhiViewController * jieshao = [RongyuzizhiViewController new];
        
        [self.navigationController pushViewController:jieshao animated:YES];
        
    }
    
    
}

-(void)creatRequest
{
//    WS(weakSelf);
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:UID?UID:@"" forKey:@"agent_uid"];
    [dic setObject:UID?UID:@"" forKey:@"uid"];
    [WBYRequest wbyPostRequestDataUrl:@"micro" addParameters:dic success:^(WBYReqModel *model)
    {
        if ([model.err isEqualToString:TURE])
        {
            tuijianxianzhArr = model.data;
//            DataModel * aModel = [allArr firstObject];
//            xianzhongArr = aModel.pros;
//            liuyanArr = aModel.messages;
//            [weakSelf creatui];
        }else
        {
            
//            [WBYRequest showMessage:model.info];
        }
        
        [_tableV reloadData];
        
    } failure:^(NSError *error) {
        
    } isRefresh:YES];

    
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
