//
//  WeizhanViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WeizhanViewController.h"
#import "YBPopupMenu.h"
#import "WeizhanTableViewCell.h"
#import "WeizhanTwoTableViewCell.h"
#import "ChanpinxiangqingViewController.h"
#import "liuyanViewController.h"
#import "TuijIanxianzhongViewController.h"
#import "AboutmeViewController.h"
#import "LiuyanliebiaoViewController.h"

@interface WeizhanViewController ()<YBPopupMenuDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray * allArr;
    NSArray * xianzhongArr;
    NSArray * liuyanArr;
    NSString * tel;
    UIView * aDateView;
}
@property (nonatomic, strong) YBPopupMenu *popupMenu;
@property(nonatomic,strong)UITableView * tableV2;


@end

@implementation WeizhanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    allArr = [NSArray array];
    xianzhongArr = [NSArray array];
    liuyanArr = [NSArray array];
    
    self.title = @"微站";
    [self requestData];
    [self creatrightbtn];
}
-(void)creatui
{
    DataModel * data =[allArr firstObject];
    UIView * topview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 70)];
    topview.backgroundColor = JIANGEcolor;
    [self.view addSubview:topview];
    
    UIButton * litview = [UIButton buttonWithType:UIButtonTypeCustom];
    litview.frame = CGRectMake(0, 10, wScreenW, 60);
    litview.backgroundColor = wWhiteColor;
    
    [litview addTarget:self action:@selector(guanyuwo) forControlEvents:UIControlEventTouchUpInside];
    [topview addSubview:litview];
    
    UIImageView * aimg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    aimg.layer.masksToBounds = YES;
    aimg.layer.cornerRadius = 20;
    [aimg sd_setImageWithURL:[NSURL URLWithString:data.agent_info.avatar] placeholderImage:[UIImage imageNamed:@"city"]];
    [litview addSubview:aimg];
    
    UILabel * nameLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(aimg.frame)+10, 10, 80, 20)];
    nameLab.textColor = wBlackColor;
    nameLab.font = ZT16;
    nameLab.text = data.agent_info.name;
    [litview addSubview:nameLab];
    
    UILabel * xiangqingLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(aimg.frame)+10, CGRectGetMaxY(nameLab.frame), wScreenW - 10-10-40-70-10, 20)];
    xiangqingLab.font = ZT12;
    xiangqingLab.textColor = QIANZITIcolor;
    
    NSInteger nianling =[data.agent_info.birthday floatValue]>0?[WBYRequest getAge:data.agent_info.birthday]:0;
    
    xiangqingLab.text = [NSString stringWithFormat:@"%@ %ld岁 %@ %@",[data.agent_info.sex isEqualToString:@"1"]?@"男":@"女",nianling,data.agent_info.cityn?data.agent_info.cityn:@"",data.agent_info.cname?data.agent_info.cname:@""];
    
    
    [litview addSubview:xiangqingLab];
    
    UILabel * aboutLab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW-70, 20, 60, 20)];
    aboutLab.font  = Font(14);
    aboutLab.textColor = QIANZITIcolor;
    aboutLab.text = @"关于我";
    [litview addSubview:aboutLab];
    
    UIImageView * jianImg = [[UIImageView alloc] initWithFrame:CGRectMake(60-10-6, 5, 10, 10)];
    jianImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e615", 10, QIANZITIcolor)];
    [aboutLab addSubview:jianImg];
    
    UIView * aview = [[UIView alloc] initWithFrame:CGRectMake(0,69, wScreenW, 1)];
    aview.backgroundColor = FENGEXIANcolor;
    [topview addSubview:aview];
    
    [self creattab];
}

-(void)guanyuwo
{
    DataModel * data =[allArr firstObject];
    
    AboutmeViewController * aboutme = [AboutmeViewController new];
    aboutme.aModel = data;
    
    [self.navigationController pushViewController:aboutme animated:YES];
    
}
-(void)creattab
{
    UIView * upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW,100)];
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

    UIView * aview = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(aaalitview.frame)-1, wScreenW, 1)];
    aview.backgroundColor = FENGEXIANcolor;
    [upView addSubview:aview];
 
    UIView * bView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(aview.frame), wScreenW, 30+30)];
    bView.backgroundColor = wWhiteColor;
    
    [upView addSubview:bView];
    
    
    NSArray * imgArr = @[@"\U0000e628",@"\U0000e645"];
    NSArray * titArr = @[@" 电话咨询",@" 公司店铺"];
    NSArray * coloorArr = @[wWhiteColor,wWhiteColor];
    
    NSArray * bgcoloorArr = @[SHENLANSEcolor,QIANZITIcolor];
    
    
    
    CGFloat ww = (wScreenW-15*3)/2;
    
    for (NSInteger i=0; i<2; i++)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.frame= CGRectMake(15+(ww+15)*(i%2),15, ww, 30);
        [btn setTitle:titArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:coloorArr[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(imgArr[i], 16,coloorArr[i])] forState:UIControlStateNormal];
        btn.backgroundColor = bgcoloorArr[i];
        btn.titleLabel.font = Font(13);
        btn.tag = 666+i;
        [btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
//        if (i==0)
//        {
//            btn.layer.borderColor = [UIColor orangeColor].CGColor;
//            btn.layer.borderWidth = 0.5;
//        }
//        if (i==2)
//        {
//            [btn setTitleEdgeInsets:UIEdgeInsetsMake(1.5, 0, -1.5, 0)];
//        }
        [bView addSubview:btn];
    }

    
//    NSArray * imgArr = @[@"\U0000e62d",@"\U0000e628",@"\U0000e645"];
//    NSArray * titArr = @[@" 我要留言",@" 电话咨询",@" 公司店铺"];
//   NSArray * coloorArr = @[[UIColor orangeColor],wWhiteColor,wWhiteColor];
//    
//    NSArray * bgcoloorArr = @[wWhiteColor,SHENLANSEcolor,RGBwithColor(226, 62, 12)];
//    
//    
//    
//    CGFloat ww = (wScreenW-15*4)/3;
//    
//    for (NSInteger i=0; i<3; i++)
//    {
//        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        
//        btn.frame= CGRectMake(15+(ww+15)*(i%3),15, ww, 30);
//        [btn setTitle:titArr[i] forState:UIControlStateNormal];
//        [btn setTitleColor:coloorArr[i] forState:UIControlStateNormal];
//        [btn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(imgArr[i], 16,coloorArr[i])] forState:UIControlStateNormal];
//        btn.backgroundColor = bgcoloorArr[i];
//        btn.titleLabel.font = Font(13);
//        btn.tag = 666+i;
//        [btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
//        if (i==0)
//        {
//            btn.layer.borderColor = [UIColor orangeColor].CGColor;
//            btn.layer.borderWidth = 0.5;
//        }
//        if (i==2)
//        {
//            [btn setTitleEdgeInsets:UIEdgeInsetsMake(1.5, 0, -1.5, 0)];
//        }
//        [bView addSubview:btn];
//    }
    
    
    
    
    
    
    
    
    UIView * dowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 50)];
    dowView.backgroundColor = FENGEXIANcolor;
    DataModel * data = [allArr firstObject];
    
    UILabel * liuLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 1, wScreenW,44)];
    liuLab.textColor = wBlackColor;
    liuLab.font = Font(12);
    liuLab.backgroundColor = wWhiteColor;
    liuLab.text = [NSString stringWithFormat:@"  已有%@位网友留言咨询",data.statistics.message_count?data.statistics.message_count:@"0"];
    
    [dowView addSubview:liuLab];
    
    
    
    UIButton * liuyanbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    liuyanbtn.frame = CGRectMake(wScreenW-80, 7+2.5, 70,25);
    liuyanbtn.backgroundColor = wWhiteColor;
    liuyanbtn.tag=666;
    liuyanbtn.layer.borderColor = [UIColor orangeColor].CGColor;
    liuyanbtn.layer.borderWidth = 0.5;
    liuyanbtn.titleLabel.font = Font(12);
    [liuyanbtn setTitle:@"我要留言" forState:UIControlStateNormal];
    [liuyanbtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [liuyanbtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [dowView addSubview:liuyanbtn];
    
    
    self.tableV2 = [[UITableView alloc] initWithFrame:CGRectMake(0,70, wScreenW,wScreenH-64-70) style:UITableViewStylePlain];
    self.tableV2.delegate = self;
    self.tableV2.dataSource = self;
    self.tableV2.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableV2.separatorColor = FENGEXIANcolor;
    self.tableV2.tableHeaderView = upView;
    self.tableV2.tableFooterView = [UIView new];

    [self.tableV2 registerClass:[WeizhanTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableV2 registerClass:[WeizhanTwoTableViewCell class] forCellReuseIdentifier:@"cell2"];
    [self.view addSubview:_tableV2];

    
    
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        return 90;
    }else
    {
        return 50;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * aview;
    UIButton * abtn;
    UIImageView * img;
    UILabel * alab;
    if (!aview)
    {
        aview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 50)];
        aview.backgroundColor = JIANGEcolor;
        
        abtn= [UIButton buttonWithType:UIButtonTypeCustom];
        abtn.frame = CGRectMake(0, 10, wScreenW, 40);
        [abtn setTitleColor:wBlackColor forState:UIControlStateNormal];
        abtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        abtn.titleLabel.font = daFont;
        abtn.backgroundColor = wWhiteColor;
        [aview addSubview:abtn];
        
        img = [[UIImageView alloc] initWithFrame:CGRectMake(wScreenW-20, 15, 10, 10)];
         img.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e615", 10, QIANZITIcolor)];
        [abtn addSubview:img];
        
        alab = [[UILabel alloc] initWithFrame: CGRectMake(10,39, wScreenW, 1)];
        alab.backgroundColor = FENGEXIANcolor;
        [abtn addSubview:alab];
        
    }
    
    if (section==0)
    {
        [abtn setTitle:@"  推荐险种" forState:UIControlStateNormal];
         [abtn addTarget:self action:@selector(tuijianxianzhong) forControlEvents:UIControlEventTouchUpInside];
    }else
    {
        [abtn setTitle:@"  更多留言" forState:UIControlStateNormal];
        [abtn addTarget:self action:@selector(gengduoliuyan) forControlEvents:UIControlEventTouchUpInside];
    }
    return aview;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return xianzhongArr.count;
    }else
    {
        return liuyanArr.count;
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        WeizhanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (xianzhongArr.count>=1)
        {
            AAwprosModel * model = xianzhongArr[indexPath.row];
            [cell.companyImage sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"city"]];
            cell.titLaber.text = model.short_name.length>1?model.short_name:model.name;
            
            cell.ageLaber.text = [NSString stringWithFormat:@"投保年龄:%@",model.limit_age_name.length>=1?model.limit_age_name:@"暂无"];
             cell.chanpin.text = [NSString stringWithFormat:@"产品类型:%@", model.pro_type_code_name.length>=1?model.pro_type_code_name:@"暂无"];
            
        }
        return cell;
    }else
    {
        WeizhanTwoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (liuyanArr.count>=1)
        {
            WmessageModel * mod = liuyanArr[indexPath.row];
            
            cell.oneLab.text = mod.message?mod.message:@"暂无留言";
            cell.twoLab.text = mod.city_name?[NSString stringWithFormat:@"来自:%@",mod.city_name]:@"暂无";
            cell.threeLab.text = [WBYRequest timeStr:mod.create_time];
            
        }
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
         AAwprosModel * model = xianzhongArr[indexPath.row];
        ChanpinxiangqingViewController * chanpin = [ChanpinxiangqingViewController new];
        chanpin.aid = model.id;
        chanpin.logo = model.logo;
        [self.navigationController pushViewController:chanpin animated:YES];
    }
    
    
}

#pragma mark====推荐险种
-(void)tuijianxianzhong
{
    
//    data.agent_info.uid
    
    DataModel * data = [allArr firstObject];
    
    TuijIanxianzhongViewController * tuijian = [TuijIanxianzhongViewController new];
    tuijian.allArr = allArr;
    
    tuijian.myuid = data.agent_info.uid;
    
    
    [self.navigationController pushViewController:tuijian animated:YES];
}
#pragma mark====更多留言

-(void)gengduoliuyan
{
    DataModel * data = [allArr firstObject];
    LiuyanliebiaoViewController * liuyan = [LiuyanliebiaoViewController new];
    
    liuyan.agentId = data.agent_info.uid;
    [self.navigationController pushViewController:liuyan animated:YES];
}

#pragma mark====留言 电话

-(void)onClick:(UIButton*)btn
{
    DataModel * data =[allArr firstObject];

    //我要留言
//    if (btn.tag==666)
//    {
//        NSString * token = KEY;
//        
//        if (token.length>5)
//        {
//            liuyanViewController * liuyan = [liuyanViewController new];
//            
//            liuyan.jieshourenid = data.agent_info.uid;
//            
//            [self.navigationController pushViewController:liuyan animated:YES];
//            
//        }else
//        {
//            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要登陆" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [view show];
//        }
//        
//    }else
    
        
        if (btn.tag==666)
    {
//        电话咨询
        
        if ([WBYRequest isMobileNumber:data.agent_info.mobile])
        {
            tel = data.agent_info.mobile;
            
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要拨打电话" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            
            view.tag = 6868;
            
                  [view show];
        }
    }else
    {
        
        
    }
}


-(void)creatrightbtn
{
    [self creatLeftTtem];
    [self creatRightItemWith:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e611", 25,wBlackColor)] withFrame:CGRectMake(0, 0,23, 25)];
}
-(void)creatRightItemWith:(UIImage *)backImg withFrame:(CGRect)frame
{
    UIButton * button =[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=frame;
    [button setBackgroundImage:backImg forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fenxiang:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:button];
}

-(void)fenxiang:(UIButton*)sender
{
    
    CGPoint point = CGPointMake(sender.center.x, sender.center.y+40);
    
    //    CGPointMake(wScreenW-25, 60)
    [YBPopupMenu showAtPoint:point titles:@[@"收藏",@"分享"] icons:@[@"wh_collect",@"wh_share"] menuWidth:120 otherSettings:^(YBPopupMenu *popupMenu)
     {
         //        popupMenu.dismissOnSelected = NO;
         //        popupMenu.isShowShadow = YES;
         popupMenu.delegate = self;
         //        popupMenu.offset = 10;
         //        popupMenu.type = YBPopupMenuArrowDirectionNone;
         //        popupMenu.rectCorner = UIRectCornerBottomLeft | UIRectCornerBottomRight;
         popupMenu.textColor = wWhiteColor;
     }];
    
    
}
#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu
{
    DataModel * myModel = allArr.count >=1 ? [allArr firstObject]:@"";
    
    NSLog(@"点击了 %ld 选项",(long)index);
    
    if (index==0)
    {
        NSString * token = KEY;
        
        if (token.length>5)
        {
            [self shoucangcreatrequest];
            
        }else
        {
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要登陆" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [view show];
        }
    }else
    {
        if (allArr.count>0)
        {
            DataModel * data =[allArr firstObject];
            [MyShareSDK shareLogo:myModel.agent_info.avatar?myModel.agent_info.avatar:@"" baseaUrl:WEIZHANBASEURL xianzhongID:self.agentId?self.agentId:@"" touBiaoti:[NSString stringWithFormat:@"%@的微站详情",data.agent_info.name]];
        }
    }
    
}
-(void)shoucangcreatrequest
{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:_agentId?_agentId:@"" forKey:@"type_id"];
    [dic setObject:@"agent" forKey:@"type"];
    [dic setObject:UID?UID:@"" forKey:@"uid"];
    
    [WBYRequest wbyLoginPostRequestDataUrl:@"collect"  addParameters:dic success:^(WBYReqModel *model)
     {
         [WBYRequest showMessage:model.info];
         
     } failure:^(NSError *error)
     {
     }];
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

-(void)requestData
{
    WS(weakSelf);
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:_agentId?_agentId:@"" forKey:@"agent_uid"];
    [dic setObject:UID?UID:@"" forKey:@"uid"];
    [WBYRequest wbyPostRequestDataUrl:@"micro" addParameters:dic success:^(WBYReqModel *model)
    {
        [aDateView removeFromSuperview];

        if ([model.err isEqualToString:TURE])
        {
            allArr = model.data;
            DataModel * aModel = [allArr firstObject];
            xianzhongArr = aModel.pros;
            liuyanArr = aModel.messages;
            [weakSelf creatui];
            
            if (xianzhongArr.count<1)
            {
                [weakSelf  xianzhongwushujuSecond];
            }
            
            
          }else
        {
            [WBYRequest showMessage:model.info];
        }
    } failure:^(NSError *error) {
        
    } isRefresh:YES];
}

-(void)xianzhongwushujuSecond
{
   
    
    aDateView = [[UIView alloc]init];
    aDateView.frame = CGRectMake(0,100+50, wScreenW, wScreenH-64-70-100-50);
    aDateView.backgroundColor = wWhiteColor;
    
    [_tableV2 addSubview:aDateView];
    
    UIImageView * noDateImg = [[UIImageView alloc] init];
    noDateImg.frame = CGRectMake((wScreenW-200)/2,(wScreenH-210-70-100-50)/2-30, 200,210);
    noDateImg.image = [UIImage imageNamed:@"wutupian"];
    
    [aDateView addSubview:noDateImg];
    
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
