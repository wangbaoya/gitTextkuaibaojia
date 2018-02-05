
//
//  WodeguanzhuViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WodeguanzhuViewController.h"
#import "GuanzhuOneTableViewCell.h"
#import "GuanzhugongsiTableViewCell.h"
#import "GuanzhuxiangzhongTableViewCell.h"
#import "WangShouyeTableViewCell.h"
#import "WeizhanViewController.h"
#import "XinwenxiangqingViewController.h"
#import "ChanpinxiangqingViewController.h"
#import "AAgongsixiangqingViewController.h"
#import "myScrollView.h"

//#import "WOdetextViewController.h"beijingDateView
@interface WodeguanzhuViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSInteger dijige;
    UIScrollView * litscroll;
    NSMutableArray * weizhanArr;
    NSMutableArray * zixunArr;
    NSMutableArray * gongsiArr;
    NSMutableArray * xianzhongArr;
    
    UITableView * myTab;
    NSString * tel;
    NSInteger numindex;
    NSArray * jiekouArr;
    UIView * quanxuanDownview;

    NSString * weizhanTel;
    NSString * gongsiTel;

    
}
@property(nonatomic,strong)UIView * myView;
@property (nonatomic, strong) NSMutableArray *deleteArray;
@property(nonatomic,strong)UIView * mybeijingDateView;

@end

@implementation WodeguanzhuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dijige = 0;
    numindex=1;
    self.title = @"我的关注";
    
    zixunArr = [NSMutableArray array];
    gongsiArr = [NSMutableArray array];
    weizhanArr = [NSMutableArray array];
    xianzhongArr = [NSMutableArray array];

    self.deleteArray = [NSMutableArray array];
    
    [self requestdata:@"collect_agent" aint:0 aisyes:YES];
//    [self requestdata:@"collect_news" aint:1 aisyes:YES];
//    [self requestdata:@"collect_com" aint:2 aisyes:YES];
//    [self requestdata:@"collect_pro" aint:3 aisyes:YES];
    
    jiekouArr = @[@"collect_agent",@"collect_news",@"collect_com",@"collect_pro"];
    
    [self creatLeftTtem];
    [self creatrightbtn];
    [self creatmyupview];
}

#pragma mark===加载

-(void)headerRereshing
{
    numindex = 1 ;
    
    [self requestdata:jiekouArr[dijige] aint:dijige aisyes:YES];

    [myTab.mj_header endRefreshing];
    
}
//下拉
-(void)footerRefreshing
{
    
    numindex ++ ;
    [self requestdata:jiekouArr[dijige] aint:dijige aisyes:YES];
    [myTab.mj_footer endRefreshing];
    
}


-(void)creatrightbtn
{
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 40, 20);
    [button setTitle:@"编辑" forState:UIControlStateNormal];
    [button setTitle:@"取消" forState:UIControlStateSelected];
    [button setTitleColor:wWhiteColor forState:UIControlStateNormal];
    button.backgroundColor = SHENLANSEcolor;
    button.titleLabel.font = Font(12);
    
    button.tag = 888;
    [button addTarget:self action:@selector(bianji:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:button];
}

-(void)bianji:(UIButton*)btn
{
    btn.selected = !btn.selected;
    
    if (btn.selected==1)
    {
       myTab.editing = YES;
       myTab.allowsMultipleSelectionDuringEditing = YES;
        [self creatdownView];
    }else
    {
        myTab.editing = NO;
        [self.deleteArray removeAllObjects];
        [quanxuanDownview removeFromSuperview];
    }
    
    
//    if (dijige==0)
//    {
//        
//    }else if (dijige==1)
//    {
//        
//    }else if (dijige==2)
//    {
//        
//    }else
//    {
//
//        
//        
//    }
}

-(void)creatdownView
{
    [quanxuanDownview removeFromSuperview];
    quanxuanDownview = [[UIView alloc] initWithFrame:CGRectMake(0, wScreenH-64-44, wScreenW, 44)];
    
    [self.view addSubview:quanxuanDownview];
    
    NSArray * aar = @[@"   全选",@"取消",@"删除"];
   NSArray * bgcoloorArr = @[wWhiteColor,SHENLANSEcolor,wRedColor];
    
    CGFloat ww = wScreenW/3;
    for (NSInteger i =0; i<3; i++)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.frame= CGRectMake(ww*(i%3),0, ww,44);
        [btn setTitle:aar[i] forState:UIControlStateNormal];
       
        if (i==0)
        {
           [btn setTitleColor:QIANZITIcolor forState:UIControlStateNormal];
            
          [btn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61b", 20,QIANZITIcolor)] forState:UIControlStateNormal];
            
          [btn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61c", 20,wRedColor)] forState:UIControlStateSelected];
            
        }else
        {
            [btn setTitleColor:wWhiteColor forState:UIControlStateNormal];
        }
        
        
        btn.backgroundColor = bgcoloorArr[i];
        btn.titleLabel.font = Font(18);
        btn.tag = 666+i;
        [btn addTarget:self action:@selector(quxiaoshanchu:) forControlEvents:UIControlEventTouchUpInside];
        
        [quanxuanDownview addSubview:btn];
        
    }
    
}

-(void)quxiaoshanchu:(UIButton*)btn
{
    btn.selected = !btn.selected;
    
    if (btn.tag==666)
    {
        if (btn.selected==YES)
        {
            if (myTab.editing == NO)
            {
                return;
            }
            else
            {
                [self.deleteArray removeAllObjects];
                
                    if (dijige==0)
                    {
                
                        for (int i = 0; i < weizhanArr.count; i++)
                        {
                            DataModel * mod = weizhanArr[i];
                            
                            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                            
                            [myTab selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                            
                            [self.deleteArray addObject:mod.uid];

                        }
                        
                    }else if (dijige==1)
                    {
                        for (int i = 0; i < zixunArr.count; i++)
                        {
                            DataModel * mod = zixunArr[i];
                            
                            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                            
                            [myTab selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                            
                            [self.deleteArray addObject:mod.type_id];
                            
                        }

                        
                        
                    }else if (dijige==2)
                    {
                        for (int i = 0; i < gongsiArr.count; i++)
                        {
                            DataModel * mod = gongsiArr[i];
                            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                            [myTab selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                            [self.deleteArray addObject:mod.type_id];
                        }

                    }else
                    {
                      
                        for (int i = 0; i < xianzhongArr.count; i++)
                        {
                            DataModel * mod = xianzhongArr[i];
                            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                            [myTab selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                            [self.deleteArray addObject:mod.type_id];
                        }

                    }
                
            }
  
        }else
        {
            
            [self.deleteArray removeAllObjects];
            
            [myTab reloadData];
        }
        
    }else if (btn.tag==666+1)
    {
        myTab.editing = NO;
        [quanxuanDownview removeFromSuperview];
        
    }else
    {
        
                UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否取消收藏" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                view.tag = 9090;
                [view show];
 
        
        
        
    }
    
}

#pragma mark===删除收藏
-(void)shanchuRequest
{
    myTab.editing = NO;
    [quanxuanDownview removeFromSuperview];
    
    
    if (self.deleteArray.count>=1)
    {
        
        NSString * ids = [self.deleteArray componentsJoinedByString:@","];
        
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        
        [dic setObject:UID forKey:@"uid"];
        [dic setObject:ids forKey:@"type_id"];
        
        if (dijige==0)
        {
            [dic setObject:@"agent" forKey:@"type"];
        }else if (dijige==1)
        {
            [dic setObject:@"news" forKey:@"type"];
 
        }else if (dijige==2)
        {
            [dic setObject:@"company" forKey:@"type"];
 
        }else
        {
            [dic setObject:@"product" forKey:@"type"];
        }

        WS(weakSelf);
        [WBYRequest wbyLoginPostRequestDataUrl:@"collect" addParameters:dic success:^(WBYReqModel *model)
        {
            [WBYRequest showMessage:model.info];
           
            if ([model.err isEqualToString:TURE])
            {
                [weakSelf requestdata:jiekouArr[dijige] aint:dijige aisyes:YES];
                
                [weakSelf.deleteArray removeAllObjects];
            }
        } failure:^(NSError *error) {
            
        }];
        
    }else
    {
        [WBYRequest showMessage:@"请选择元素"];
    }
    
    }



-(void)creatmyupview
{
    
    self.myView = [[UIView alloc] init];
    self.myView.frame = CGRectMake(0, 0, wScreenW, 50);
    self.myView.backgroundColor = JIANGEcolor;
    
    [self.view addSubview:_myView];

    
    NSArray * arr = @[@"微站",@"资讯",@"公司",@"险种"];
    for (NSInteger i = 0; i<arr.count; i++)
    {
        UIButton * selectBut = [UIButton buttonWithType:(UIButtonTypeCustom)];
        selectBut.frame = CGRectMake(wScreenW/4 * i,0, wScreenW/4, 40);
        [selectBut setTitleColor:wBlackColor forState:UIControlStateNormal];
        selectBut.backgroundColor = wWhiteColor;
        [selectBut setTitleColor:SHENLANSEcolor forState:UIControlStateSelected];
        selectBut.tag = 1221 +i;
        if (i == 0)
        {
            selectBut.selected = YES;
        }
        [selectBut addTarget:self action:@selector(onClickmyBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [selectBut setTitle:arr[i] forState:(UIControlStateNormal)];
        selectBut.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [self.myView addSubview:selectBut];
        
    }
    UIButton * but = [self.view viewWithTag:1221];
    UIView * img = [[UIView alloc]init];
    img.frame = CGRectMake(0, 0, wScreenW/4, 2);
    img.backgroundColor = SHENLANSEcolor;
    img.tag = 5656;
    img.center = CGPointMake(but.center.x, CGRectGetMaxY(self.myView.frame)-10-2);
    [self.myView addSubview:img];

    [self litscroll];
}
-(void)litscroll
{
    litscroll = [[myScrollView alloc] initWithFrame:CGRectMake(0,50, wScreenW, wScreenH-50-64)];
    
    litscroll.pagingEnabled = YES;
    litscroll.delegate = self;
    litscroll.contentSize = CGSizeMake(wScreenW*4,wScreenH-64-50);
    litscroll.bounces = NO;
//    litscroll.scrollEnabled= NO;
    litscroll.showsVerticalScrollIndicator = NO;
//    [litscroll setDelaysContentTouches:NO];
//    [litscroll setCanCancelContentTouches:NO];
    
    [self.view addSubview:litscroll];

    [self creattab];
}

-(void)creattab
{
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, wScreenW, wScreenH - 64-50 ) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    myTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [myTab registerClass:[GuanzhuOneTableViewCell class] forCellReuseIdentifier:@"cell"];
     [myTab registerClass:[WangShouyeTableViewCell class] forCellReuseIdentifier:@"cell1"];
     [myTab registerClass:[GuanzhugongsiTableViewCell class] forCellReuseIdentifier:@"cell2"];
     [myTab registerClass:[GuanzhuxiangzhongTableViewCell class] forCellReuseIdentifier:@"cell3"];
    myTab.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    myTab.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];

    myTab.backgroundColor = JIANGEcolor;
    myTab.separatorColor = FENGEXIANcolor;
    myTab.tableFooterView = [[UIView alloc] init];
    
    [litscroll addSubview:myTab];
    
    [myTab setSeparatorInset:UIEdgeInsetsZero];
    [myTab setLayoutMargins:UIEdgeInsetsZero];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(dijige==0)
    {
        return 60;
    }else if (dijige==1)
    {
        return 90;
    }else if (dijige==2)
    {
        return 60;
    }else
    {
        return 90;
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (dijige==0)
    {
        return weizhanArr.count;
    }else if (dijige==1)
    {
        return zixunArr.count;
    }else if (dijige==2)
    {
        return gongsiArr.count;
    }else
    {
        return xianzhongArr.count;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dijige==0)
    {
        GuanzhuOneTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
        cell.tintColor = wRedColor;
        cell.selectedBackgroundView = [[UIView alloc]init];
        
        
    if (weizhanArr.count>=1)
    {
        DataModel * mod = weizhanArr[indexPath.row];
        [cell.myImg sd_setImageWithURL:[NSURL URLWithString:mod.avatar] placeholderImage:[UIImage imageNamed:@"city"]];
        cell.upLab.text = mod.name?mod.name:@"暂无";
        cell.downLab.text = [NSString stringWithFormat:@"%@ %@ %@ %@",mod.cname,mod.profession,[mod.birthday floatValue]>1?[NSString stringWithFormat:@"%ld",[WBYRequest getAge:mod.birthday]]:@"",mod.provn?mod.provn:@""];
        
        
        NSLog(@"====%lf",[mod.birthday floatValue]);
        cell.sexLab.text = [mod.sex isEqualToString:@"1"]?@"男":@"女";
        
        cell.telbtn.tag = 1111+indexPath.row;
        [cell.telbtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    }
        return cell;

    }else if (dijige==1)
    {
        WangShouyeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
//         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.tintColor = wRedColor;

        if (zixunArr.count>=1)
        {
            DataModel * dataMod = zixunArr[indexPath.row];
            
            [cell.myImg sd_setImageWithURL:[NSURL URLWithString:dataMod.thumbnail] placeholderImage:[UIImage imageNamed:@"city"]];
            cell.myTit.text = dataMod.title;
            cell.readNum.text = [NSString stringWithFormat:@"%@ 阅读",dataMod.mycount];
            cell.styLaber.text = [NSString stringWithFormat:@"类型:%@",dataMod.cate_name];
            cell.timeLaber.text = [WBYRequest timeStr:dataMod.created_time];
        }
        return cell;
        
    }else if (dijige==2)
    {
        GuanzhugongsiTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
//         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.tintColor = wRedColor;

        if (gongsiArr.count>=1)
        {
            
            DataModel * mod = gongsiArr[indexPath.row];
            [cell.myImg sd_setImageWithURL:[NSURL URLWithString:mod.logo] placeholderImage:[UIImage imageNamed:@"city"]];
            
            cell.upLab.text = mod.name?mod.name:@"暂无";
            cell.downLab.text = [NSString stringWithFormat:@"客户电话:%@",mod.tel];
            cell.telbtn.tag = 3333+indexPath.row;
            [cell.telbtn addTarget:self action:@selector(dadianhua:) forControlEvents:UIControlEventTouchUpInside];
         }
        
        return cell;
    }else if(dijige==3)
    {
        GuanzhuxiangzhongTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];

        cell.tintColor = wRedColor;
        
        if (xianzhongArr.count>=1)
        {
            DataModel * data = xianzhongArr[indexPath.row];
            [cell.lImg sd_setImageWithURL:[NSURL URLWithString:data.img.length>8?data.img:data.logo]];
            cell.upLab.text = data.name;
            cell.midL.text = [NSString stringWithFormat:@"投保年龄:%@",data.limit_age_name.length > 1?data.limit_age_name:@"暂无"];  //limit_age_name
            cell.midR.text = [NSString stringWithFormat:@"产品类型:%@",data.pro_type_code_name.length >1 ?data.pro_type_code_name:@"暂无"];
        }
         
        return cell;
    }else
    {
        
        return nil;
    }
    
}

#pragma mark===dianhua微站
-(void)onClick:(UIButton*)btn
{
    DataModel * data = weizhanArr[btn.tag-1111];
    [self callPhone:data.mobile?data.mobile:@""];

//    if ([WBYRequest isMobileNumber:data.mobile])
//    {
//        
//        weizhanTel = data.mobile;
//        
//        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要打电话" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        view.tag=678;
//        
//                   [view show];
//        
//    }else
//    {
//        [WBYRequest showMessage:@"电话号码不合法"];
//    }

    
    
}
#pragma mark===dianhua公司

-(void)dadianhua:(UIButton*)btn
{
    DataModel * data = gongsiArr[btn.tag-3333];
  
    
//        gongsiTel = data.mobile;
//        
    
    [self callPhone:data.tel?data.tel:@""];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
//    if (alertView.tag==678) {
//        
//        if (buttonIndex == 1)
//        {
//            NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",weizhanTel];
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//        }
// 
//    }else if(alertView.tag==789)
//    {
//        if (buttonIndex == 1)
//        {
//            NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",gongsiTel];
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//        }
//        
//    }
//    
//
    
    if (alertView.tag==9090)
    {
        if (buttonIndex==1)
        {
            if (self.deleteArray.count>=1)
            {
                [self shanchuRequest];
                
            }else
            {
                
                [WBYRequest showMessage:@"请选择取消收藏的数据"];
            }
         }
        
        }
    }





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (myTab.editing==YES)
    {
    UIButton * btn = [self.view viewWithTag:666];
        
        if (dijige==0)
        {
            DataModel * mod = weizhanArr[indexPath.row];
            
            
            if (self.deleteArray.count==weizhanArr.count)
            {
                btn.selected = YES;
            }else
            {
                btn.selected = NO;
            }
            
            [self.deleteArray addObject:mod.uid];

            
        }else if (dijige==1)
        {
            DataModel * dataMod = zixunArr[indexPath.row];
            
            if (self.deleteArray.count==zixunArr.count)
            {
                btn.selected = YES;
            }else
            {
                btn.selected = NO;
            }

             [self.deleteArray addObject:dataMod.type_id];
            
//            if (self.deleteArray.count>=1)
//            {
//                NSString * shanid = [self.deleteArray componentsJoinedByString:@","];
//                
//                NSArray * fengeArr = [shanid componentsSeparatedByString:@","];
//                
//                for (NSString * myI in fengeArr)
//                {
//                    
//                    if (![myI isEqualToString:dataMod.id])
//                    {
//                        [self.deleteArray addObject:dataMod.id];
//                    }
//                    
//                    NSLog(@"===%@",dataMod.id);
//                }
//  
//            }else
//            {
//               [self.deleteArray addObject:dataMod.id];
//            }
         }else if (dijige==2)
        {
            DataModel * dataMod = gongsiArr[indexPath.row];
            [self.deleteArray addObject:dataMod.type_id];
            
            if (self.deleteArray.count==gongsiArr.count)
            {
                btn.selected = YES;
            }else
            {
                btn.selected = NO;
            }
         
        }else
        {
            DataModel * dataMod = xianzhongArr[indexPath.row];
            
            [self.deleteArray addObject:dataMod.type_id];
            
            if (self.deleteArray.count==xianzhongArr.count)
            {
                btn.selected = YES;
            }else
            {
                btn.selected = NO;
            }
        }
        
    }else
    {
        if (dijige==0)
        {
            DataModel * mod = weizhanArr[indexPath.row];
            WeizhanViewController * weizhan = [WeizhanViewController new];
            
            weizhan.agentId = mod.uid;
            
            [self.navigationController pushViewController:weizhan animated:YES];
            
        }else if (dijige==1)
        {
            DataModel * dataMod = zixunArr[indexPath.row];
            XinwenxiangqingViewController * xiangqing = [XinwenxiangqingViewController new];
            
            xiangqing.myId = dataMod.id;
            [self.navigationController pushViewController:xiangqing animated:YES];
            
            
        }else if (dijige==2)
        {
            DataModel * data = gongsiArr[indexPath.row];
            AAgongsixiangqingViewController * gongsi = [AAgongsixiangqingViewController new];
            
            gongsi.gongsiID = data.type_id;
            
            [self.navigationController pushViewController:gongsi animated:YES];
        }else
        {
            DataModel * data = xianzhongArr[indexPath.row];
            
            ChanpinxiangqingViewController * chanpin = [ChanpinxiangqingViewController new];
            chanpin.aModel = data;
            chanpin.aid = data.id;
            chanpin.logo = data.logo;
            [self.navigationController pushViewController:chanpin animated:YES];
        }
    }
    
  }


//取消选中
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIButton * btn = [self.view viewWithTag:666];
    
    btn.selected = NO;
    
    
    if (dijige==0)
    {
        DataModel * mod = weizhanArr[indexPath.row];
        
        [self.deleteArray removeObject:mod.uid];
        
    }else if (dijige==1)
    {
        DataModel * dataMod = zixunArr[indexPath.row];
        [self.deleteArray removeObject:dataMod.type_id];
        
    }else if (dijige==2)
    {
        DataModel * dataMod = gongsiArr[indexPath.row];

        [self.deleteArray removeObject:dataMod.type_id];
        
    }else
    {
        DataModel * dataMod = xianzhongArr[indexPath.row];

        [self.deleteArray removeObject:dataMod.type_id];
    }    
    
}


#pragma mark===滑动视图代理

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [_mybeijingDateView removeFromSuperview];

    UIButton * btn = [[[UIApplication sharedApplication].delegate window] viewWithTag:888];
    if (scrollView==litscroll)
    {
        myTab.editing = NO;
        [self.deleteArray removeAllObjects];
        [quanxuanDownview removeFromSuperview];
        btn.selected = NO;
        
        NSInteger index = scrollView.contentOffset.x/wScreenW;
        
        [self requestdata:jiekouArr[index] aint:index aisyes:YES];

        dijige = index;
        UIView * img = [self.view viewWithTag:5656];
        UIButton * btn = [self.view viewWithTag:1221+index];
        img.center = CGPointMake(btn.center.x, CGRectGetMaxY(btn.frame)-2);
        for (NSInteger i = 0; i < 4; i++)
        {
            UIButton * aBtn = [self.view viewWithTag:1221 + i];
            aBtn.selected = NO;
        }
        btn.selected = YES;
        
        myTab.frame = CGRectMake(wScreenW*dijige, 0, wScreenW, wScreenH-64-50);
        
        [myTab reloadData];
    }
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
}

#pragma mark===点击和滑动事件
-(void)onClickmyBtn:(UIButton * )btn
{
    dijige = btn.tag - 1221;

    UIButton * aabtn = [[[UIApplication sharedApplication].delegate window] viewWithTag:888];

    myTab.editing = NO;
    [self.deleteArray removeAllObjects];
    [quanxuanDownview removeFromSuperview];
    [_mybeijingDateView removeFromSuperview];

    aabtn.selected = NO;
    
    
    UIView * img = [self.view viewWithTag:5656];
    img.center = CGPointMake(btn.center.x, CGRectGetMaxY(btn.frame)-2);
    btn.selected = !btn.selected;
    for (NSInteger i = 0; i <4; i++)
    {
        UIButton * aBtn = [self.view viewWithTag:1221 + i];
        aBtn.selected = NO;
    }
    btn.selected = YES;
    
    [self requestdata:jiekouArr[btn.tag-1221] aint:btn.tag-1221 aisyes:NO];

    
}

#pragma mark===请求
-(void)requestdata:(NSString*)url aint:(NSInteger)a aisyes:(BOOL)isyes
{
    WS(weakSelf);
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:UID forKey:@"uid"];
    [dic setObject:[NSString stringWithFormat:@"%ld",numindex] forKey:@"p"];
    [dic setObject:@"10" forKey:@"pagesize"];

    [WBYRequest wbyLoginPostRequestDataUrl:url addParameters:dic success:^(WBYReqModel *model)
    {
        [weakSelf.mybeijingDateView removeFromSuperview];

            if (a==0)
            {
                if (numindex == 1)
                {
                    [weizhanArr removeAllObjects];
                }
                [weizhanArr addObjectsFromArray:model.data];
                
                if (model.data.count==0)
                {
                    
                    if (isyes==YES)
                    {
                        [weakSelf guanzhuwushujuSecond:YES];
   
                    }else
                    {
                        [weakSelf guanzhuwushujuSecond:NO];
 
                    }
                    
                }

            }else if (a==1)
            {
                
                if (numindex == 1)
                {
                    [zixunArr removeAllObjects];
                }
                
                [zixunArr addObjectsFromArray:model.data];
                
                if (model.data.count==0)
                {
                    if (isyes==YES)
                    {
                        [weakSelf guanzhuwushujuSecond:YES];
                        
                    }else
                    {
                        [weakSelf guanzhuwushujuSecond:NO];
                        
                    }

                }

                
            }else if (a==2)
            {
                if (numindex == 1)
                {
                    [gongsiArr removeAllObjects];
                }
                
                [gongsiArr addObjectsFromArray:model.data];
                
                if (model.data.count==0)
                {
                    if (isyes==YES)
                    {
                        [weakSelf guanzhuwushujuSecond:YES];
                        
                    }else
                    {
                        [weakSelf guanzhuwushujuSecond:NO];
                        
                    }

                }                
                
            }else
            {
                if (numindex == 1)
                {
                    [xianzhongArr removeAllObjects];
                }
                
                [xianzhongArr addObjectsFromArray:model.data];
                
                if (model.data.count==0)
                {
                    if (isyes==YES)
                    {
                        [weakSelf guanzhuwushujuSecond:YES];
                        
                    }else
                    {
                        [weakSelf guanzhuwushujuSecond:NO];
                        
                    }
                }
            }
            
     
      
        [myTab reloadData];
      
    } failure:^(NSError *error)
    {
        
    }];
    
    
}


-(void)guanzhuwushujuSecond:(BOOL)isyess
{
    [_mybeijingDateView removeFromSuperview];
    
    _mybeijingDateView = [[UIView alloc]init];
    
    
    if (isyess==YES)
    {
     _mybeijingDateView.frame = CGRectMake(wScreenW*dijige,0, wScreenW, wScreenH-64-40);
    }else
    {
   _mybeijingDateView.frame = CGRectMake(0,0, wScreenW, wScreenH-64-40);
        
    }
    
//    _mybeijingDateView.backgroundColor = wRedColor;
//    _mybeijingDateView.userInteractionEnabled = YES;
    [litscroll addSubview:_mybeijingDateView];
    
    UIImageView * noDateImg = [[UIImageView alloc] init];
    noDateImg.frame = CGRectMake((wScreenW-200)/2,(wScreenH-210-64)/2-50, 200,210);
    noDateImg.image = [UIImage imageNamed:@"wutupian"];
//    noDateImg.backgroundColor = wRedColor;
//    noDateImg.userInteractionEnabled = YES;
    [_mybeijingDateView addSubview:noDateImg];
    
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
