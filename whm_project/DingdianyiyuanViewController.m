//
//  DingdianyiyuanViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DingdianyiyuanViewController.h"
#import "PickView.h"
#import "ZMFloatButton.h"
#import "DingdianyiyuanTableViewCell.h"
#import "completeTableViewCell.h"
#import "AAyiyuanxiangqingViewController.h"
#import "AAxinyiyuandituViewController.h"

@interface DingdianyiyuanViewController ()<UISearchBarDelegate,IFlyRecognizerViewDelegate,UITableViewDelegate,UITableViewDataSource,ZMFloatButtonDelegate,CMIndexBarDelegate>
{
    UISearchBar * _searchBar;
    UITableView * myTab;
    UIView *_chooseCityView;
    NSMutableArray * allData;
    NSInteger numindex;
    NSMutableArray * agongsiArray;
    NSMutableArray * _firstArr;
    UITableView * gongsiTab;
    UIView * gongsiView;

    UIView * downView;
    NSArray * dengjiarr;
    NSArray * xingzhiarr;
    NSArray * yibaoarr;
    
    
    NSString * dengjiStr;
    NSString * xingzhiStr;
    NSString * dingdianStr;

    CMIndexBar *indexBar;
    NSString * tel;
    NSString * gongsiId;
    
    
}
@property (nonatomic,strong) PickView * cityPickerView;

@property (nonatomic,strong) IFlyRecognizerView *iflyRecognizerView;//带界面的识别对象
@property (nonatomic,strong) IFlyPcmRecorder *pcmRecorder;//录音器，用于音频流识别的数据传入
@property (nonatomic,strong)NSMutableDictionary * dic;

@end

@implementation DingdianyiyuanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    allData = [NSMutableArray array];
    agongsiArray = [NSMutableArray array];
    _firstArr = [NSMutableArray array];
    self.dic = [NSMutableDictionary dictionary];
    numindex = 1;
    NSString * jingdu = LNGONE;
    NSString * weidu = LATTWO;
    
    if (jingdu.length>=1&&weidu.length>=1)
    {
        [self requestleiBieDateDatalng:jingdu latStr:weidu proStr:@"" cityStr:@"" countyStr:@"" gongsiId:@"" yiyuanjibie:@"" guanjianzi:@"" shuxing:@"" dingdian:@""];
        
    }else
    {
        [WBYRequest showMessage:@"无法获取当前位置"];
    }
    
    [self requestBaoXianGongSi];
    [self sousuokuang];
    [self creatmyview];
    

}

-(void)creatmyview
{
    UIView * upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 40)];
    
    [self.view addSubview:upView];
    
    NSArray * litArr = @[CHENGSHI,@"保险公司",@"筛选"];
    for (NSInteger i = 0; i<litArr.count; i++)
    {
        UIButton * quxiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        quxiaoBtn.frame = CGRectMake(i * wScreenW/3,0, wScreenW/3, 35);
        quxiaoBtn.tag = 1313 + i;
        [quxiaoBtn setTitle:litArr[i] forState:UIControlStateNormal];
        [quxiaoBtn setTitleColor:wGrayColor2 forState:UIControlStateNormal];
        quxiaoBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [quxiaoBtn addTarget:self action:@selector(dianji:) forControlEvents:UIControlEventTouchUpInside];
        [upView addSubview:quxiaoBtn];
        
        UIButton * xiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        xiaoBtn.frame = CGRectMake(i * wScreenW/3 + wScreenW/3-26, 10, 15, 15);
        xiaoBtn.tag = 3030 + i;
        
        [xiaoBtn setImage:[UIImage imageNamed:@"arrowT"] forState:UIControlStateNormal];
        [xiaoBtn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateSelected];
        
        [upView addSubview:xiaoBtn];
        
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW/3*i-1, 1,0.8, 37)];
        lab.backgroundColor = wGrayColor;
        lab.alpha=0.3;
        [upView addSubview:lab];
        
        
    }
    
    UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake(0,38,wScreenW, 0.8)];
    lab1.backgroundColor = wGrayColor;
    [upView addSubview:lab1];
    
    _cityPickerView = [[PickView alloc] init];
    _cityPickerView.backgroundColor= wWhiteColor;
    
    [self creattab];
    
}
-(void)creattab
{
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0,40, wScreenW, wScreenH - 64 - 40) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    myTab.tag = 500;
    myTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [myTab registerClass:[DingdianyiyuanTableViewCell class] forCellReuseIdentifier:@"cell"];
    myTab.rowHeight = 80;
    myTab.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    myTab.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
    [self.view addSubview:myTab];
    
    UIView * bgv = [[UIView alloc] init];
    myTab.tableFooterView = bgv;
    
    [myTab setSeparatorInset:UIEdgeInsetsZero];
    [myTab setLayoutMargins:UIEdgeInsetsZero];
    
    [self huadongbutton];

}
#pragma mark===加载

-(void)headerRereshing
{
    
    UIButton * aBtn = [self.view viewWithTag:1313];
    aBtn.titleLabel.text =@"地区";
    numindex = 1 ;
    
   [self requestleiBieDateDatalng:LNGONE latStr:LATTWO proStr:@"" cityStr:@"" countyStr:@"" gongsiId:@"" yiyuanjibie:@"" guanjianzi:@"" shuxing:@"" dingdian:@""];
    
    
    [myTab.mj_header endRefreshing];
    
}
//下拉
-(void)footerRefreshing
{
//    UIButton * aBtn = [self.view viewWithTag:1313];
//    aBtn.titleLabel.text =@"地区";
    numindex ++ ;
    [self requestleiBieDateDatalng:LNGONE latStr:LATTWO proStr:@"" cityStr:@"" countyStr:_cityPickerView.idarea.length>1?_cityPickerView.idarea:@"" gongsiId:gongsiId?gongsiId:@"" yiyuanjibie:dengjiStr?dengjiStr:@"" guanjianzi:_searchBar.text?_searchBar.text:@"" shuxing:xingzhiStr?xingzhiStr:@"" dingdian:[dingdianStr isEqualToString:@"是"]?@"1":@""];

    [myTab.mj_footer endRefreshing];
    
}


#pragma mark==公司筛选
-(void)cratShaiXuanGongsi
{
    
    gongsiView = [[UIView alloc] initWithFrame:CGRectMake(0,40, wScreenW, wScreenH - 64 - 40)];
    
    [self.view addSubview:gongsiView];
    
    gongsiTab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, wScreenW, wScreenH - 64 - 40) style:UITableViewStylePlain];
    gongsiTab.dataSource = self;
    gongsiTab.delegate =self;
    gongsiTab.tag = 1000;
    gongsiTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [gongsiTab registerClass:[completeTableViewCell class] forCellReuseIdentifier:@"comcell"];
    [gongsiView addSubview:gongsiTab];
    
    [self createList];
}

- (void)createList
{
    indexBar = [[CMIndexBar alloc] initWithFrame:CGRectMake(wScreenW-25, 30, 25.0, wScreenH - 40 - 35 - 60- 50)];
    //        indexBar.backgroundColor = [UIColor redColor];
    indexBar.textColor = [UIColor colorWithRed:61/255.0 green:163/255.0  blue:255/255.0  alpha:1.0];
    indexBar.textFont = [UIFont systemFontOfSize:12];
    [indexBar setIndexes:_firstArr];
    
    indexBar.delegate = self;
    [gongsiView addSubview:indexBar];
    
}
-(void)dianji:(UIButton*)btn
{
    [_searchBar resignFirstResponder];
    
    [self.view endEditing:YES];
    btn.selected = !btn.selected;
    for (NSInteger i =0; i<3; i++)
    {
        UIButton * litBtn = [self.view viewWithTag:3030 + i];
        litBtn.selected = NO;
        if (btn.tag-1313==litBtn.tag-3030)
        {
            litBtn.selected = btn.selected;
        }
    }
    [gongsiView removeFromSuperview];
    
    if (btn.tag==1313)
    {
        [gongsiView removeFromSuperview];
        [downView removeFromSuperview];
        if (btn.selected==YES)
        {
            [self creatpickvie];
            
        }else
        {
            [_cityPickerView hiddenPickerView];
            
        }
        
        
    }else if (btn.tag==1313+1)
    {
        [_cityPickerView hiddenPickerView];
        [downView removeFromSuperview];
        
        if (btn.selected==YES)
        {
            [self cratShaiXuanGongsi];
        }else
        {
            [gongsiView removeFromSuperview];
            
        }
        
    }else
    {
        
        [_cityPickerView hiddenPickerView];
        [gongsiView removeFromSuperview];
        
        if (btn.selected==YES)
        {
            [self yiyuanshaixuan];
        }else
        {
            [downView removeFromSuperview];
        }
    }
}

-(void)yiyuanshaixuan
{
    dengjiarr = @[@"不限",@"三级甲等",@"三级乙等",@"三级丙等",@"二级甲等",@"二级乙等",@"二级丙等",@"其他医院"];
    xingzhiarr = @[@"不限",@"公立医院",@"私立医院"];
    yibaoarr = @[@"不限",@"是",@"否"];
    
    
    downView = [[UIView alloc] initWithFrame:CGRectMake(0,40, wScreenW, wScreenH)];
    //    downView.backgroundColor = [UIColor colorWithRed:245.f/255.f green:247.f/255.f blue:249.f/255.f alpha:1];
    downView.backgroundColor = wWhiteColor;
    
    [self.view addSubview:downView];
    
    UILabel * upLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, wScreenW-20,30)];
    upLab.text = @"医院等级";
    upLab.font = [UIFont systemFontOfSize:14.0f];
    [downView addSubview:upLab];
    
    
    CGFloat ww = (wScreenW - 5*6)/4;
    
    for (NSInteger i = 0; i< dengjiarr.count; i++)
    {
        NSInteger aa = i%4;
        NSInteger bb = i/4;
        UIButton * quxiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        quxiaoBtn.frame = CGRectMake(6 + (ww + 6)*aa,30 + 5 + (16 + 30)*bb, ww, 30);
        quxiaoBtn.tag = 5858 + i;
        [quxiaoBtn setTitle:dengjiarr[i] forState:UIControlStateNormal];
        [quxiaoBtn setTitleColor:wGrayColor2 forState:UIControlStateNormal];
        [quxiaoBtn setTitleColor:wWhiteColor forState:UIControlStateSelected];
        
        if (i == 0)
        {
            quxiaoBtn.selected = YES;
            quxiaoBtn.backgroundColor = wBlue;
        }
        quxiaoBtn.layer.masksToBounds = YES;
        quxiaoBtn.layer.borderColor = wGrayColor.CGColor;
        quxiaoBtn.layer.borderWidth = 0.6;
        quxiaoBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [quxiaoBtn addTarget:self action:@selector(dengji:) forControlEvents:UIControlEventTouchUpInside];
        [downView addSubview:quxiaoBtn];
        
    }
    
    UILabel * midLab = [[UILabel alloc] initWithFrame:CGRectMake(10,30+30+46+10, wScreenW-20, 30)];
    midLab.text = @"医院性质";
    midLab.font = [UIFont systemFontOfSize:14.0f];
    [downView addSubview:midLab];
    
    for (NSInteger i = 0; i< xingzhiarr.count; i++)
    {
        NSInteger aa = i%4;
        UIButton * quxiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        quxiaoBtn.frame = CGRectMake(6 + (ww + 6)*aa,CGRectGetMaxY(midLab.frame), ww, 30);
        quxiaoBtn.tag = 6868 + i;
        [quxiaoBtn setTitle:xingzhiarr[i] forState:UIControlStateNormal];
        [quxiaoBtn setTitleColor:wGrayColor2 forState:UIControlStateNormal];
        [quxiaoBtn setTitleColor:wWhiteColor forState:UIControlStateSelected];
        if (i == 0)
        {
            quxiaoBtn.selected = YES;
            quxiaoBtn.backgroundColor = wBlue;
        }
        quxiaoBtn.layer.masksToBounds = YES;
        quxiaoBtn.layer.borderColor = wGrayColor.CGColor;
        quxiaoBtn.layer.borderWidth = 0.6;
        quxiaoBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [quxiaoBtn addTarget:self action:@selector(dengji:) forControlEvents:UIControlEventTouchUpInside];
        [downView addSubview:quxiaoBtn];
        
    }
    
    
    UILabel * downLab = [[UILabel alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(midLab.frame)+5+30, wScreenW-20, 30)];
    downLab.text = @"医保定点";
    downLab.font = Font(14);
    [downView addSubview:downLab];
    
    
    for (NSInteger i = 0; i< yibaoarr.count; i++)
    {
        NSInteger aa = i%4;
        UIButton * quxiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        quxiaoBtn.frame = CGRectMake(6 + (ww + 6)*aa,CGRectGetMaxY(midLab.frame)+30+30+5, ww, 30);
        quxiaoBtn.tag = 7878 + i;
        [quxiaoBtn setTitle:yibaoarr[i] forState:UIControlStateNormal];
        [quxiaoBtn setTitleColor:wGrayColor2 forState:UIControlStateNormal];
        [quxiaoBtn setTitleColor:wWhiteColor forState:UIControlStateSelected];
        if (i == 0)
        {
            quxiaoBtn.selected = YES;
            quxiaoBtn.backgroundColor = wBlue;
        }
        quxiaoBtn.layer.masksToBounds = YES;
        quxiaoBtn.layer.borderColor = wGrayColor.CGColor;
        quxiaoBtn.layer.borderWidth = 0.6;
        quxiaoBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [quxiaoBtn addTarget:self action:@selector(dengji:) forControlEvents:UIControlEventTouchUpInside];
        [downView addSubview:quxiaoBtn];
        
    }
    
    CGFloat btnww = (wScreenW-40*2-20)/2;
    UIButton * downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    downBtn.frame = CGRectMake(40,CGRectGetMaxY(downLab.frame)+100, btnww,30);
    //    downBtn.backgroundColor = wBlue;
    [downBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [downBtn setTitle:@"取消" forState:UIControlStateNormal];
    downBtn.layer.masksToBounds = YES;
    downBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    downBtn.tag = 9999;
    [downBtn addTarget:self action:@selector(queOrQuxiao:) forControlEvents:UIControlEventTouchUpInside];
    downBtn.layer.borderColor = wGrayColor.CGColor;
    downBtn.layer.borderWidth = 0.6;
    
    downBtn.layer.masksToBounds = YES;
    downBtn.layer.cornerRadius = 15;
    [downView addSubview:downBtn];
    
    UIButton * rrdownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rrdownBtn.frame = CGRectMake(CGRectGetMaxX(downBtn.frame)+20,CGRectGetMaxY(downLab.frame)+100, btnww,30);
    rrdownBtn.backgroundColor = wRedColor;
    [rrdownBtn setTitleColor:wWhiteColor forState:UIControlStateNormal];
    [rrdownBtn setTitle:@"确定" forState:UIControlStateNormal];
    rrdownBtn.layer.masksToBounds = YES;
    rrdownBtn.layer.borderColor = wGrayColor.CGColor;
    rrdownBtn.layer.borderWidth = 0.6;
    [rrdownBtn addTarget:self action:@selector(queOrQuxiao:) forControlEvents:UIControlEventTouchUpInside];
    
    rrdownBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    rrdownBtn.layer.masksToBounds = YES;
    rrdownBtn.layer.cornerRadius = 15;
    [downView addSubview:rrdownBtn];
    
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(rrdownBtn.frame)+8, wScreenW, 20)];
    img.image = [UIImage imageNamed:@"iconbotton"];
    [downView addSubview:img];
    
    UIView* botView = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(img.frame), wScreenW,200)];
    botView.backgroundColor = wGrayColor;
    
    [downView addSubview:botView];
    
    
}

-(void)queOrQuxiao:(UIButton*)btn
{
    [downView removeFromSuperview];
    
    UIButton * abtn = [self.view viewWithTag:3030+2];
    
    abtn.selected = NO;
    
    
    if (btn.tag==9999)
    {
        //取消
        
    }else
    {
        NSString * dingg;
        if ([dingdianStr isEqualToString:@"是"])
        {
            dingg = @"1";
        }else if ([dingdianStr isEqualToString:@"否"])
        {
            dingg=@"0";
        }else
        {
            dingg = @"";
            
        }
    [self requestleiBieDateDatalng:@"" latStr:@"" proStr:@"" cityStr:@"" countyStr:@"" gongsiId:@"" yiyuanjibie:dengjiStr?dengjiStr:@"" guanjianzi:@"" shuxing:xingzhiStr?xingzhiStr:@"" dingdian:dingg];
        
    }
    
    
}


-(void)dengji:(UIButton *)btn
{
    //   5858  6868 7878
    
    
    
    if (btn.tag>=5858 &&btn.tag<=5858+7)
    {
        for (NSInteger i=0; i<8; i++)
        {
            UIButton * btn1 =[downView viewWithTag:5858+i];
            btn1.selected = NO;
            btn1.backgroundColor = wWhiteColor;
        }
        btn.selected = YES;
        btn.backgroundColor = wBlue;
        dengjiStr = dengjiarr[btn.tag-5858];
        
    }
    
    
    if (btn.tag>=6868 &&btn.tag<=6868+2)
    {
        for (NSInteger i=0; i<3; i++)
        {
            UIButton * btn1 =[downView viewWithTag:6868+i];
            btn1.selected = NO;
            btn1.backgroundColor = wWhiteColor;
        }
        btn.selected = YES;
        btn.backgroundColor = wBlue;
        
        xingzhiStr = xingzhiarr[btn.tag - 6868];
        
    }
    
    
    if (btn.tag>=7878 &&btn.tag<=7878+2)
    {
        for (NSInteger i=0; i<3; i++)
        {
            UIButton * btn1 =[downView viewWithTag:7878+i];
            btn1.selected = NO;
            btn1.backgroundColor = wWhiteColor;
        }
        btn.selected = YES;
        btn.backgroundColor = wBlue;
        dingdianStr = yibaoarr[btn.tag-7878];
    }
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    numindex = 1 ;
    [searchBar resignFirstResponder];
    
    [self requestleiBieDateDatalng:@"" latStr:@"" proStr:@"" cityStr:@"" countyStr:@"" gongsiId:@"" yiyuanjibie:@"" guanjianzi:searchBar.text?searchBar.text:@"" shuxing:@"" dingdian:@""];
}


#pragma mark===地区选择器
-(void)creatpickvie
{
    [UIView animateWithDuration:0.3f animations:^{
        _chooseCityView.frame = CGRectMake(-2, self.view.frame.size.height - 240, self.view.frame.size.width+4, 40);
    }];
    [_cityPickerView showInView:self.view];
    
    _chooseCityView = [[UIView alloc]initWithFrame:CGRectMake(0,0,wScreenW, 40)];
    _chooseCityView.backgroundColor = [UIColor whiteColor];
    _chooseCityView.layer.borderColor = [UIColor whiteColor].CGColor;
    _chooseCityView.layer.borderWidth = 0.6f;
    [_cityPickerView addSubview:_chooseCityView];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(12, 0, 40, 40);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(pickerviewbuttonclick:) forControlEvents:UIControlEventTouchUpInside];
    [_chooseCityView addSubview:cancelButton];
    
    UIButton *chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseButton.frame = CGRectMake(self.view.frame.size.width - 50, 0, 40, 40);
    [chooseButton setTitle:@"确定" forState:UIControlStateNormal];
    chooseButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [chooseButton setTitleColor:wBlue forState:UIControlStateNormal];
    [chooseButton addTarget:self action:@selector(pickerviewbuttonclick:) forControlEvents:UIControlEventTouchUpInside];
    [_chooseCityView addSubview:chooseButton];
    
    
}

- (void)pickerviewbuttonclick:(UIButton *)sender
{
    UIButton * aBtn = [self.view viewWithTag:1313];
    
    for (NSInteger i =0; i<3; i++)
    {
        UIButton * litBtn = [self.view viewWithTag:3030 + i];
        litBtn.selected = NO;
        
    }
    
    if ([sender.titleLabel.text isEqualToString:@"确定"])
    {
        aBtn.titleLabel.text = [NSString stringWithFormat:@"%@",_cityPickerView.qu];
        
     
        
//        [self requestleiBieDateDatalng:@"" latStr:@"" proStr:_cityPickerView.idprovence.length>1?_cityPickerView.idprovence:@"" cityStr:_cityPickerView.idcity.length>1?_cityPickerView.idcity:@"" countyStr:_cityPickerView.idarea.length>1?_cityPickerView.idarea:@"" comId:@"" dengji:@"" dingdian:@"" shuxing:@"" keywoed:@""];
        
        [self requestleiBieDateDatalng:@"" latStr:@"" proStr:_cityPickerView.idprovence.length>1?_cityPickerView.idprovence:@"" cityStr:_cityPickerView.idcity.length>1?_cityPickerView.idcity:@"" countyStr:_cityPickerView.idarea.length>1?_cityPickerView.idarea:@"" gongsiId:@"" yiyuanjibie:@"" guanjianzi:@"" shuxing:@"" dingdian:@""];
        
    }
    
    [_cityPickerView hiddenPickerView];
    
}








-(void)sousuokuang
{
    [self creatLeftTtem];
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 38, 30);
    [button setTitle:@"搜索" forState:UIControlStateNormal];
    
    [button setTitleColor:SHENLANSEcolor forState:UIControlStateNormal];
    
    
    [button addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, wScreenW-100, 30)];
    UIColor *color =  self.navigationController.navigationBar.barTintColor;
    [titleView setBackgroundColor:color];
    
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.delegate = self;
    _searchBar.frame = CGRectMake(10, 0, wScreenW-100-20, 30);
    _searchBar.backgroundColor = wWhiteColor;
    [_searchBar.layer setBorderWidth:0.5];
    [_searchBar.layer setBorderColor:QIANLANSEcolor.CGColor];  //设置边框为白色
    [_searchBar changeLeftPlaceholder:@" 请输入搜索内容"];
    [titleView addSubview:_searchBar];
    
    UIButton * myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    myBtn.frame = CGRectMake(CGRectGetMaxX(_searchBar.frame) - 40 - 2,2.5, 30, 25);
    [myBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e60c", 20,QIANLANSEcolor)] forState:UIControlStateNormal];
    myBtn.tag = 12345;
    
    [myBtn addTarget:self action:@selector(onClickMyBtn) forControlEvents:UIControlEventTouchUpInside];
    [_searchBar addSubview:myBtn];
    
    UITextField *searchField=[_searchBar valueForKey:@"_searchField"];
    searchField.borderStyle = UITextBorderStyleNone;
    searchField.backgroundColor = wWhiteColor;
    
    for (UIView * view in _searchBar.subviews)
    {
        for (id subview in view.subviews)
        {
            if ([subview isKindOfClass:[UITextField class]])
            {
                UITextField *textField = (UITextField *)subview;
                textField.clipsToBounds = NO;
                textField.leftView = nil;
            }
        }
    }
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = titleView;
}

-(void)onClickMyBtn
{
    [_searchBar resignFirstResponder];
    [self changeOnclick];
}

#pragma mark===搜索

-(void)backButtonClick
{
    [_searchBar resignFirstResponder];
    if (_searchBar.text.length>=1)
    {
//        [self requestleiBieDateDatalng:@"" latStr:@"" proStr:@"" cityStr:@"" countyStr:@"" jigouleixingId:@"" gslx:@"" guanjianzi:_searchBar.text?_searchBar.text:@""];
        
        [self requestleiBieDateDatalng:@"" latStr:@"" proStr:@"" cityStr:@"" countyStr:@"" gongsiId:@"" yiyuanjibie:@"" guanjianzi:_searchBar.text?_searchBar.text:@"" shuxing:@"" dingdian:@""];
    }else
    {
        [WBYRequest showMessage:@"请输入搜索内容"];
    }
    
}

//-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
//{
//    [_searchBar resignFirstResponder];
//    
//    if (_searchBar.text.length>=1)
//    {
////        [self requestleiBieDateDatalng:@"" latStr:@"" proStr:@"" cityStr:@"" countyStr:@"" jigouleixingId:@"" gslx:@"" guanjianzi:_searchBar.text?_searchBar.text:@""];
//    }else
//    {
//        [WBYRequest showMessage:@"请输入搜索内容"];
//    }
//    
//}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    UIButton * btn = [[[UIApplication sharedApplication].delegate window] viewWithTag:12345];
    if (searchText.length>0)
    {
        btn.hidden = YES;
    }else
    {
        btn.hidden = NO;
    }
}

#pragma mark====语音
-(void)changeOnclick
{
    if(_iflyRecognizerView == nil)
    {
        [self initRecognizer ];
    }
    
    //[_textView setText:@""];
    // [_textView resignFirstResponder];
    
    _searchBar.text = @"";
    //设置音频来源为麦克风
    [_iflyRecognizerView setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
    
    //设置听写结果格式为json
    [_iflyRecognizerView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
    
    //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
    [_iflyRecognizerView setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    
    BOOL ret = [_iflyRecognizerView start];
    if (ret) {
        //        [_startRecBtn setEnabled:NO];
        //        [_audioStreamBtn setEnabled:NO];
        //        [_upWordListBtn setEnabled:NO];
        //        [_upContactBtn setEnabled:NO];
    }
}
/**
 设置识别参数
 ****/
-(void)initRecognizer
{
    NSLog(@"%s",__func__);
    //单例模式，UI的实例
    if (_iflyRecognizerView == nil) {
        //UI显示剧中
        _iflyRecognizerView= [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
        
        [_iflyRecognizerView setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        
        //设置听写模式
        [_iflyRecognizerView setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        
    }
    _iflyRecognizerView.delegate = self;
    
    if (_iflyRecognizerView != nil)
    {
        IATConfig *instance = [IATConfig sharedInstance];
        //设置最长录音时间
        [_iflyRecognizerView setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        //设置后端点
        [_iflyRecognizerView setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
        //设置前端点
        [_iflyRecognizerView setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
        //网络等待时间
        [_iflyRecognizerView setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
        
        //设置采样率，推荐使用16K
        [_iflyRecognizerView setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
        if ([instance.language isEqualToString:[IATConfig chinese]]) {
            //设置语言
            [_iflyRecognizerView setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
            //设置方言
            [_iflyRecognizerView setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
        }else if ([instance.language isEqualToString:[IATConfig english]]) {
            //设置语言
            [_iflyRecognizerView setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
        }
        //设置是否返回标点符号
        [_iflyRecognizerView setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
        
    }
    
}

/**
 有界面，听写结果回调
 resultArray：听写结果
 isLast：表示最后一次
 ****/
- (void)onResult:(NSArray *)resultArray isLast:(BOOL)isLast
{
    
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [resultArray objectAtIndex:0];
    
    for (NSString *key in dic)
    {
        [result appendFormat:@"%@",key];
    }
    
    _searchBar.text = [NSString stringWithFormat:@"%@%@",_searchBar.text,result];
    
    if (_searchBar.text.length>=1)
    {
        
        [self requestleiBieDateDatalng:@"" latStr:@"" proStr:@"" cityStr:@"" countyStr:@"" gongsiId:@"" yiyuanjibie:@"" guanjianzi:_searchBar.text shuxing:@"" dingdian:@""];
    }

    
    UIButton * btn = [[[UIApplication sharedApplication].delegate window] viewWithTag:12345];
    
    if (_searchBar.text.length>=1)
    {
        btn.hidden = YES;
    }
}


- (void)onError: (IFlySpeechError *) error
{
    NSLog(@"===%@",error);
    
}




-(void)huadongbutton
{
    ZMFloatButton * floatBtn = [[ZMFloatButton alloc]initWithFrame:CGRectMake(wScreenW-60-15,wScreenH-64-60-20, 60, 60)];
    floatBtn.delegate = self;
    //floatBtn.isMoving = NO;
    floatBtn.bannerIV.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e624", 60, SHENLANSEcolor)];
    [self.view addSubview:floatBtn];
    [self.view bringSubviewToFront:floatBtn];
}
#pragma mark -ZMFloatButtonDelegate
- (void)floatTapAction:(ZMFloatButton *)sender
{
    //点击执行事件
    [self.navigationController pushViewController:[AAxinyiyuandituViewController new] animated:YES];
}


#pragma mark====代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 500)
    {
        return allData.count;
        
    }else
    {
        NSString * key = _firstArr[section];
        
        return [[self.dic objectForKey:key] count];
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 1000)
    {
        return _firstArr.count;
    }else
    {
        return 1;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 500)
    {
        DingdianyiyuanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (allData.count>=1)
        {
            DataModel * dataModel = allData[indexPath.row];
            
            [cell.imgBut sd_setImageWithURL:[NSURL URLWithString:dataModel.img] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"city"]];
            
            cell.titLaber.text = dataModel.name.length > 1?dataModel.name:@"暂无公司";
            cell.addressLaber.text =  dataModel.addr.length>=1?dataModel.addr:@"暂无地址";
            
            if ([dataModel.dist floatValue]<1000)
            {
               
                cell.mapLaber.text = [NSString stringWithFormat:@"%ldM",(long)[dataModel.dist integerValue]];
                
            }else
            {
                cell.mapLaber.text = [NSString stringWithFormat:@"%.2lfKM",[dataModel.dist floatValue]/1000];
            }
            
            cell.mapLaber.textColor = Wqingse;
            NSString * tttel =dataModel.tel.length>5?dataModel.tel:@"暂无电话";
            [cell.telBut setTitle:tttel forState:UIControlStateNormal];
            

            cell.telBut.tag = 100 + indexPath.row;
            [cell.telBut addTarget:self action:@selector(telAction:) forControlEvents:(UIControlEventTouchUpInside)];
            
        }
        
        return cell;
    }else
    {
        NSString * key = _firstArr[indexPath.section];
        NSArray * arry = [self.dic objectForKey:key];
        DataModel * data = arry[indexPath.row];
        completeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"comcell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:data.logo] placeholderImage:[UIImage imageNamed:@"leixing"]];
        cell.titleLab.text = data.shortn?data.shortn:data.name;
        return cell;
        
    }
    
}
//电话点击事件

-(void)telAction:(UIButton *)btn
{
    [_searchBar resignFirstResponder];
    
    DataModel * data = allData[btn.tag - 100];
    
    tel = data.tel;
    if (data.tel.length >8)
    {
        //
        //        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你确定要拨打电话吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        //        [view show];
        [self callPhone:data.tel];
        
        
    }else
    {
        [WBYRequest showMessage:@"无法获取电话"];
        return;
    }
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 )
    {
        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",tel];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }
}
- (void)indexSelectionDidChange:(CMIndexBar *)indexBar index:(NSInteger)index title:(NSString *)title
{
    [gongsiTab scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, wScreenW, 30)];
    myView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0  blue:241/255.0  alpha:1.0];
    
    UILabel *myLab = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 100, 30)];
    myLab.backgroundColor = [UIColor clearColor];
    myLab.text = _firstArr[section];
    myLab.font = [UIFont systemFontOfSize:16];
    myLab.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0  blue:0/255.0  alpha:1.0];
    [myView addSubview:myLab];
    
    return myView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 1000)
    {
        return 30;
    }
    else
    {
        return 0;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 500)
    {
        DataModel * mod = allData[indexPath.row];
        AAyiyuanxiangqingViewController * wby = [AAyiyuanxiangqingViewController new];
        wby.myDataModel = mod ;
        [self.navigationController pushViewController:wby animated:YES ];
        
    }else
    {
        UIButton  * btn = [self.view viewWithTag:1314];
        btn.selected = NO;
        UIButton * bBtn = [self.view viewWithTag:3031];
        bBtn.selected = NO;
        NSString * key = _firstArr[indexPath.section];
        NSArray * arry = [self.dic objectForKey:key];
        
        DataModel * data = arry[indexPath.row];
        gongsiId = data.cid;
        
        [btn setTitle:data.shortn?data.shortn:data.name forState:UIControlStateNormal];
        
        [self requestleiBieDateDatalng:@"" latStr:@"" proStr:@"" cityStr:@"" countyStr:@"" gongsiId:data.cid?data.cid:@"" yiyuanjibie:@"" guanjianzi:@"" shuxing:@"" dingdian:@""];
        
        [gongsiView removeFromSuperview];
        
    }
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag==500)
    {
        DingdianyiyuanTableViewCell * acell = (DingdianyiyuanTableViewCell*)cell;
        
        acell.imgBut.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1);
        
        [UIView animateWithDuration:0.8 animations:^{
            
            
            acell.imgBut.layer.transform = CATransform3DMakeScale(1, 1, 1);
        }];
        
        
    }
    
    
}


-(void)requestleiBieDateDatalng:(NSString*)lng latStr:(NSString * )alatStr  proStr:(NSString *)proStr  cityStr:(NSString *)cityStr countyStr:(NSString *)countyStr gongsiId:(NSString *)comId  yiyuanjibie:(NSString *)jibie guanjianzi:(NSString *)keyword shuxing:(NSString* )shuxing dingdian:(NSString*)dingdian


{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)numindex] forKey:@"p"];
    [dic setObject:@"10" forKey:@"pagesize"];
    [dic setObject:keyword forKey:@"keyword"];
    [dic setObject:lng forKey:@"lng"];
    [dic setObject:alatStr forKey:@"lat"];
    [dic setObject:@"2000" forKey:@"distance"];
    [dic setObject:proStr forKey:@"prov"];
    [dic setObject:cityStr forKey:@"city"];
    [dic setObject:countyStr forKey:@"county"];
    [dic setObject:comId forKey:@"com_id"];
    [dic setObject:jibie forKey:@"level"];
    
    [dic setObject:shuxing forKey:@"autho"];
    [dic setObject:dingdian forKey:@"desi"];

    
    WS(weakSelf);
    [WBYRequest wbyPostRequestDataUrl:@"near_hos" addParameters:dic success:^(WBYReqModel *model)
     {
         if ([model.err isEqualToString:TURE])
         {
             [weakSelf.beijingDateView removeFromSuperview];
             
             if (numindex == 1)
             {
                 [allData removeAllObjects];
             }
             [allData addObjectsFromArray:model.data];
             
             if (allData.count==0)
             {
                 
                 [weakSelf wushujuSecond];
             }
             
         }
         
         [myTab reloadData];
         
     } failure:^(NSError *error) {
         
     } isRefresh:NO];
}


#pragma mark===请求公司
-(void)requestBaoXianGongSi
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setObject:@"" forKey:@"keyword"];
    
    [WBYRequest wbyPostRequestDataUrl:@"hos_com" addParameters:dic success:^(WBYReqModel *model)
     {
         if ([model.err isEqualToString:TURE])
         {
             [_firstArr removeAllObjects];
             
             [agongsiArray removeAllObjects];
             for (DataModel * data in model.data)
             {
                 [agongsiArray addObject:data];
             }
             NSArray * array = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
             for (NSString * str in array)
             {
                 NSMutableArray * modelAry = [@[] mutableCopy];
                 for (DataModel * data in agongsiArray)
                 {
                     if ([[data.name getFirstLetter] isEqualToString:str])
                     {
                         [modelAry addObject:data];
                     }
                 }
                 if (modelAry.count !=0)
                 {
                     NSDictionary * smallDic = @{str : modelAry};
                     [self.dic addEntriesFromDictionary:smallDic];
                     [_firstArr addObject:str];
                 }
             }
         }
         
         [gongsiTab reloadData];
     } failure:^(NSError *error) {
         
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
