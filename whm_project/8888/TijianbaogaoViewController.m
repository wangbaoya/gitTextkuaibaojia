//
//  TijianbaogaoViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TijianbaogaoViewController.h"
#import "LineView.h"
#import "AAtijianTwoTableViewCell.h"
#import "AAThreeTableViewCell.h"
#import "AAtijiantuOneTableViewCell.h"
@interface TijianbaogaoViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray * allArray;
    NSInteger dijige;
    UIScrollView * litScroll;
    UITableView * myTab;
    CGFloat oldContenOffset;
    BOOL isOpen[2];
    BOOL twoOpen[2];
    NSString * htmlStr;
    AAThreeTableViewCell * cell2;
    UIAlertView * myAlert;
    UIView * headView;
    
    BOOL jihang;
    
    NSMutableArray * sectionAry;
}
@property(nonatomic,strong)UIScrollView * scrow;
@property(nonatomic,strong)UIView * myView;

@end

@implementation TijianbaogaoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    allArray = [NSArray array];
    dijige = 0;
    self.navigationItem.title = @"体检结果";
    
    sectionAry = [NSMutableArray array];
    
    allArray = _myarr;
    DataModel * report = [_myarr firstObject];
    
    for (int i = 0; i<report.second.count; i++)
    {
        [sectionAry addObject:@NO];
    }
     [self creatmyview];
    
    
    [self leftbtn];
 }

-(void)leftbtn
{
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0,23, 25);
    [button setBackgroundImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61f", 25,wBlackColor)] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:button];

}

-(void)fanhui
{
    if (_isTijian==YES)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
        
    }
 }

-(void)rightbtn
{
//    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame=CGRectMake(wScreenW-40-40-20, 0, 40, 25);
//   [button setBackgroundImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61f", 25,wBlackColor)] forState:UIControlStateNormal];
//    
//    [button setTitleColor:wWhiteColor forState:UIControlStateNormal];
//    button.backgroundColor = SHENLANSEcolor;
//    button.titleLabel.font = Font(12);
//    [button addTarget:self action:@selector(bianji:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIButton * aabutton =[UIButton buttonWithType:UIButtonTypeCustom];
//    aabutton.frame=CGRectMake(CGRectGetMaxX(button.frame)+6, 0, 40, 25);
//    [aabutton setTitle:@"添加" forState:UIControlStateNormal];
//    
//    [aabutton setTitleColor:wWhiteColor forState:UIControlStateNormal];
//    aabutton.backgroundColor = RGBwithColor(40, 210, 89);
//    aabutton.titleLabel.font = Font(12);
//    [aabutton addTarget:self action:@selector(tianji:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *negativeSpacer=[[UIBarButtonItem alloc] initWithCustomView:button];
//    
//    UIBarButtonItem *aanegativeSpacer =[[UIBarButtonItem alloc] initWithCustomView:aabutton];
//    //    negativeSpacer.width = -5;
//    
//    self.navigationItem.rightBarButtonItems = @[aanegativeSpacer,negativeSpacer];
//  
    
    
}





-(void)creatmyview
{
    
    DataModel * mod = [_myarr firstObject];
    
    CGFloat hhh = 240;

    self.scrow = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH-64)];
    self.scrow.delegate = self;
    self.scrow.bounces = NO;
    self.scrow.showsVerticalScrollIndicator = NO;
    [self.scrow setContentSize:CGSizeMake(wScreenW ,wScreenH-64 + hhh-40)];
    [self.view addSubview:_scrow];
  
    self.myView = [[UIView alloc] init];
    self.myView.frame = CGRectMake(0, 0, wScreenW, hhh);
    self.myView.backgroundColor = RGBwithColor(140, 205, 255);
    [self.scrow addSubview:_myView];
 
    LineView * line = [[LineView alloc] initWithFrame:CGRectMake(wScreenW/2-80, 20, 160, 160)];
    line.jiaodu = [mod.score_m.score integerValue];
    line.backgroundColor = RGBwithColor(140, 205, 255);

    [_myView addSubview:line];
 
    UILabel * alab = [[UILabel alloc] initWithFrame:CGRectMake(80-25, 50, 50, 30)];
    alab.textAlignment = 1;
    Font(40);
    alab.textColor = RGBwithColor(44, 133, 210);
    alab.text = [mod.score_m.score integerValue]>0?mod.score_m.score :@"0";
    [line addSubview:alab];
    
    UILabel * blab = [[UILabel alloc] initWithFrame:CGRectMake(80-30, CGRectGetMaxY(alab.frame),60, 20)];
    blab.textAlignment = 1;
    blab.font = Font(17);
    blab.textColor = wWhiteColor;
    blab.text = mod.score_m.level;
    [line addSubview:blab];
    
    
    
    NSArray * arr = @[@"基本信息",@"保险利益",@"分析建议"];
    for (NSInteger i = 0; i<3; i++)
    {
        UIButton * selectBut = [UIButton buttonWithType:(UIButtonTypeCustom)];
        selectBut.frame = CGRectMake(wScreenW/3 * i, hhh - 40, wScreenW /3, 40);
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
        selectBut.titleLabel.font = Font(18);
        [self.myView addSubview:selectBut];
        
    }
  
    UIButton * but = [self.view viewWithTag:1221];
    
    UIView * img = [[UIView alloc]init];
    img.frame = CGRectMake(0, 0, wScreenW/3, 2);
    img.backgroundColor = SHENLANSEcolor;
    img.tag = 5656;
    img.center = CGPointMake(but.center.x, CGRectGetMaxY(self.myView.frame)-2);
    [self.myView addSubview:img];
    
    
    litScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_myView.frame), wScreenW, wScreenH-64-40)];
    litScroll.bounces = NO;
    litScroll.pagingEnabled = YES;
    litScroll.delegate = self;
    litScroll.contentSize = CGSizeMake(wScreenW*3,wScreenH-64-40);
    litScroll.showsVerticalScrollIndicator = NO;
    
    [self.scrow addSubview:litScroll];

    [self creattab];
}

-(void)creattab
{
    DataModel * mod = [allArray firstObject];

    WwRelaModel * rela = [mod.rela firstObject];
    
    
    CGFloat ww = (wScreenW-60-10-20)/2;
    
   headView = [[UIView alloc] init];
    headView.frame = CGRectMake(0, 0, wScreenW, 80);
    
    UIImageView * Img = [[UIImageView alloc]init];
    Img.frame = CGRectMake(10, 10, 60, 60);
    Img.layer.masksToBounds = YES;
    Img.layer.cornerRadius = 30;
    [Img sd_setImageWithURL:[NSURL URLWithString:rela.avatar] placeholderImage:[UIImage imageNamed:@"city"]];
    [headView addSubview:Img];
    
    UILabel * nameLaber = [[UILabel alloc] init];
    nameLaber.frame = CGRectMake(CGRectGetMaxX(Img.frame)+10, CGRectGetMinY(Img.frame),ww, 30);
    nameLaber.text = [NSString stringWithFormat:@"姓名: %@",rela.name];
    nameLaber.font = zhongFont;
//    nameLaber.textAlignment = 1;
    nameLaber.textColor = QIANZITIcolor;
    [headView addSubview:nameLaber];
    
    UILabel * ageLaber = [[UILabel alloc]init];
    ageLaber.frame = CGRectMake(CGRectGetMinX(nameLaber.frame), CGRectGetMaxY(nameLaber.frame)+2,ww, 30);
    // self.ageLaber.text = @"30岁";
    ageLaber.font = zhongFont;
//    ageLaber.textAlignment = 1;
    ageLaber.textColor = QIANZITIcolor;
    ageLaber.text =[NSString stringWithFormat:@"年龄: %ld",(long)[WBYRequest getAge:rela.birthday?rela.birthday:@"2017-01-01"]];
    
    [headView addSubview:ageLaber];
    
    
    UILabel * lab1 = [[UILabel alloc]init];
    lab1.frame = CGRectMake(CGRectGetMaxX(ageLaber.frame), 15, 1, 50);
    lab1.backgroundColor = ZTCOlor;
    lab1.alpha = 0.2;
    [headView addSubview:lab1];
    
    UILabel * zhifuLaber = [[UILabel alloc]init];
    zhifuLaber.frame = CGRectMake(CGRectGetMaxX(lab1.frame), CGRectGetMinY(nameLaber.frame), ww, 30);
    zhifuLaber.text = @"共需支付保费";
    zhifuLaber.textAlignment = 1;
    zhifuLaber.font  = zhongFont;
    zhifuLaber.textColor = QIANZITIcolor;
    [headView addSubview:zhifuLaber];
    
    UILabel * rmb = [[UILabel alloc] init];
    
    rmb.frame = CGRectMake(CGRectGetMaxX(lab1.frame), CGRectGetMinY(ageLaber.frame), ww, 30);
    if ([mod.score_m.rate floatValue]<10000)
    {
        
        rmb.text =[NSString stringWithFormat:@"¥ %.2lf 元",[mod.score_m.rate floatValue]] ;
    }else
    {
        rmb.text =[NSString stringWithFormat:@"¥ %.2lf 万",[mod.score_m.rate floatValue]/10000] ;
    }
    rmb.textAlignment = 1;
    rmb.textColor =wRedColor;
    rmb.font = zhongFont;
    [headView addSubview:rmb];
    
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH-64-40) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    myTab.scrollEnabled=NO;
    
    if (dijige==0)
    {
        myTab.tableHeaderView = headView;
    }
    [myTab registerClass:[AAtijiantuOneTableViewCell class] forCellReuseIdentifier:@"cell"];
    [myTab registerClass:[AAtijianTwoTableViewCell class] forCellReuseIdentifier:@"mycell"];
    [myTab registerClass:[AAThreeTableViewCell class] forCellReuseIdentifier:@"threecell"];
    
    myTab.tableFooterView = [[UIView alloc] init];
    
    [litScroll addSubview:myTab];
    [myTab setSeparatorInset:UIEdgeInsetsZero];
    [myTab setLayoutMargins:UIEdgeInsetsZero];
    
}

#pragma mark===代理方法

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (dijige==1)
    {
        return HANGGAO;
        
    }else if (dijige==2)
    {
        return HANGGAO;
    }
    else
    {
        return 0;
    }
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DataModel * report = [allArray firstObject];
    
    UIView * myView;
    UIButton * bigBtn;
//    UIImageView * lImg;
    UILabel * midLab;
    UILabel * rLab;
    UIImageView * rImg;
    UILabel * shu1Lab;
    UILabel * shu2Lab;
    
    
    if (dijige==0)
    {
        return nil;
        
    }else if (dijige==1)
    {
        WBYsecondModel * secondModel = report.second[section];
        
        CGFloat akuan = 30;
        CGFloat hh1= (HANGGAO-30)/2;
        
        UIView * customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, wScreenW, HANGGAO)];
        customView.backgroundColor = wWhiteColor;
        
        UIImageView * img1 = [[UIImageView alloc]init];
        img1.frame = CGRectMake(10, hh1, akuan, akuan);
        
        if ([secondModel.is_main isEqualToString:@"1"])
        {
            img1.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e618", 20, SHENLANSEcolor)];
        }
        if ([secondModel.is_main isEqualToString:@"2"])
        {
           img1.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61e", 20, SHENLANSEcolor)];        }
        if ([secondModel.is_main isEqualToString:@"3"])
        {
            img1.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61a", 20, SHENLANSEcolor)];
        }
        
        [customView addSubview:img1];
        
        UILabel * titLaber = [[UILabel alloc]init];
        titLaber.frame = CGRectMake(CGRectGetMaxX(img1.frame)+5,10,wScreenW-akuan-10-5-70-10-20, HANGGAO-20);
        titLaber.textColor = [UIColor redColor];
        titLaber.font = daFont;
        titLaber.numberOfLines = 0;
        titLaber.text = secondModel.short_name?secondModel.short_name:secondModel.name;
        [customView addSubview:titLaber];
        
        UIButton * But = [UIButton buttonWithType:UIButtonTypeCustom];
        But.frame = CGRectMake(CGRectGetMaxX(titLaber.frame)+10, 15,80,30);
        But.tag = 2121+section;
        But.titleLabel.font = Font(16);
        But.backgroundColor = [UIColor redColor];
        
        [But setTitleEdgeInsets:UIEdgeInsetsMake(2, 4, 2, 4)];
        
        if ([sectionAry[section] boolValue]==NO)
        {
            [But setTitle:@"收起详情" forState:UIControlStateNormal];
        }else
        {
            [But setTitle:@"查看详情" forState:UIControlStateNormal];
        }
        
        [But setTitleColor:wWhiteColor forState:0];
        [But addTarget:self action:@selector(kanxiangqing:) forControlEvents:UIControlEventTouchUpInside];
        But.layer.masksToBounds = YES;
        But.layer.cornerRadius = 5;
        
        [customView addSubview:But];
        
        return customView;
    }else
    {
        
//        NSArray *imgarr = @[ @"fenxi3",@"fenxi5",@"fenxi1",@"fenxi4",@"fenxi2"];
        NSArray *labarr = @[@"保障是否全面",@"保费是否合理",@"重大疾病保障",@"意外保险保额",@"个人缺少保障"];
        
        NSArray *midArr = @[report.total_rate.level,report.cov.level,report.disease_insured.level,report.accident_insured.level,report.hasnt.level?report.hasnt.level:@"无"];
        
        if (!myView)
        {
            myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, HANGGAO)];
            myView.backgroundColor = wWhiteColor;
            
            bigBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            bigBtn.frame = CGRectMake(7,0, wScreenW-14, HANGGAO);
            bigBtn.layer.borderWidth = 1;
            bigBtn.layer.borderColor = wBaseColor.CGColor;
            bigBtn.tag = section;
            [bigBtn addTarget:self action:@selector(dianjikai:) forControlEvents:UIControlEventTouchUpInside];
            [myView addSubview:bigBtn];

            
            midLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, wScreenW/3, HANGGAO-10)];
            midLab.font = daFont;
            midLab.textColor = wBlackColor;
            [bigBtn addSubview:midLab];
            
            rLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(midLab.frame)+10, 10, 50, HANGGAO-20)];
            rLab.font = daFont;
            rLab.layer.masksToBounds = YES;
            rLab.layer.cornerRadius = 7;
            [bigBtn addSubview:rLab];
            
            rImg = [[UIImageView alloc]initWithFrame:CGRectMake(wScreenW -20-10-10, 20, 20, 20)];
            rImg.tag = 6666;
            
            if (isOpen[section]==YES)
            {
                rImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e616",20, wBlackColor)];
            }else
            {
                rImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e617",20, wBlackColor)];
            }
            
            [bigBtn addSubview:rImg];
            
            shu1Lab = [[UILabel alloc] initWithFrame:CGRectMake(2, 1, 2, 58)];
            shu1Lab.backgroundColor = wBaseColor;
            [myView addSubview:shu1Lab];
            
            shu2Lab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW-4, 1, 2, 58)];
            shu2Lab.backgroundColor = wBaseColor;
            [myView addSubview:shu2Lab];
            
        }
        
//        lImg.image = [UIImage imageNamed:imgarr[section]];
        midLab.text = labarr[section];
        rLab.text = midArr[section];
        
        if ([rLab.text isEqualToString:@"偏低"])
        {
            rLab.textColor = wRedColor;
        }else
        {
            rLab.textColor = wBlackColor;
        }
        
        
        return myView;
    }
}


-(void)dianjikai:(UIButton*)aBtn
{
    DataModel * model = [allArray firstObject];
    isOpen[aBtn.tag] = !isOpen[aBtn.tag];
    
    if (aBtn.tag==0)
    {
        htmlStr = model.cov.des;
    }else if (aBtn.tag==1)
    {
        htmlStr = model.total_rate.des;
        
    }else if (aBtn.tag==2)
    {
        htmlStr = model.disease_insured.des;
        
    }else if (aBtn.tag==3)
    {
        htmlStr = model.accident_insured.des;
        
    }else
    {
        htmlStr = model.hasnt.des;
    }
    
    
    [myTab reloadSections:[[NSIndexSet alloc] initWithIndex:aBtn.tag] withRowAnimation:UITableViewRowAnimationFade];
}


-(void)kanxiangqing:(UIButton *)btn
{
    btn.selected = !btn.selected;

     [sectionAry replaceObjectAtIndex:btn.tag-2121 withObject:@(![sectionAry[btn.tag-2121] boolValue])];
    
    [myTab reloadData];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    DataModel * report = [allArray firstObject];
    if (dijige==1)
    {
        return report.second.count;
        
    }else if
        (dijige==0)
    {
        
        return 1;
    }else
    {
        return 5;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DataModel * report = [allArray firstObject];
    if (dijige==0)
    {
        //    WHpros * model = report.pros[indexPath.row];
        return report.pros.count;
    }else if (dijige==1)
    {
        WBYsecondModel * second =report.second[section];
        
        if ([sectionAry[section] boolValue]==NO)
        {
            return second.interests.count;
            
        }else{
            
            return 0;
        }
        
    }else
    {
        if (isOpen[section]==YES)
        {
            //            isOpen[section] = NO;
            return 1;
        }
        else
        {
            return 0;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dijige==0)
    {
        return 170;
    }else if (dijige==1)
    {
       

        if (twoOpen[200*indexPath.section+indexPath.row]==NO)
            {
                
            return HANGGAO;
 
        }else
        {

            DataModel * report = [allArray firstObject];
            WBYsecondModel * mod = report.second[indexPath.section];
            WBYinterestsModel * model = mod.interests[indexPath.row];
            
             CGFloat height = [WBYRequest getAutoHeightForString:[NSString stringWithFormat:@"   %@", model.content] withWidth:wScreenW-20 withFontSize:16.0]+20;

            return HANGGAO+height;
            
        }
        
        
        
    }else{
        
        return 200;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataModel * report = [allArray firstObject];
    
    if (dijige==0)
    {
        
        AAtijiantuOneTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        AAwprosModel * model = report.pros[indexPath.row];
        
        
        if (!cell.oneLab&&!cell.twoLab)
        {
            [cell setModel:model];
  
        }
        
        
        cell.rLab.text = model.short_name?model.short_name:model.name;
        cell.rLab.textColor = wBlackColor;
        
        if ([model.is_main isEqualToString:@"1"])
        {
            cell.lImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e618", 30, SHENLANSEcolor)];
        }
       else if ([model.is_main isEqualToString:@"2"])
        {
            cell.lImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61e", 30, wRedColor)];
        }
        else
        {
            cell.lImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61a", 30, ZuoHeXianColour)];
        }

        if ([model.rate floatValue]<10000)
        {
            cell.fourLab.text =[NSString stringWithFormat:@"%.2lf元",[model.rate floatValue]];
        }else
        {
            cell.fourLab.text =[NSString stringWithFormat:@"%.2lf万元",[model.rate floatValue]/10000];
        }

        if ([model.insured floatValue]<10000)
        {
            cell.fiveLab.text = [NSString stringWithFormat:@"%.2lf元",[model.insured floatValue]];
            
        }else
        {
            cell.fiveLab.text = [NSString stringWithFormat:@"%.2lf万元",[model.insured floatValue]/10000];
        }
//
        
        
        return cell;
        
    }else if (dijige==1)
    {
        WBYsecondModel * mod = report.second[indexPath.section];
        WBYinterestsModel * intered = mod.interests[indexPath.row];
        AAtijianTwoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mycell" forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.lLab.text = [NSString stringWithFormat:@"  %@  ",intered.name];
        
        cell.rLab.text = intered.show;
        
        cell.downlab.tag = 200*indexPath.section+indexPath.row;
        
        [cell setAModel:intered];


        if (twoOpen[cell.downlab.tag]==YES)
        {
            [cell setAModel:intered];
            cell.downlab.hidden = NO;
            
        }else
        {
            cell.downlab.hidden = YES;
        }

        
        
        
        return cell;
    }else
    {
        cell2 = [tableView dequeueReusableCellWithIdentifier:@"threecell" forIndexPath:indexPath];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        cell2.backgroundColor = wBaseColor;
        cell2.myWeb.backgroundColor = wWhiteColor;
        [self loadWithURLString:htmlStr];
        return cell2;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (dijige==1)
    {
        AAtijianTwoTableViewCell * cell = [myTab cellForRowAtIndexPath:indexPath];
      twoOpen[200*indexPath.section+indexPath.row] = !twoOpen[200*indexPath.section+indexPath.row];
        
        
        if (twoOpen[200*indexPath.section+indexPath.row]==YES)
        {
            cell.downlab.hidden = NO;
        }else
        {
            cell.downlab.hidden = YES;
        }
        
        
        [myTab reloadData];
        
    }
    
}



-(void)loadWithURLString:(NSString *)urlStr
{
    
    NSString  * content = [urlStr stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    NSString * contentTwo = [content stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
    
    NSString *str1 = [NSString stringWithFormat:@"<head><style> img{max-width: %fpx;max-height:330px;\n width:expression(document.body.clientWidth>%f?\"%fpx\":\"auto\";\n height:expression(document.body.clientWidth>330?\"330px\":\"auto\");\n overflow:hidden;\n} \n</style></head>",wScreenW-16,wScreenW-16,wScreenW-16];
    NSString *str2 = @"</body><html>";
    
    NSString * html = [NSString stringWithFormat:@"%@%@%@",str1,contentTwo,str2];
    
    [cell2.myWeb loadHTMLString:html baseURL:nil];
}


-(void)llbtn:(UIButton*)btn
{
    DataModel * report = [allArray firstObject];

    WBYsecondModel * mod = [report.second firstObject];
    WBYinterestsModel * intered = mod.interests[btn.tag-2000];
    
    myAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:intered.content delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    
    [myAlert show];
}

-(void)rrbtn:(UIButton*)btn
{
    DataModel * report = [allArray firstObject];
    
    WBYsecondModel * mod = [report.second firstObject];
    WBYinterestsModel * intered = mod.interests[btn.tag-3000];
    
    myAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:intered.premise
                                        delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    
    [myAlert show];
    
}





#pragma mark===点击和滑动事件

-(void)onClickmyBtn:(UIButton*)btn
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
    
    if (dijige==0)
    {
        myTab.tableHeaderView = headView;
    }
    else if (dijige==1)
    {
        [self creatSecondupview];
    }else
    {
        [self creatThree];
    }

    [myTab reloadData];
 
    
}



-(void)requestData
{
    WS(weakSelf);
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:_mongId?_mongId:@"" forKey:@"policy_ids"];
    
    [WBYRequest wbyLoginPostRequestDataUrl:@"get_report" addParameters:dic success:^(WBYReqModel *model)
    {
        if ([model.err isEqualToString:TURE])
        {
            allArray = model.data;
            
            DataModel * report = [model.data firstObject];

            for (int i = 0; i<report.second.count; i++)
            {
                [sectionAry addObject:@NO];
            }
            [weakSelf creatmyview];
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
}

#pragma mark====偏移量
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat myHeight = 240;
    
    if (scrollView==myTab)
    {
        if (scrollView.contentOffset.y<1)
        {
            [UIView animateWithDuration:0.5 animations:^{
                _scrow.contentOffset = CGPointMake(0,0);
                
                myTab.scrollEnabled = NO;
            }];
        }
    }else if (scrollView==_scrow)
    {
        if (scrollView.contentOffset.y>oldContenOffset)
        {
            if (scrollView.contentOffset.y>=1)
            {
                [UIView animateWithDuration:0.5 animations:^{
                    _scrow.contentOffset = CGPointMake(0,myHeight-40);
                    myTab.contentOffset = CGPointMake(0,1);
                    myTab.scrollEnabled = YES;
                    
                }];
            }
            
        }else
        {
            if (scrollView.contentOffset.y>=1)
            {
                [UIView animateWithDuration:0.5 animations:^{
                    _scrow.contentOffset = CGPointMake(0,0);
                    myTab.contentOffset = CGPointMake(0,0);
                    myTab.scrollEnabled = NO;
                }];
            }
        }
        oldContenOffset = scrollView.contentOffset.y;
    }

    
//    if (scrollView==_scrow)
//    {
//        if (scrollView.contentOffset.y>=myHeight-40)
//        {
//            myTab.scrollEnabled=YES;
//        }else
//        {
//            myTab.scrollEnabled=NO;
//        }
//    }
//    
//    if (scrollView==myTab)
//    {
//        if (scrollView.contentOffset.y > oldContenOffset)
//        {
//            NSLog(@"==xia");
//            
//        }else
//        {
//            NSLog(@"==shang%lf",scrollView.contentOffset.y);
//            if (scrollView.contentOffset.y<=0)
//            {
//                myTab.scrollEnabled=NO;
//                
//            }
//         
//        }
//        
//        oldContenOffset = scrollView.contentOffset.y;
//    }
}



-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (scrollView==litScroll)
    {
        int index = scrollView.contentOffset.x/wScreenW;
        dijige = index;
        
        UIImageView * img = [self.view viewWithTag:5656];
        UIButton * btn = [self.view viewWithTag:1221+dijige];
        img.center = CGPointMake(btn.center.x, CGRectGetMaxY(btn.frame)-2);
        
        for (NSInteger i = 0; i < 3; i++)
        {
            UIButton * aBtn = [self.view viewWithTag:1221 + i];
            aBtn.selected = NO;
        }
        btn.selected = YES;
        
        myTab.frame = CGRectMake(wScreenW*dijige, 0, wScreenW, wScreenH-64-40);
        if (dijige==0)
        {
            myTab.tableHeaderView = headView;
        }
        else if (dijige==1)
        {
            [self creatSecondupview];
        }else
        {
            [self creatThree];
        }
        
        [myTab reloadData];
    }
    
}
-(void)creatThree
{
    CGFloat ww = wScreenW/2-10;
    
    DataModel * model = [allArray firstObject];
    
    UIView * myViewTwo = [[UIView alloc] init];
    myViewTwo.frame = CGRectMake(0, 0, wScreenW, 180+6+10);
    
    myTab.tableHeaderView = myViewTwo;
    
    UIView * oneView = [[UIView alloc] initWithFrame:CGRectMake(0, 2, wScreenW/2, 60)];
    [myViewTwo addSubview:oneView];
    
    UIView *viewcc = [[UIView alloc]initWithFrame:CGRectMake(5,5,[model.cov.score floatValue]*ww/[model.cov.total floatValue],55)];
    viewcc.backgroundColor = [UIColor colorWithRed:68.0/255 green:103.0/255 blue:255.0/255 alpha:1];
    
    viewcc.alpha = 0.28;
    [oneView addSubview:viewcc];
    
    UILabel *labe = [[UILabel alloc]initWithFrame:CGRectMake(7+5,10, ww/2+10, 15)];
    labe.text =[NSString stringWithFormat:@"%@",model.cov.name];
    labe.font = newFont(13);
    labe.textColor  = ZTCOlor;
    [oneView addSubview:labe];
    
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(labe.frame), CGRectGetMaxY(labe.frame)+5,CGRectGetWidth(labe.frame), 10)];
    lb.textColor = ZTCOlor;
    lb.font = newFont(10);
    lb.text =[NSString stringWithFormat:@"(参考值%@)",model.cov.total];
    [oneView addSubview:lb];
    
    UILabel *labecc = [[UILabel alloc]initWithFrame:CGRectMake(ww-10-30-15,15,45, 30)];
    labecc.font = Font(20);
    labecc.textAlignment = 2;
    labecc.textColor = wBlackColor;
    labecc.text = [NSString stringWithFormat:@"%@.0",model.cov.score];
    [oneView addSubview:labecc];
    
    UILabel *fenlab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(labecc.frame), 36, 10, 10)];
    fenlab.font = [UIFont systemFontOfSize:9];
    fenlab.text = @"分";
    fenlab.textColor  = ZTCOlor;
    [oneView addSubview:fenlab];
    
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(5,55, ww, 5)];
    image1.image = [UIImage imageNamed:@"aadiyige"];
    [oneView addSubview:image1];
    
    UIView * downV = [[UIView alloc] initWithFrame:CGRectMake(5, 5, ww, 55)];
    downV.layer.borderColor = wBaseColor.CGColor;
    downV.layer.borderWidth = 1;
    
    [oneView addSubview:downV];
    
    [self creatTwo:myViewTwo myModel:model];
    [self creatthree:myViewTwo myModel:model];
    [self creatfour:myViewTwo myModel:model];
    [self creatfive:myViewTwo myModel:model];
    
    
}

-(void)creatTwo:(UIView*)myViewTwo myModel:(DataModel*)model
{
    CGFloat ww = wScreenW/2-10;
    UIView * oneView = [[UIView alloc] initWithFrame:CGRectMake(wScreenW/2, 2, wScreenW/2, 60)];
    [myViewTwo addSubview:oneView];
    
    UIView *viewcc = [[UIView alloc]initWithFrame:CGRectMake(5,5,[model.total_rate.score floatValue]*ww/[model.total_rate.total floatValue],55)];
    viewcc.backgroundColor = [UIColor colorWithRed:144.0/255 green:77.0/255 blue:255.0/255 alpha:1];
    viewcc.alpha = 0.28;
    
    [oneView addSubview:viewcc];
    
    UILabel *labe = [[UILabel alloc]initWithFrame:CGRectMake(7+5,10, ww/2+10, 15)];
    labe.text =[NSString stringWithFormat:@"%@",model.total_rate.name];
    labe.font = newFont(13);
    labe.textColor  = ZTCOlor;
    [oneView addSubview:labe];
    
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(labe.frame), CGRectGetMaxY(labe.frame)+5,CGRectGetWidth(labe.frame), 10)];
    lb.textColor = ZTCOlor;
    lb.font = newFont(10);
    lb.text =[NSString stringWithFormat:@"(参考值%@)",model.total_rate.total
              ];
    [oneView addSubview:lb];
    
    UILabel *labecc = [[UILabel alloc]initWithFrame:CGRectMake(ww-10-30-15,15,45, 30)];
    labecc.font = Font(20);
    labecc.textAlignment = 2;
    labecc.text = [NSString stringWithFormat:@"%@.0",model.total_rate.score];
    [oneView addSubview:labecc];
    
    UILabel *fenlab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(labecc.frame), 36, 10, 10)];
    fenlab.font = [UIFont systemFontOfSize:9];
    fenlab.text = @"分";
    fenlab.textColor  = ZTCOlor;
    [oneView addSubview:fenlab];
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(5,55, ww, 5)];
    image1.image = [UIImage imageNamed:@"aadierge"];
    [oneView addSubview:image1];
    
    UIView * downV = [[UIView alloc] initWithFrame:CGRectMake(5, 5, ww, 55)];
    downV.layer.borderColor = wBaseColor.CGColor;
    downV.layer.borderWidth = 1;
    
    [oneView addSubview:downV];
}

-(void)creatthree:(UIView*)myViewTwo myModel:(DataModel*)model
{
    
    CGFloat ww = wScreenW/2-10;
    UIView * oneView = [[UIView alloc] initWithFrame:CGRectMake(0,62+2, wScreenW/2, 60)];
    
    [myViewTwo addSubview:oneView];
    
    UIView *viewcc = [[UIView alloc]initWithFrame:CGRectMake(5,5,[model.disease_insured.score floatValue]*ww/[model.disease_insured.total floatValue],55)];
    viewcc.backgroundColor = [UIColor colorWithRed:40.0/255 green:214.0/255 blue:142.0/255 alpha:1];
    viewcc.alpha = 0.28;
    
    [oneView addSubview:viewcc];
    
    UILabel *labe = [[UILabel alloc]initWithFrame:CGRectMake(7+5,10, ww/2+10, 15)];
    labe.text =[NSString stringWithFormat:@"%@",model.disease_insured.name];
    labe.font = newFont(13);
    labe.textColor  = ZTCOlor;
    [oneView addSubview:labe];
    
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(labe.frame), CGRectGetMaxY(labe.frame)+5,CGRectGetWidth(labe.frame), 10)];
    lb.textColor = ZTCOlor;
    lb.font = newFont(10);
    lb.text =[NSString stringWithFormat:@"(参考值%@)",model.disease_insured.total
              ];
    [oneView addSubview:lb];
    
    UILabel *labecc = [[UILabel alloc]initWithFrame:CGRectMake(ww-10-30-15,15,45, 30)];
    labecc.font = Font(20);
    labecc.textAlignment = 2;
    labecc.text = [NSString stringWithFormat:@"%@.0",model.disease_insured.score];
    
    [oneView addSubview:labecc];
    
    UILabel *fenlab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(labecc.frame), 36, 10, 10)];
    fenlab.font = [UIFont systemFontOfSize:9];
    fenlab.text = @"分";
    fenlab.textColor  = ZTCOlor;
    [oneView addSubview:fenlab];
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(5,55, ww, 5)];
    image1.image = [UIImage imageNamed:@"aadsg"];
    [oneView addSubview:image1];
    UIView * downV = [[UIView alloc] initWithFrame:CGRectMake(5, 5, ww, 55)];
    downV.layer.borderColor = wBaseColor.CGColor;
    downV.layer.borderWidth = 1;
    
    [oneView addSubview:downV];
    
}

-(void)creatfour:(UIView*)myViewTwo myModel:(DataModel*)model
{
    CGFloat ww = wScreenW/2-10;
    UIView * oneView = [[UIView alloc] initWithFrame:CGRectMake(wScreenW/2,62+2, wScreenW/2, 60)];
    [myViewTwo addSubview:oneView];
    
    UIView *viewcc = [[UIView alloc]initWithFrame:CGRectMake(5,5,[model.accident_insured.score floatValue]*ww/[model.accident_insured.total floatValue],55)];
    viewcc.backgroundColor = [UIColor colorWithRed:234.0/255 green:119.0/255 blue:67.0/255 alpha:1];
    viewcc.alpha = 0.28;
    
    [oneView addSubview:viewcc];
    
    UILabel *labe = [[UILabel alloc]initWithFrame:CGRectMake(7+5,10, ww/2+10, 15)];
    labe.text =[NSString stringWithFormat:@"%@",model.accident_insured.name];
    labe.font = newFont(13);
    labe.textColor  = ZTCOlor;
    [oneView addSubview:labe];
    
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(labe.frame), CGRectGetMaxY(labe.frame)+5,CGRectGetWidth(labe.frame), 10)];
    lb.textColor = ZTCOlor;
    lb.font = newFont(10);
    lb.text =[NSString stringWithFormat:@"(参考值%@)",model.accident_insured.total
              ];
    [oneView addSubview:lb];
    
    UILabel *labecc = [[UILabel alloc]initWithFrame:CGRectMake(ww-10-30-15,15,45, 30)];
    labecc.font = Font(20);
    labecc.textAlignment = 2;
    labecc.text = [NSString stringWithFormat:@"%@.0",model.accident_insured.score];
    
    [oneView addSubview:labecc];
    
    UILabel *fenlab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(labecc.frame), 36, 10, 10)];
    fenlab.font = [UIFont systemFontOfSize:9];
    fenlab.text = @"分";
    fenlab.textColor  = ZTCOlor;
    [oneView addSubview:fenlab];
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(5,55, ww, 5)];
    image1.image = [UIImage imageNamed:@"aadisige"];
    [oneView addSubview:image1];
    UIView * downV = [[UIView alloc] initWithFrame:CGRectMake(5, 5, ww, 55)];
    downV.layer.borderColor = wBaseColor.CGColor;
    downV.layer.borderWidth = 1;
    
    [oneView addSubview:downV];
    
}

-(void)creatfive:(UIView*)myViewTwo myModel:(DataModel*)model
{
    CGFloat ww = wScreenW-4;
    UIView * oneView = [[UIView alloc] initWithFrame:CGRectMake(2,62+2+62+2, ww, 60)];
    [myViewTwo addSubview:oneView];
    
    UIView *viewcc = [[UIView alloc]initWithFrame:CGRectMake(5,5,[model.hasnt.score floatValue]*ww/[model.hasnt.total floatValue],55)];
    viewcc.backgroundColor = [UIColor colorWithRed:255.0/255 green:160.0/255 blue:192.0/255 alpha:1];
    viewcc.alpha = 0.28;
    
    [oneView addSubview:viewcc];
    
    UILabel *labe = [[UILabel alloc]initWithFrame:CGRectMake(7+5,10, ww/2+10, 15)];
    labe.text =[NSString stringWithFormat:@"%@",model.hasnt.name];
    labe.font = newFont(13);
    labe.textColor  = ZTCOlor;
    [oneView addSubview:labe];
    
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(labe.frame), CGRectGetMaxY(labe.frame)+5,CGRectGetWidth(labe.frame), 10)];
    lb.textColor = ZTCOlor;
    lb.font = newFont(10);
    lb.text =[NSString stringWithFormat:@"(参考值%@)",model.hasnt.total
              ];
    [oneView addSubview:lb];
    
    UILabel *labecc = [[UILabel alloc]initWithFrame:CGRectMake(ww-10-30-15-5-5,15,45, 30)];
    labecc.font = Font(20);
    labecc.textAlignment = 2;
    labecc.text = [NSString stringWithFormat:@"%@.0",model.hasnt.score];
    [oneView addSubview:labecc];
    
    UILabel *fenlab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(labecc.frame), 36, 10, 10)];
    fenlab.font = [UIFont systemFontOfSize:9];
    fenlab.text = @"分";
    fenlab.textColor  = ZTCOlor;
    [oneView addSubview:fenlab];
    
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(5,55, ww-10, 5)];
    image1.image = [UIImage imageNamed:@"aadiwuge"];
    [oneView addSubview:image1];
    
    UIView * downV = [[UIView alloc] initWithFrame:CGRectMake(5, 5, ww-10, 55)];
    downV.layer.borderColor = wBaseColor.CGColor;
    downV.layer.borderWidth = 1;
    [oneView addSubview:downV];
    
}


-(void)creatSecondupview
{
    UIView * myViewTwo = [[UIView alloc] init];
    myViewTwo.frame = CGRectMake(0, 0, wScreenW, 40);
    
    UILabel * titLaber = [[UILabel alloc] init];
    titLaber.frame = CGRectMake(10, 5,wScreenW -20, 35);
    titLaber.text = @"具体利益";
    titLaber.backgroundColor = Wqingse;
    titLaber.font = daFont;
    titLaber.textAlignment = NSTextAlignmentCenter;
    titLaber.textColor = [UIColor whiteColor];
    [myViewTwo addSubview:titLaber];
    
    myTab.tableHeaderView = myViewTwo;
    
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
