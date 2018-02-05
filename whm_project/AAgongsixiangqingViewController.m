
//
//  AAgongsixiangqingViewController.m
//  whm_project
//
//  Created by apple on 17/3/23.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "AAgongsixiangqingViewController.h"
#import "WHcoverTableViewCell.h"
#import "WHloveagentTableViewCell.h"
#import "AAgsxqTableViewCell.h"
#import "YBPopupMenu.h"
#import "ChanpinxiangqingViewController.h"
#import "WeizhanViewController.h"

@interface AAgongsixiangqingViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate,YBPopupMenuDelegate>
{
    NSArray * allArr;
    UIScrollView * litscroll;
    UIWebView * downWenView;
    NSArray * xianzhongArr;
    NSArray * dailirenArr;
    NSString * tel;
    NSInteger dijige;
    
    AAgsxqTableViewCell * cell22;
    
    NSInteger huadong;
    
    CGFloat oldOffset;
    
}

@property(nonatomic,assign)NSInteger  i ;
@property(nonatomic,strong)NSMutableArray * items;
@property(nonatomic,copy) NSString *url;
@property(nonatomic,strong)UIScrollView * scrow;
@property(nonatomic,strong)UIView * myView;
@property(nonatomic,strong)UITableView * tableV2;



@end

@implementation AAgongsixiangqingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    allArr = [NSArray array];
    xianzhongArr =[NSArray array];
    dailirenArr = [NSArray array];
    dijige = 0;
    [self creatLeftTtem];
                                                                                    
       [self requestAllData];
}
#pragma mark====新的
-(void)cruatUI
{
    [self creatbtn];
    
    DataModel * mod = [allArr firstObject];
    
     self.title =[NSString stringWithFormat:@"%@公司详情",mod.name];
    CGFloat hhh = 200;
    
    self.scrow = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH-64)];
    self.scrow.delegate = self;
    self.scrow.bounces = NO;
    self.scrow.showsVerticalScrollIndicator = NO;
    [self.scrow setContentSize:CGSizeMake(wScreenW ,wScreenH-64 + hhh-40)];
    [self.view addSubview:_scrow];
    
    self.myView = [[UIView alloc] init];
    self.myView.frame = CGRectMake(0, 0, wScreenW, hhh);
    self.myView.backgroundColor = SHENLANSEcolor;
    
    [self.scrow addSubview:_myView];
    
    UIImageView * headImg = [[UIImageView alloc]init];
    headImg.frame = CGRectMake(0, 10, 65, 65);
    [headImg sd_setImageWithURL:[NSURL URLWithString:mod.logo] placeholderImage:[UIImage imageNamed:@""]];
    headImg.layer.masksToBounds = YES;
    headImg.layer.cornerRadius = 65/2;
    headImg.center = CGPointMake(self.view.center.x, 10+65/2);
    
    [self.myView addSubview:headImg];
    
    
    
    UIButton * keLaber = [UIButton buttonWithType:UIButtonTypeCustom];
    keLaber.frame = CGRectMake(0, CGRectGetMaxY(headImg.frame)+12, wScreenW, 20);
    keLaber.titleLabel.font = ZT14;
    [keLaber setTitleColor:wWhiteColor forState:UIControlStateNormal];
    [keLaber addTarget:self action:@selector(dadianhua) forControlEvents:UIControlEventTouchUpInside];
    [keLaber setTitle:[NSString stringWithFormat:@"公司电话:%@",mod.tel] forState:UIControlStateNormal];
    
    [self.myView addSubview:keLaber];
    
    
    UILabel * wang = [[UILabel alloc]init];
    wang.frame = CGRectMake(0, CGRectGetMaxY(keLaber.frame)+8, wScreenW , 20);
    wang.textColor = [UIColor whiteColor];
    wang.font = ZT14;
    wang.text = [NSString stringWithFormat:@"官方网站:%@",mod.website];
    wang.textAlignment = NSTextAlignmentCenter;
    [self.myView addSubview:wang];    
    
    NSArray * arr = @[@"介绍",@"险种",@"统计"];
    for (NSInteger i = 0; i<3; i++)
    {
        UIButton * selectBut = [UIButton buttonWithType:(UIButtonTypeCustom)];
        selectBut.frame = CGRectMake(wScreenW/3 * i, hhh - 40, wScreenW /3, 40);
        [selectBut setTitleColor:wBlackColor forState:UIControlStateNormal];
        selectBut.titleLabel.font = daFont;
        selectBut.backgroundColor = wWhiteColor;
        [selectBut setTitleColor:SHENLANSEcolor forState:UIControlStateSelected];
        selectBut.tag = 1221 +i;
        if (i == 0)
        {
            selectBut.selected = YES;
        }
        [selectBut addTarget:self action:@selector(onClickmyBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [selectBut setTitle:arr[i] forState:(UIControlStateNormal)];
        [self.myView addSubview:selectBut];
        
    }
    UIButton * but = [self.view viewWithTag:1221];
    
    UIView * img = [[UIView alloc]init];
    img.frame = CGRectMake(0, 0, wScreenW/3, 2);
    img.backgroundColor = SHENLANSEcolor;
    img.tag = 5656;
    img.center = CGPointMake(but.center.x, CGRectGetMaxY(self.myView.frame)-2);
    [self.myView addSubview:img];
    
    litscroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, hhh, wScreenW, wScreenH-40-64)];
    litscroll.bounces = NO;
    litscroll.pagingEnabled = YES;
    litscroll.delegate = self;
    litscroll.contentSize = CGSizeMake(wScreenW*3,wScreenH-64-40);
    litscroll.showsVerticalScrollIndicator = NO;
    [_scrow addSubview:litscroll];
    
    [self creatSecond];
    
}
-(void)creatSecond
{
    self.tableV2 = [[UITableView alloc] initWithFrame:CGRectMake(0,0, wScreenW,wScreenH-64-40) style:UITableViewStylePlain];
    self.tableV2.delegate = self;
    self.tableV2.dataSource = self;
    self.tableV2.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableV2.scrollEnabled = NO;
    self.tableV2.bounces = NO;
    
    [self.tableV2 registerClass:[WHcoverTableViewCell class] forCellReuseIdentifier:@"cell2"];
    [self.tableV2 registerClass:[WHloveagentTableViewCell class] forCellReuseIdentifier:@"cell21"];
    [self.tableV2 registerClass:[AAgsxqTableViewCell class] forCellReuseIdentifier:@"diyige"];
    
    [litscroll addSubview:_tableV2];
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
    DataModel * myModel = allArr.count >=1 ? allArr[0]:@"";
    
    if (index==0)
    {
        if (index==0)
        {
            NSString * token = KEY;
            
            if (token.length>5)
            {
                [self shoucangcreatrequest];
                
            }else
            {
                UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要去登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                      [view show];
            }        
          }
    }else
    {
        
        [MyShareSDK shareLogo:myModel.logo baseaUrl:GONGSIBASEURL xianzhongID:myModel.id?myModel.id:@"" touBiaoti:myModel.name.length>=1?myModel.name:@"公司详情"];
    }
}
    
-(void)shoucangcreatrequest
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:_gongsiID?_gongsiID:@"" forKey:@"type_id"];
    [dic setObject:@"company" forKey:@"type"];
    [dic setObject:UID?UID:@"" forKey:@"uid"];
    
    [WBYRequest wbyLoginPostRequestDataUrl:@"collect"  addParameters:dic success:^(WBYReqModel *model)
     {
         [WBYRequest showMessage:model.info];
     } failure:^(NSError *error)
    {
         
     }];
 }
-(void)creatbtn
{
    [self creatRightItemWith:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e611", 25,wBlackColor)] withFrame:CGRectMake(0, 0,23, 25)];

}
#pragma mark===打电话
-(void)dadianhua
{
    DataModel * model = [allArr firstObject];
    if (model.tel.length>=5)
    {
        [self callPhone:model.tel?model.tel:@""];
    }
}

#pragma mark===滑动视图代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"===%lf",scrollView.contentOffset.y);
    CGFloat hhh = 200;
    NSLog(@"=xxxx==%lf",hhh-30);

    if (scrollView==cell22.myweb.scrollView)
    {
            if (scrollView.contentOffset.y<1)
            {
                [UIView animateWithDuration:0.5 animations:^{
                    _scrow.contentOffset = CGPointMake(0,0);
                    cell22.myweb.scrollView.contentOffset = CGPointMake(0,0);
                    _tableV2.contentOffset = CGPointMake(0,0);
                    cell22.myweb.scrollView.scrollEnabled = NO;
                    _tableV2.scrollEnabled = NO;

                }];
                
            }
        
    }else  if (scrollView==_scrow)
    {
        if (scrollView.contentOffset.y>oldOffset)
        {
            NSLog(@"===向上");
            if (scrollView.contentOffset.y>=1)
            {
                [UIView animateWithDuration:0.5 animations:^{
                    _scrow.contentOffset = CGPointMake(0,hhh-40);
                    cell22.myweb.scrollView.contentOffset = CGPointMake(0,1);
                    _tableV2.contentOffset = CGPointMake(0,1);
                    cell22.myweb.scrollView.scrollEnabled = YES;
                    _tableV2.scrollEnabled = YES;
                }];
            }
        }else
        {
            NSLog(@"===向下");
            
            if (scrollView.contentOffset.y>=1)
            {
                [UIView animateWithDuration:0.5 animations:^{
                    _scrow.contentOffset = CGPointMake(0,0);
                    cell22.myweb.scrollView.contentOffset = CGPointMake(0,0);
                    _tableV2.contentOffset = CGPointMake(0,0);
                    cell22.myweb.scrollView.scrollEnabled = NO;
                    _tableV2.scrollEnabled = NO;
                }];
            }
         }
        oldOffset = scrollView.contentOffset.y;

    }
    
    if (scrollView==litscroll)
    {
        dijige = scrollView.contentOffset.x/wScreenW;
        cell22.myweb.scrollView.scrollEnabled = YES;
      _tableV2.scrollEnabled = YES;
      
         if (litscroll.contentOffset.x!=0)
        {
            _tableV2.scrollEnabled = YES;
            cell22.myweb.scrollView.scrollEnabled = YES;
            huadong = 666;
        }
        
    }

    if (scrollView==_tableV2)
    {
        
        if (scrollView.contentOffset.y<1)
        {
            [UIView animateWithDuration:0.5 animations:^{
                _scrow.contentOffset = CGPointMake(0,0);
                cell22.myweb.scrollView.contentOffset = CGPointMake(0,0);
                _tableV2.contentOffset = CGPointMake(0,0);
                cell22.myweb.scrollView.scrollEnabled = NO;
                _tableV2.scrollEnabled = NO;
                
            }];
        }
    }
    
    
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (scrollView==litscroll)
    {
        
        NSInteger index = scrollView.contentOffset.x/wScreenW;
        dijige = index;
        UIView * img = [self.view viewWithTag:5656];
        UIButton * btn = [self.view viewWithTag:1221+index];
        img.center = CGPointMake(btn.center.x, CGRectGetMaxY(btn.frame)-2);
        for (NSInteger i = 0; i < 3; i++)
        {
            UIButton * aBtn = [self.view viewWithTag:1221 + i];
            aBtn.selected = NO;
        }
        btn.selected = YES;
        
        self.tableV2.frame = CGRectMake(wScreenW*dijige, 0, wScreenW, wScreenH-64-40);
        
        [self.tableV2 reloadData];
     }
}
#pragma mark===点击和滑动事件
-(void)onClickmyBtn:(UIButton * )btn
{
    
    dijige = btn.tag - 1221;
    UIView * img = [self.view viewWithTag:5656];
    
    img.center = CGPointMake(btn.center.x, CGRectGetMaxY(btn.frame)-2);
    
    btn.selected = !btn.selected;
    for (NSInteger i = 0; i < 3; i++)
    {
        UIButton * aBtn = [self.view viewWithTag:1221 + i];
        aBtn.selected = NO;
    }
    btn.selected = YES;
    
    [self.tableV2 reloadData];
 }


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (dijige==0)
    {
        return 1;
        
    }else if (dijige==1)
    {
        return 2;
 
    }else
    {
        return 1;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (dijige==0)
    {
        return 1;
        
    }else if (dijige==1)
    {
        if (section == 0)
        {
            return  xianzhongArr.count;
            
        }else
        {
            return dailirenArr.count;
        }
 
    }else
    {
        return 1;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dijige==1)
    {
        if (indexPath.section==0)
        {
            return 100;
        }else{
            return 50;
        }
    }
    else
    {
        return wScreenH-40-64;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dijige==1)
    {
        if (indexPath.section == 0)
        {
            WHcoverTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            WproModel * model =xianzhongArr[indexPath.row];
            
            DataModel * mod = [allArr firstObject];
            
            cell.titLaber.text = model.name.length>=1?model.name:@"暂无";
            cell.titLaber.font = zhongFont;
            cell.titLaber.textColor = wBlackColor;
            
            cell.ageTitle.text = model.limit_age_name.length>=1?model.limit_age_name:@"暂无";
            cell.ageLaber.font = xiaoFont;
            
            cell.seyTitle.text = model.pro_type_code_name.length>=1?model.pro_type_code_name:@"暂无";
            cell.seyTitle.font = xiaoFont;
            
            [cell.companyImage sd_setImageWithURL:[NSURL URLWithString:mod.logo]];
            
//            NSInteger stateM = [model.is_main integerValue];            
//            if (stateM==2)
//            {cell.myImg.image = [UIImage imageNamed:@"p_huangfu"];
//            }else if (stateM==3)
//            {
//               cell.myImg.image = [UIImage imageNamed:@"p_group"];
//            }else
//            {
//                cell.myImg.image =[UIImage imageNamed:@"p_zhu"];
//            }
            
            if ([model.is_main isEqualToString:@"1"])
            {
                cell.myImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e618", 20, SHENLANSEcolor)];
            }
            if ([model.is_main isEqualToString:@"2"])
            {
                cell.myImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61e", 20, SHENLANSEcolor)];        }
            if ([model.is_main isEqualToString:@"3"])
            {
                cell.myImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61a", 20, SHENLANSEcolor)];
            }

            
            
            return cell;
        }
        else
        {
            WHloveagentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell21" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = dailirenArr[indexPath.row];
            [cell.telBut setBackgroundImage:[UIImage imageNamed:@"tel"] forState:UIControlStateNormal];
            
            cell.telBut.tag = 100 + indexPath.row;
            [cell.telBut addTarget:self action:@selector(telAction:) forControlEvents:(UIControlEventTouchUpInside)];
            return cell;
        }
  
    }else
    {
        DataModel * model = [allArr firstObject];
        
        cell22 = [tableView dequeueReusableCellWithIdentifier:@"diyige" forIndexPath:indexPath];
        cell22.backgroundColor = JIANGEcolor;
        cell22.myweb.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
        cell22.myweb.scrollView.scrollEnabled = NO;
        cell22.myweb.scrollView.delegate = self;
        cell22.myweb.delegate = self;
        cell22.myweb.scrollView.bounces = NO;
        
        if (dijige==2)
        {
            [self request:cell22];
        }
        if (dijige==0)
        {
            [cell22.myweb loadHTMLString:model.mydescription baseURL:nil];
        }
        if (huadong==666&&_scrow.contentOffset.y>60)
        {
            cell22.myweb.scrollView.scrollEnabled = YES;
        }
        return cell22;
    }
    
   }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dijige==1)
    {
        if (indexPath.section==0)
        {
            WproModel * model =xianzhongArr[indexPath.row];

            ChanpinxiangqingViewController * chanpin = [ChanpinxiangqingViewController new];
            chanpin.aid = model.id;
            [self.navigationController pushViewController:chanpin animated:YES];
        }else
        {
            WAgengModel * data = dailirenArr[indexPath.row];
            WeizhanViewController * weizhan = [WeizhanViewController new];
            weizhan.agentId =  data.uid;
            
            [self.navigationController pushViewController:weizhan animated:YES];
  
    }
    }
 }


-(void)request:(AAgsxqTableViewCell*)cell
{
    NSString * str = [NSString stringWithFormat:@"https://www.kuaibao365.com/company/app_count/%@",_gongsiID];
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",str]];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [cell.myweb loadRequest:request];//加载
}


-(void)telAction:(UIButton *)sender
{
    WAgengModel * model = dailirenArr[sender.tag - 100];
    tel = model.mobile;
    if ([WBYRequest isMobileNumber:model.mobile])
    {
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你确定要拨打电话吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        
            [view show];
    }else
    {
        [WBYRequest showMessage:@"电话号码格式不正确"];
    }
    
}
//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 )
    {
        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",tel];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (dijige==1)
    {
        return 50;
    }else
    {
        return 0;
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    UIView * aView;
    UILabel * lab;
    
    UILabel * aLab;
    UILabel * bLab;
    if (dijige==1)
    {
        if (!aView)
        {
            NSArray * arr = @[@"推荐险种",@"最受欢迎代理人"];
            
            aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 50)];
            aView.backgroundColor = JIANGEcolor;
            
            bLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 24, 40)];
            bLab.backgroundColor = wWhiteColor;
            [aView addSubview:bLab];
            aLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 23, 2, 13)];
            
            aLab.backgroundColor = wRedColor;
            [aView addSubview:aLab];
            lab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(aLab.frame)+4, 10, wScreenW-10, 40)];
            lab.font = ZT16;
            
            lab.backgroundColor = wWhiteColor;
            lab.textColor = SHENLANSEcolor;
            lab.text = arr[section];
            [aView addSubview:lab];
        }
        
        return aView;
 
    }else
    {
        return nil;
    }
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    if (dijige==0)
    {
        [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '250%'"];
        
        [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= 'gray'"];
    }
   }

-(void)requestAllData
{
    WS(weakSelf);
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:_gongsiID?_gongsiID:@"" forKey:@"cid"];
    [dic setObject:UID?UID:@"" forKey:@"uid"];
    
    [WBYRequest wbyPostRequestDataUrl:@"com_detail" addParameters:dic success:^(WBYReqModel *model)
     {
         if ([model.err isEqualToString:TURE])
         {
             allArr = model.data;
             
             DataModel * data = [model.data firstObject];
             xianzhongArr = data.pro;
             dailirenArr = data.agent;
             
             [weakSelf cruatUI];
         }else
         {
             [WBYRequest showMessage:model.info];
         }
         
         [_tableV2 reloadData];
         
     } failure:^(NSError *error)
     {
         
     } isRefresh:NO];
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
