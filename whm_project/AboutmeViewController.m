//
//  AboutmeViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AboutmeViewController.h"
#import "liuyanViewController.h"
#import "AboutmeTableViewCell.h"
#import "AboutOneTableViewCell.h"

@interface AboutmeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString * tel;
    NSArray * myArr;
    NSString * jieshao;
    NSMutableArray * myimgArr;
    
}

@property(nonatomic,strong)UITableView * tableV2;

@end

@implementation AboutmeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    myArr = [NSArray array];
    
    myimgArr = [NSMutableArray array];
    
    self.title = @"关于我";
    [self creatLeftTtem];
    [self creatUI];
    
    [self request];
}

-(void)request
{
    WS(weakSelf);
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setObject:_aModel.agent_info.uid forKey:@"uid"];
    
    [WBYRequest wbyLoginPostRequestDataUrl:@"get_introduce" addParameters:dic success:^(WBYReqModel *model) {
        
        [weakSelf.beijingDateView removeFromSuperview];
        
        if ([model.err isEqualToString:TURE])
        {
            myArr = model.data;
            
            DataModel *mod = [model.data firstObject];
            
            jieshao = mod.introduce;
//            jieshao = @"  支付密码必须为6位数字组合。\n您可依次进入 '功能列表' -> '安全中心' 修改支付密码。";
            
        }else if ([model.err isEqualToString:@"1400"])
        {
            
            [WBYRequest showMessage:model.info];
        }
        
        if (myArr.count==0)
        {
            [weakSelf wushujuSecond];
        }
        
        [weakSelf.tableV2 reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
  
    
    
}
-(void)creatUI
{
    UIView * topview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 70)];
    topview.backgroundColor = JIANGEcolor;
    [self.view addSubview:topview];
   
    UIView * aView= [[UIView alloc] initWithFrame:CGRectMake(0, 10, wScreenW, 60)];
    aView.backgroundColor = wWhiteColor;
    [topview addSubview:aView];
    UIImageView * aimg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    aimg.layer.masksToBounds = YES;
    aimg.layer.cornerRadius = 20;
    [aimg sd_setImageWithURL:[NSURL URLWithString:_aModel.agent_info.avatar] placeholderImage:[UIImage imageNamed:@"city"]];
    [aView addSubview:aimg];
    
    UILabel * nameLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(aimg.frame)+10, 10, 80, 20)];
    nameLab.textColor = wBlackColor;
    nameLab.font = ZT14;
    nameLab.text = _aModel.agent_info.name;
    [aView addSubview:nameLab];
    
    UILabel * xiangqingLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(aimg.frame)+10, CGRectGetMaxY(nameLab.frame),wScreenW/2-20-40+50, 20)];
    
    xiangqingLab.font = Font(12);
    xiangqingLab.textColor = QIANZITIcolor;
    
    xiangqingLab.text = [NSString stringWithFormat:@"%@ %@",_aModel.agent_info.cityn,_aModel.agent_info.cname];
    [aView addSubview:xiangqingLab];

    UIView * rView = [[UIView alloc] initWithFrame:CGRectMake(wScreenW/2+50,0, wScreenW/2-50, 60)];
    [aView addSubview:rView];
    
//    NSArray * imgArr = @[@"\U0000e645",@"\U0000e62d",@"\U0000e628"];
//     for (NSInteger i=0; i<3; i++)
//    {
//        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//
//        btn.frame= CGRectMake(wScreenW/2-30*3-10*3+(30+10)*(i%3),15, 30, 30);
//        [btn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(imgArr[i], 30,[UIColor orangeColor])] forState:UIControlStateNormal];
//        btn.tag = 666+i;
//        [btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
//        [rView addSubview:btn];
//    }

    NSArray * imgArr = @[@"\U0000e62d",@"\U0000e628"];
    for (NSInteger i=0; i<imgArr.count; i++)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.frame= CGRectMake(wScreenW/2-50-30*imgArr.count-10*imgArr.count+(30+10)*(i%imgArr.count),15, 30, 30);
        [btn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(imgArr[i], 30,[UIColor orangeColor])] forState:UIControlStateNormal];
        btn.tag = 666+i;
        [btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [rView addSubview:btn];
    }
    
    UIView * aview = [[UIView alloc] initWithFrame:CGRectMake(0,70-1, wScreenW, 1)];
    aview.backgroundColor = FENGEXIANcolor;
    [topview addSubview:aview];
 
    [self creatTab];
}

-(void)creatTab
{
    UIView * upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW,50)];
    upView.backgroundColor = JIANGEcolor;

    UIButton * litview = [UIButton buttonWithType:UIButtonTypeCustom];
    litview.frame = CGRectMake(0, 0, wScreenW/2, 40);
    litview.backgroundColor = wWhiteColor;
    [litview setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e629", 20, QIANLANSEcolor)] forState:UIControlStateNormal];
    [litview setTitle:@"  保监会已认证" forState:UIControlStateNormal];
    [litview setTitleColor:wBlackColor forState:UIControlStateNormal];
    litview.titleLabel.font = Font(13);
    [upView addSubview:litview];
    
    UIButton * aaalitview = [UIButton buttonWithType:UIButtonTypeCustom];
    aaalitview.frame = CGRectMake(wScreenW/2, 0, wScreenW/2, 40);
    aaalitview.backgroundColor = wWhiteColor;
    [aaalitview setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e62c", 20, QIANLANSEcolor)] forState:UIControlStateNormal];
    [aaalitview setTitle:@"  快保家已认证" forState:UIControlStateNormal];
    [aaalitview setTitleColor:wBlackColor forState:UIControlStateNormal];
    aaalitview.titleLabel.font = Font(13);
    [upView addSubview:aaalitview];
    
    self.tableV2 = [[UITableView alloc] initWithFrame:CGRectMake(0,70, wScreenW,wScreenH-64-70) style:UITableViewStylePlain];
    self.tableV2.delegate = self;
    self.tableV2.dataSource = self;
    self.tableV2.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableV2.separatorColor = FENGEXIANcolor;
    self.tableV2.tableHeaderView = upView;
    
    [self.tableV2 registerClass:[AboutmeTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableV2 registerClass:[AboutOneTableViewCell class] forCellReuseIdentifier:@"cell2"];
    [self.view addSubview:_tableV2];

    self.tableV2.tableFooterView = [[UIView alloc] init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0)
    {
        CGFloat height = [WBYRequest getAutoHeightForString:jieshao withWidth:wScreenW-20 withFontSize:13];
        
        return height+25;
    }else
    {
        
        return 230;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (_aModel.honor.count<1)
    {
        return 1;
    }else
    {
        return 2;
  
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * aview;
    UIButton * abtn;
    UILabel * alab;
    if (!aview)
    {
        aview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 50)];
        aview.backgroundColor = JIANGEcolor;        
        abtn= [UIButton buttonWithType:UIButtonTypeCustom];
        abtn.frame = CGRectMake(0, 10, wScreenW, 40);
        [abtn setTitleColor:wBlackColor forState:UIControlStateNormal];
        
        abtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        abtn.titleLabel.font = Font(18);
        abtn.backgroundColor = wWhiteColor;
        [aview addSubview:abtn];
        
        alab = [[UILabel alloc] initWithFrame: CGRectMake(10,39, wScreenW, 1)];
        alab.backgroundColor = FENGEXIANcolor;
        [abtn addSubview:alab];
        
    }
    if (section==0)
    {
        [abtn setTitle:@"  个人介绍" forState:UIControlStateNormal];
    }else
    {
        [abtn setTitle:@" 个人风采" forState:UIControlStateNormal];
    }
    return aview;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0)
    {
        AboutmeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        if (jieshao.length<1)
//        {
//            jieshao = @" 暂无介绍";
//        }
        
//        [cell setKeyword:jieshao];
        
        [cell setKeyword:_aModel.agent_info.introduce.length>=1?_aModel.agent_info.introduce:@" 暂无介绍"];
        return cell;
  
    }else
    {
        AboutOneTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];        
        for (WbyHonorModel * mod in _aModel.honor)
        {
            
            [myimgArr addObject:mod.img?mod.img:@""];
        }
        
        cell.cycleScrollView2.imageURLStringsGroup = myimgArr;
        
        return cell;
    }
    
}



-(void)onClick:(UIButton*)btn
{
//    商城
   if (btn.tag==666)
    {
        //    留言
        NSString * token = KEY;
        
        if (token.length>5)
        {
            liuyanViewController * liuyan = [liuyanViewController new];
            
            liuyan.jieshourenid = _aModel.agent_info.uid;
            
            [self.navigationController pushViewController:liuyan animated:YES];
            
        }else
        {
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要登陆" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [view show];
        }

        
    }else
    {
        //    电话
        if ([WBYRequest isMobileNumber:_aModel.agent_info.mobile])
        {
            tel = _aModel.agent_info.mobile;
            
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要拨打电话" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            view.tag = 6868;
            [view show];
        }
    }
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==6868)
    {
        if (buttonIndex==1)
        {
            NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",tel];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
    }else{
        if (buttonIndex==1)
        {
            [self goLogin];
        }
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
