//
//  ChanpinxiangqingViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ChanpinxiangqingViewController.h"
#import "WCPQTableViewCell.h"
#import "XinagqqqqTableViewCell.h"
#import "YBPopupMenu.h"
#import "AAgongsixiangqingViewController.h"
#import "DuibiViewController.h"
#import "AAzuixinbaofeiViewController.h"

@interface ChanpinxiangqingViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate,YBPopupMenuDelegate,UIAlertViewDelegate>
{
    XinagqqqqTableViewCell * cell2;
    UIScrollView * myScroll;
    UITableView * myTab;
    UIWebView * mywebView;
    CGFloat oldOffset;
    NSArray * myArr;
    NSInteger dijige;
    NSString * myStr;
    UIScrollView *litScroll;
    NSArray *_dataArray;
    NSMutableArray * sectionAry;

}
@property (nonatomic, strong) YBPopupMenu *popupMenu;

@end

@implementation ChanpinxiangqingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"产品详情";
     myArr = [NSArray array];
    sectionAry = [NSMutableArray array];
    
    dijige = 0;
    
    [self creatrequest];
    [self creatupview];
}

-(void)creatupview
{
   [self creatLeftTtem];
   [self creatRightItemWith:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e611", 25,wBlackColor)] withFrame:CGRectMake(0, 0,23, 25)];
}

-(void)creatmymidview
{
    DataModel * myModel = myArr.count >=1 ? myArr[0]:@"";

    myScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH-64-49)];
    myScroll.bounces = NO;
    myScroll.delegate = self;
    myScroll.contentSize = CGSizeMake(wScreenW, wScreenH-64-49+160);
    myScroll.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myScroll];
    
    UIImageView * myImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, wScreenW,160)];
    myImg.image = [UIImage imageNamed:@"chanpin"];
    myImg.userInteractionEnabled = YES;
    [myScroll addSubview:myImg];

    UILabel * alab = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, wScreenW-20, 50)];
    alab.textColor = wWhiteColor;
    alab.textAlignment = 1;
    alab.numberOfLines = 0;
    alab.font = daFont;
    alab.text = myModel.name?myModel.name:@"暂无";
    
    [myImg addSubview:alab];
    
    UILabel * bLab = [[UILabel alloc] initWithFrame:CGRectMake(0,90, wScreenW/2, 30)];
    bLab.textAlignment = 1;
    bLab.font = zhongFont;
    bLab.textColor = RGBwithColor(48, 255, 3);
    bLab.text = myModel.sale_status_name.length>=1?myModel.sale_status_name:@"暂无";
    [myImg addSubview:bLab];

    UILabel * xiaLab = [[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(bLab.frame), wScreenW/2, 30)];
    xiaLab.textAlignment = 1;
    xiaLab.font = zhongFont;
    xiaLab.text = @"产品状态";
    xiaLab.textColor = wWhiteColor;
    [myImg addSubview:xiaLab];
    
    
    UILabel * clab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW/2-1,90,0.5, 50)];
    clab.backgroundColor = FENGEXIANcolor;
    [myImg addSubview:clab];
    
    UILabel * dLab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW/2,90, wScreenW/2, 30)];
    dLab.textAlignment = 1;
    dLab.font = zhongFont;
    dLab.textColor = RGBwithColor(233,255,29);
    dLab.text = myModel.cname;
    [myImg addSubview:dLab];
    UIButton * abtn = [UIButton buttonWithType:UIButtonTypeCustom];
    abtn.frame = CGRectMake(wScreenW/2, 90+30, wScreenW/2, 40);
    [abtn setTitle:@"点击查看" forState:UIControlStateNormal];
    
    [abtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 15, 0)];
    [abtn setTitleColor:wWhiteColor forState:UIControlStateNormal];
    [abtn addTarget:self action:@selector(kanxiangqing) forControlEvents:UIControlEventTouchUpInside];
    abtn.titleLabel.font = zhongFont;
    [myImg addSubview:abtn];
    
    UIView * aView = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(myImg.frame), wScreenW, 50)];
    aView.backgroundColor = wWhiteColor;
    [myScroll addSubview:aView];

    NSArray * arr = @[@"详情",@"责任",@"规则",@"条款",@"案例"];

    for (NSInteger i = 0; i < arr.count; i++)
    {
        UIButton * myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        myBtn.frame = CGRectMake(wScreenW * 0.2 * i, 5, wScreenW * 0.2, 40);
        [myBtn setTitleColor:wBlackColor forState:UIControlStateNormal];
        [myBtn setTitleColor:SHENLANSEcolor forState:UIControlStateSelected];
        myBtn.tag = 1221 + i;
        if (i == 0)
        {
            myBtn.selected = YES;
        }
        [myBtn addTarget:self action:@selector(onClickmyBtn:) forControlEvents:UIControlEventTouchUpInside];
        [myBtn setTitle:arr[i] forState:UIControlStateNormal];
        myBtn.titleLabel.font = Font(18);
        [aView addSubview:myBtn];
    }

    UIView * lineview = [[UIView alloc] initWithFrame:CGRectMake(0, 48, wScreenW/5, 2)];
    lineview.backgroundColor = SHENLANSEcolor;
    lineview.tag = 5656;
    [aView addSubview:lineview];
    
    litScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(aView.frame), wScreenW, wScreenH-64-50-49)];
    litScroll.bounces = NO;
    litScroll.pagingEnabled = YES;
    litScroll.delegate = self;
    litScroll.contentSize = CGSizeMake(wScreenW*5,wScreenH-64-50-49);
    litScroll.showsVerticalScrollIndicator = NO;
    [myScroll addSubview:litScroll];
    
    
    UIView * downView = [[UIView alloc] initWithFrame:CGRectMake(0, wScreenH-64-49, wScreenW, 49)];
    [self.view addSubview:downView];
    
    
    
    UIButton * myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat aa = (wScreenW/2-49+16)/2;
    myBtn.frame = CGRectMake(0,0,wScreenW/2, 49);
    [myBtn setImageEdgeInsets:UIEdgeInsetsMake(-5, aa, 8, aa)];
    
    [myBtn addTarget:self action:@selector(duibi:) forControlEvents:UIControlEventTouchUpInside];
    myBtn.tag=200;
    [myBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e613",25, SHENLANSEcolor)] forState:UIControlStateNormal];
    [downView addSubview:myBtn];
    
    UILabel * myLab = [[UILabel alloc] initWithFrame:CGRectMake(0,37, wScreenW/2, 9)];
    myLab.font = Font(14);
    myLab.textColor = QIANZITIcolor;
    myLab.textAlignment=1;
    myLab.text = @"险种对比";
    [downView addSubview:myLab];
    
    UIButton * myBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    myBtn1.frame = CGRectMake(wScreenW/2,0,wScreenW/2, 49);
    [myBtn1 setImageEdgeInsets:UIEdgeInsetsMake(-5,aa,8,aa)];
    [myBtn1 addTarget:self action:@selector(duibi:) forControlEvents:UIControlEventTouchUpInside];
    myBtn1.tag=300;
    
    [myBtn1 setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e612",25, SHENLANSEcolor)] forState:UIControlStateNormal];
    [downView addSubview:myBtn1];
    
    UILabel * myLab1 = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW/2, 37, wScreenW/2, 9)];
    myLab1.font = Font(14);
    myLab1.textColor = QIANZITIcolor;
    myLab1.textAlignment=1;
    myLab1.text = @"保费测算";
    [downView addSubview:myLab1];

    
//    UIButton * myBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    myBtn2.frame = CGRectMake(2*wScreenW/3,1,wScreenW/3,48);
//    [myBtn2 addTarget:self action:@selector(duibi:) forControlEvents:UIControlEventTouchUpInside];
//    myBtn2.tag=400;
//    [myBtn2 setTitleColor:wWhiteColor forState:UIControlStateNormal];
//    [myBtn2 setTitle:@"购买" forState:UIControlStateNormal];
//    myBtn2.backgroundColor = SHENLANSEcolor;
//    [downView addSubview:myBtn2];
    
    UIView * xianView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 1)];
    xianView.backgroundColor = FENGEXIANcolor;
    [downView addSubview:xianView];
    
    [self creattab];
}

#pragma mark====对比保费测算
-(void)duibi:(UIButton*)btn
{
    DataModel * mod = [myArr firstObject];
    if (btn.tag==200)
    {
        DuibiViewController * duibi = [DuibiViewController new];
        duibi.dataMod = mod;
        [self.navigationController pushViewController:duibi animated:YES];
        
    }else if (btn.tag==300)
    {
        if ([mod.is_has_rate isEqualToString:@"1"])
        {
            AAzuixinbaofeiViewController * duibi = [AAzuixinbaofeiViewController new];
            duibi.aamyModel = mod;
            [self.navigationController pushViewController:duibi animated:YES];
        }else
        {
            [WBYRequest showMessage:@"此险种无费率"];
        }
    }else
    {
        
        
    }
 }

-(void)creattab
{
    UIView * view =[UIView new];
    view.backgroundColor = JIANGEcolor;
//    view.alpha = 0.6;
    view.frame = CGRectMake(0, 0, wScreenW, 10);

    UIView * view1 =[UIView new];
    view1.backgroundColor = JIANGEcolor;
    //    view.alpha = 0.6;
    view1.frame = CGRectMake(0, 0, wScreenW, 10);
    
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH-64-50-49) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    myTab.scrollEnabled=NO;
    myTab.bounces = NO;
    myTab.tag=1000;
    myTab.separatorStyle = UITableViewCellSeparatorStyleNone;
   
    myTab.backgroundColor = JIANGEcolor;
    
    
//    if (dijige==0)
//    {
        myTab.tableFooterView = view;
        myTab.tableHeaderView = view1;
        
//    }else
//    {
//        myTab.tableFooterView = [[UIView alloc] init];
//  
//        
//    }
    
    
    [myTab registerClass:[WCPQTableViewCell class] forCellReuseIdentifier:@"cell"];
    [myTab registerClass:[XinagqqqqTableViewCell class] forCellReuseIdentifier:@"mycell"];
    [litScroll addSubview:myTab];
//    [myTab setSeparatorInset:UIEdgeInsetsZero];
//    [myTab setLayoutMargins:UIEdgeInsetsZero];
    
}
#pragma mark------代理方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (dijige==0)
    {
        return 2;
    }else
    {
        DataModel * model = [myArr firstObject];
        
        //        Wpro_groupModel * mod = model.pro_group[section];
        
        return model.pro_group.count;
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dijige==0)
    {
        return HANGGAO;
        
    }else
    {
        return wScreenH-64-50-49;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (dijige==0)
    {
        if (section == 0)
        {
            return 3;
        }else
        {
            return 5;
        }
    }else
    {
//        DataModel * model = [myArr firstObject];
//        
////        Wpro_groupModel * mod = model.pro_group[section];
//        return model.pro_group.count;
        
        if ([sectionAry[section] boolValue])
        {
            return 0;
        }else
        {
            return 1;
        }

        
        
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * myView;
    UIButton * bigBtn;

    UIImageView * rImg;
    
    UIView * doview;
    
    if (dijige==0)
    {
       
        if (section==1)
        {
            UIView * view =[UIView new];
            view.backgroundColor = JIANGEcolor;
            //            view.alpha = 0.6;
            view.frame = CGRectMake(0, 0, wScreenW, 20);
            return view;

        }else
        {
            return nil;
            
        }
        
//    组合险
    }else
    {
        if (!myView)
        {
            myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, HANGGAO)];
            myView.backgroundColor = JIANGEcolor;
            
            
            bigBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            bigBtn.frame = CGRectMake(10,0, wScreenW-20-30, HANGGAO);
            bigBtn.tag = section+250;
            bigBtn.backgroundColor = wWhiteColor;
            [bigBtn addTarget:self action:@selector(dianjikai:) forControlEvents:UIControlEventTouchUpInside];
            bigBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [bigBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            bigBtn.titleLabel.numberOfLines = 0;
            bigBtn.titleLabel.font = zhongFont;
            [myView addSubview:bigBtn];

            UIView * litview = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(bigBtn.frame), 0, 30, HANGGAO)];
            litview.backgroundColor = wWhiteColor;
            
            [myView addSubview:litview];
            
            rImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 20, 20)];
            rImg.tag = 500+section;
            
            if ([sectionAry[section] boolValue]==NO)
            {
                rImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e616",20, wBlackColor)];
                
            }else
            {
                rImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e617",20, wBlackColor)];
            }
            [litview addSubview:rImg];

            
            doview = [[UIView alloc] initWithFrame:CGRectMake(0, HANGGAO-1, wScreenW, 1)];
            doview.backgroundColor = FENGEXIANcolor;
            [myView addSubview:doview];
            
        }
        
        DataModel * model = [myArr firstObject];
        Wpro_groupModel * mod = model.pro_group[section];
        
        [bigBtn setTitle:[NSString stringWithFormat:@"   %@",mod.name]forState:UIControlStateNormal];
        return myView;
    }
    
}

-(void)dianjikai:(UIButton*)btn
{
    btn.selected = !btn.selected;
    
    // 改变你点击的那个区的值,替换数组响应位置的值就可以了
    [sectionAry replaceObjectAtIndex:btn.tag - 250 withObject:@(![sectionAry[btn.tag - 250] boolValue])];
    
    [myTab reloadData];
}




-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (dijige==0)
    {
        if (section == 1)
        {
            return 20;
        }else
        {
            return 0;
        }
    }else
    {
        DataModel * model = [myArr firstObject];

        if (model.pro_group.count>1)
        {
            return HANGGAO;
  
        }else
        {
            
            return 0;
 
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (dijige==0)
    {
        WCPQTableViewCell * cellll = [tableView  dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cellll.backgroundColor = JIANGEcolor;
        cellll.lefLab.backgroundColor = wWhiteColor;
        cellll.rigLab.backgroundColor = wWhiteColor;
        cellll.selectionStyle = UITableViewCellSelectionStyleNone;
        [self biaochuangjian:indexPath cellll:cellll];
        
        return cellll;
        
    }else
    {
        cell2 = [tableView dequeueReusableCellWithIdentifier:@"mycell" forIndexPath:indexPath];
        cell2.backgroundColor = JIANGEcolor;
        cell2.accessoryType = UITableViewCellAccessoryNone;
        cell2.myWebview.scrollView.bounces = NO;
        cell2.myWebview.scrollView.delegate = self;
        cell2.myWebview.scrollView.scrollEnabled = NO;
        cell2.myBtn.hidden=YES;

        DataModel * model = [myArr firstObject];
        
        Wpro_groupModel * mod = model.pro_group[indexPath.section];
        
//        cell2.alab.backgroundColor = wWhiteColor;
//        cell2.alab.text = [NSString stringWithFormat:@" %@",mod.name];
        
        
        if(dijige==3)
        {
            cell2.myBtn.hidden=NO;
            cell2.myWebview.opaque = false;
            cell2.myBtn.tag = 600+ indexPath.section;
            [cell2.myBtn addTarget:self action:@selector(ptffenxiang:) forControlEvents:UIControlEventTouchUpInside];
            cell2.myWebview.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
            cell2.myWebview.scrollView.backgroundColor = wWhiteColor;
            NSURL *url = [NSURL URLWithString:mod.pdf_path.length>5?mod.pdf_path:@"<p>暂无</p>"];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [cell2.myWebview loadRequest:request];
            
        }else
        {
            cell2.myWebview.delegate = self;
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
            cell2.myWebview.scalesPageToFit = NO;
            cell2.myWebview.scrollView.contentInset = UIEdgeInsetsMake(0,0,0,0);
            cell2.myWebview.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            
            if (dijige==1)
            {
                [cell2.myWebview loadHTMLString:mod.rights.length>=1?mod.rights:@"<p>暂无</p>" baseURL:nil];
  
            }else if (dijige==2)
            {
                [cell2.myWebview loadHTMLString:mod.rule.length>=1?mod.rule:@"<p>暂无</p>" baseURL:nil];
  
            }else if (dijige==4)
            {
                [cell2.myWebview loadHTMLString:mod.cases.length>=1?mod.cases:@"<p>暂无</p>" baseURL:nil];
                
            }
        }
        
        return cell2;
    }
    
    
}

-(void)ptffenxiang:(UIButton*)btn
{
    DataModel * model = [myArr firstObject];
    
    Wpro_groupModel * mod = model.pro_group[btn.tag-600];

//   [MyShareSDK shareLogo:model.logo?model.logo:_logo baseaUrl:mod.pdf_path xianzhongID:mod.id?mod.id:@"" touBiaoti:mod.name];
    [MyShareSDK PTFshareLogo:model.logo?model.logo:_logo  baseaUrl:mod.pdf_path?mod.pdf_path:@"" xianzhongID:mod.id?mod.id:@"" touBiaoti:mod.name];
    
    
}



-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '90%'"];
    //字体颜色
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= 'gray'"];
}


-(void)biaochuangjian:(NSIndexPath *)indexPath cellll:(WCPQTableViewCell *)cell
{
    DataModel * myModel =  myArr.count >=1 ? myArr[0]:@"";
   
    NSArray * lefArr = @[@"承保年龄",@"交费期间",@"保障期间"];
    NSArray * lefArr1 = @[@"产品类型",@"设计类型",@"特殊属性",@"承保方式",@"产品条款编码"];
    NSString * one = myModel.prod_type_code_name.length >= 1 ? myModel.prod_type_code_name:@"暂无";
    NSString * two = myModel.prod_desi_code_name.length >= 1 ? myModel.prod_desi_code_name:@"暂无";
    NSString * three = myModel.special_attri_name.length >= 1 ? myModel.special_attri_name:@"暂无";
    NSString * four = [myModel.ins_type isEqualToString:@"1"] ? @"团体":@"个人";
    NSString * five = myModel.ins_item_code.length >= 1 ? myModel.ins_item_code:@"暂无";
    NSArray * rigArr1 = @[one,two,three,four,five];
    
    NSArray * upRarr = @[myModel.limit_age_name.length >=1 ? myModel.limit_age_name:@"暂无",myModel.pay_period?myModel.pay_period:@"暂无",myModel.insurance_period.length >=1 ? myModel.insurance_period:@"暂无"];
    
    cell.rigLab.textColor = wBlackColor;
    if (indexPath.section == 0)
    {
        cell.lefLab.text = lefArr[indexPath.row];
        cell.rigLab.text = [NSString stringWithFormat:@"%@    ",upRarr[indexPath.row]];
        
        
    }else if (indexPath.section == 1)
    {
        cell.rigLab.text =[NSString stringWithFormat:@"%@      ",rigArr1[indexPath.row]];
        cell.lefLab.text =[NSString stringWithFormat:@"%@",lefArr1[indexPath.row]] ;
    }
}




#pragma  mark ==== 点击事件
-(void)onClickmyBtn:(UIButton * )btn
{
    dijige = btn.tag-1221;

    UIView * img = [self.view viewWithTag:5656];

    img.center = CGPointMake(btn.center.x, CGRectGetMaxY(btn.frame)+3);
    btn.selected = !btn.selected;
    for (NSInteger i = 0; i < 5; i++)
    {
        UIButton * aBtn = [self.view viewWithTag:1221 + i];
        aBtn.selected = NO;
    }
    btn.selected = YES;

    DataModel * mod = [myArr firstObject];
    

    if (dijige == 1)
    {
        myStr = mod.rights;
    }
    else if (dijige ==  2)
    {
        myStr = mod.rule;
        
    }else if (dijige ==  3)
    {
        myStr = mod.pdf_path;
        
    }else if (dijige == 4)
    {
        myStr = mod.cases;
        
    }
    [myTab reloadData];

    
}
#pragma mark====滑动视图偏移量
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView==cell2.myWebview.scrollView)
    {
        if (scrollView.contentOffset.y<1)
        {
            
            [UIView animateWithDuration:0.5 animations:^{
                myScroll.contentOffset = CGPointMake(0,0);
                cell2.myWebview.scrollView.contentOffset = CGPointMake(0,0);
                myTab.contentOffset = CGPointMake(0,0);
                cell2.myWebview.scrollView.scrollEnabled = NO;
                myTab.scrollEnabled = NO;
                
                
            }];
        }
    }else  if (scrollView==myScroll)
    {
        if (scrollView.contentOffset.y>oldOffset)
        {
            if (scrollView.contentOffset.y>=1)
            {
                [UIView animateWithDuration:0.5 animations:^{
                    myScroll.contentOffset = CGPointMake(0,160);
                    
                    cell2.myWebview.scrollView.contentOffset = CGPointMake(0,1);
                    myTab.contentOffset = CGPointMake(0,1);
                    
                    cell2.myWebview.scrollView.scrollEnabled = YES;
                    myTab.scrollEnabled = YES;
                    
                }];
            }
            
        }else
        {
            if (scrollView.contentOffset.y>=1)
            {
                [UIView animateWithDuration:0.5 animations:^{
                    myScroll.contentOffset = CGPointMake(0,0);
                    cell2.myWebview.scrollView.contentOffset = CGPointMake(0,0);
                    myTab.contentOffset = CGPointMake(0,0);
                    
                    cell2.myWebview.scrollView.scrollEnabled = NO;
                    myTab.scrollEnabled = NO;
                    
                }];
            }
        }
        oldOffset = scrollView.contentOffset.y;
    }
    
    if (scrollView==myTab)
    {
        if (scrollView.contentOffset.y<1)
        {
            [UIView animateWithDuration:0.5 animations:^{
                myScroll.contentOffset = CGPointMake(0,0);
                cell2.myWebview.scrollView.scrollEnabled = NO;
                myTab.scrollEnabled = NO;
            }];
        }
    }
    
    
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView==litScroll)
    {
        int index = scrollView.contentOffset.x/wScreenW;
        dijige = index;
        
        UIImageView * img = [self.view viewWithTag:5656];
        UIButton * btn = [self.view viewWithTag:1221+dijige];
        img.center = CGPointMake(btn.center.x, CGRectGetMaxY(btn.frame)+4);
        
        for (NSInteger i = 0; i < 5; i++)
        {
            UIButton * aBtn = [self.view viewWithTag:1221 + i];
            aBtn.selected = NO;
        }
        btn.selected = YES;
        
        myTab.frame = CGRectMake(wScreenW*dijige, 0, wScreenW, wScreenH-64-50-49);
        DataModel * mod = [myArr firstObject];
//        Wpro_groupModel * amodel = mod.pro_group[dijige];
        if (dijige == 1)
        {
            myStr = mod.rights;
        }
        else if (dijige ==  2)
        {
            myStr = mod.rule;
            
        }else if (dijige ==  3)
        {
            myStr = mod.pdf_path;
            
        }else if (dijige == 4)
        {
            myStr = mod.cases;
        }
        [myTab reloadData];
    }
    
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
//    NSLog(@"点击了 %@ 选项",TITLES[index]);
    DataModel * myModel = myArr.count >=1 ? myArr[0]:@"";

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
        
        [MyShareSDK shareLogo:myModel.logo?myModel.logo:_logo baseaUrl:XIANZHONGXIANGQING_URL xianzhongID:_aid?_aid:@"" touBiaoti:myModel.name.length>=1?myModel.name:@"险种详情"];
    }
    
}
-(void)shoucangcreatrequest
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:_aid?_aid:@"" forKey:@"type_id"];
    [dic setObject:@"product" forKey:@"type"];
    [dic setObject:UID?UID:@"" forKey:@"uid"];

    [WBYRequest wbyLoginPostRequestDataUrl:@"collect"  addParameters:dic success:^(WBYReqModel *model)
    {
        [WBYRequest showMessage:model.info];
    } failure:^(NSError *error) {
        
    }];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        [self goLogin];
    }
}



-(void)creatrequest
{
    WS(weakSelf);
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:_aid?_aid:@"" forKey:@"pid"];
    
//    [dic setObject:@"26857" forKey:@"pid"];

    [dic setObject:UID?UID:@"" forKey:@"uid"];
    
    [WBYRequest wbyPostRequestDataUrl:@"pro_detail" addParameters:dic success:^(WBYReqModel *model)
    {
        if ([model.err isEqualToString:TURE])
        {
            myArr = model.data;
            
            DataModel * mod = [model.data firstObject];
            
            if (mod.pro_group.count>=1)
            {
                for (int i = 0; i< mod.pro_group.count; i++)
                {
                    [sectionAry addObject:@NO];
                }
            }
            [weakSelf creatmymidview];
        }else
        {
            [WBYRequest showMessage:model.info];
        }
        
    } failure:^(NSError *error)
    {
        
    } isRefresh:NO];
}

#pragma mark===查看公司
-(void)kanxiangqing
{
    DataModel * myModel = myArr.count >=1 ? myArr[0]:@"";
    AAgongsixiangqingViewController * gongsi = [AAgongsixiangqingViewController new];
    gongsi.gongsiID = myModel.company_id;
    
    [self.navigationController pushViewController:gongsi animated:YES];
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
