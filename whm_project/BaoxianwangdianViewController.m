//
//  BaoxianwangdianViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BaoxianwangdianViewController.h"
#import "BaoXianWangdianTableViewCell.h"
#import "PickView.h"
#import "ZMFloatButton.h"
#import "AAjigouxiangqingViewController.h"
#import "AAwangdianViewController.h"


@interface BaoxianwangdianViewController ()<UISearchBarDelegate,IFlyRecognizerViewDelegate,UITableViewDelegate,UITableViewDataSource,ZMFloatButtonDelegate>
{
    UISearchBar * _searchBar;
    UITableView * myTab;
    UIView *_chooseCityView;
    NSArray * leixingArr;
    NSArray * jigouArr;
    UIView * downView;

    NSString * dengjiStr;
    NSString * xingzhiStr;
    
    NSMutableArray * allData;
    NSInteger numindex;

    NSString * jingdustr;
    NSString * weiduStr;
    NSArray * gonsileixing;
    
}

@property (nonatomic, strong) PickView * cityPickerView;

@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;//带界面的识别对象
@property (nonatomic,strong) IFlyPcmRecorder *pcmRecorder;//录音器，用于音频流识别的数据传入

@end

@implementation BaoxianwangdianViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    allData = [NSMutableArray array];
    
    numindex = 1;
    
    [self creatLeftTtem];
    [self jiafengexian];
    [self sousuokuang];
    [self creatUpview];
    [self huadongbutton];
    
    dengjiStr = @"";
    xingzhiStr = @"";
    
    gonsileixing = @[@"",@"1",@"2",@"9",@"10",@"11"];
    jingdustr = LNGONE;
    weiduStr = LATTWO;
    
    if (jingdustr.length>1&&weiduStr.length>1)
    {
        [self requestleiBieDateDatalng:jingdustr latStr:weiduStr proStr:@"" cityStr:@"" countyStr:@"" jigouleixingId:@"" gslx:@"" guanjianzi:@""];
    }else
    {
        [WBYRequest showMessage:@"无法获取当前位置"];
    }
    
}

-(void)huadongbutton
{
    ZMFloatButton * floatBtn = [[ZMFloatButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60-15,wScreenH-64-60-20, 60, 60)];
    floatBtn.delegate = self;
    floatBtn.bannerIV.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e624", 60, SHENLANSEcolor)];
    [self.view addSubview:floatBtn];
    [self.view bringSubviewToFront:floatBtn];
 }
#pragma mark -ZMFloatButtonDelegate
- (void)floatTapAction:(ZMFloatButton *)sender
{
//点击执行事件
    AAwangdianViewController * wangdian = [AAwangdianViewController new];
    
    [self.navigationController pushViewController:wangdian animated:YES];
    
}



-(void)creatUpview
{
    UIView * upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 35)];
    [self.view addSubview:upView];
    
    NSArray * litArr = @[DIQU,@"筛选"];
    for (NSInteger i = 0; i<litArr.count; i++)
    {
        UIButton * quxiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        quxiaoBtn.frame = CGRectMake(i * wScreenW/2,0, wScreenW/2, 35);
        quxiaoBtn.tag = 1313 + i;
        [quxiaoBtn setTitle:litArr[i] forState:UIControlStateNormal];
        [quxiaoBtn setTitleColor:wBlackColor forState:UIControlStateNormal];
        quxiaoBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [quxiaoBtn addTarget:self action:@selector(dianji:) forControlEvents:UIControlEventTouchUpInside];
        [upView addSubview:quxiaoBtn];
        
        UIButton * xiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        xiaoBtn.frame = CGRectMake(wScreenW/2 - 26, 10, 15, 15);
        xiaoBtn.tag = 3030 + i;
        
        
        [xiaoBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e617", 20, wBlackColor)] forState:UIControlStateNormal];
        
        [xiaoBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e616", 20, wBlackColor)] forState:UIControlStateSelected];
        
        [quxiaoBtn addSubview:xiaoBtn];
        
    }
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW/2, 0,0.8, 35)];
    lab.backgroundColor = FENGEXIANcolor;
    [upView addSubview:lab];
    UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 34,wScreenW, 0.8)];
    lab1.backgroundColor = FENGEXIANcolor;
    [upView addSubview:lab1];
    
    _cityPickerView = [[PickView alloc] init];
    _cityPickerView.backgroundColor= wWhiteColor;

    leixingArr = @[@"不限",@"人身险",@"财产险",@"代理公司",@"经纪公司",@"公估公司"];
    jigouArr = @[@"不限",@"总公司",@"分公司",@"支公司",@"营业部"];
    
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0,35, wScreenW, wScreenH - 64 - 35) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    
    myTab.tag = 500;
    myTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [myTab registerClass:[BaoXianWangdianTableViewCell class] forCellReuseIdentifier:@"cell"];
    myTab.rowHeight = 100;
    
    myTab.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    myTab.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
    
    [self.view addSubview:myTab];
    
}
-(void)headerRereshing
{
    numindex = 1 ;
    
    [self requestleiBieDateDatalng:jingdustr latStr:weiduStr proStr:@"" cityStr:@"" countyStr:@"" jigouleixingId:@"" gslx:@"" guanjianzi:@""];
    [myTab.mj_header endRefreshing];
    
}
//下拉
-(void)footerRefreshing
{
    numindex ++ ;
    [self requestleiBieDateDatalng:jingdustr latStr:weiduStr proStr:@"" cityStr:@"" countyStr:_cityPickerView.idarea.length>1?_cityPickerView.idarea:@"" jigouleixingId:xingzhiStr?xingzhiStr:@"" gslx:dengjiStr?dengjiStr:@"" guanjianzi:_searchBar.text?_searchBar.text:@""];
    [myTab.mj_footer endRefreshing];
    
}

-(void)creatshaixuan
{
    downView = [[UIView alloc] initWithFrame:CGRectMake(0,35, wScreenW, wScreenH-64-35)];
    //    downView.backgroundColor = [UIColor colorWithRed:245.f/255.f green:247.f/255.f blue:249.f/255.f alpha:1];
    downView.backgroundColor = wWhiteColor;

    [self.view addSubview:downView];

    
    UILabel * upLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, wScreenW-20,30)];
    upLab.text = @"公司类型";
    upLab.font = [UIFont systemFontOfSize:14.0f];
    [downView addSubview:upLab];
    CGFloat ww = (wScreenW - 5*6)/4;
    
    for (NSInteger i = 0; i< leixingArr.count; i++)
    {
        NSInteger aa = i%4;
        NSInteger bb = i/4;
        UIButton * quxiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        quxiaoBtn.frame = CGRectMake(6 + (ww + 6)*aa,30 + 5 + (16 + 30)*bb, ww, 30);
        quxiaoBtn.tag = 5858 + i;
        [quxiaoBtn setTitle:leixingArr[i] forState:UIControlStateNormal];
        [quxiaoBtn setTitleColor:wGrayColor2 forState:UIControlStateNormal];
        [quxiaoBtn setTitleColor:wWhiteColor forState:UIControlStateSelected];
        
        if (i == 0)
        {
            quxiaoBtn.selected = YES;
            quxiaoBtn.backgroundColor = SHENLANSEcolor;
        }
        quxiaoBtn.layer.masksToBounds = YES;
        quxiaoBtn.layer.borderColor = wGrayColor.CGColor;
        quxiaoBtn.layer.borderWidth = 0.6;
        quxiaoBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [quxiaoBtn addTarget:self action:@selector(dengji:) forControlEvents:UIControlEventTouchUpInside];
        [downView addSubview:quxiaoBtn];
        
    }

    UILabel * midLab = [[UILabel alloc] initWithFrame:CGRectMake(10,30+30+46+10, wScreenW-20, 30)];
    midLab.text = @"机构类别";
    midLab.font = [UIFont systemFontOfSize:14.0f];
    [downView addSubview:midLab];
    
    for (NSInteger i = 0; i< jigouArr.count; i++)
    {
        NSInteger aa = i%4;
        NSInteger bb = i/4;

        UIButton * quxiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        quxiaoBtn.frame = CGRectMake(6 + (ww + 6)*aa,CGRectGetMaxY(midLab.frame)+(16 + 30)*bb, ww, 30);
        quxiaoBtn.tag = 6868 + i;
        [quxiaoBtn setTitle:jigouArr[i] forState:UIControlStateNormal];
        [quxiaoBtn setTitleColor:wGrayColor2 forState:UIControlStateNormal];
        [quxiaoBtn setTitleColor:wWhiteColor forState:UIControlStateSelected];
        if (i == 0)
        {
            quxiaoBtn.selected = YES;
            quxiaoBtn.backgroundColor = SHENLANSEcolor;
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
    downBtn.frame = CGRectMake(40,CGRectGetMaxY(midLab.frame)+100, btnww,30);
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
    rrdownBtn.frame = CGRectMake(CGRectGetMaxX(downBtn.frame)+20,CGRectGetMaxY(midLab.frame)+100, btnww,30);
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
    
    UIView* botView = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(img.frame), wScreenW,wScreenH-64)];
    botView.backgroundColor = wGrayColor;
    [downView addSubview:botView];
  
 }

-(void)dengji:(UIButton*)btn
{
    
    if (btn.tag>=5858 &&btn.tag<=5858+leixingArr.count)
    {
        for (NSInteger i=0; i<leixingArr.count; i++)
        {
            UIButton * btn1 =[downView viewWithTag:5858+i];
            btn1.selected = NO;
            btn1.backgroundColor = wWhiteColor;
        }
        btn.selected = YES;
        btn.backgroundColor = SHENLANSEcolor;
        dengjiStr =gonsileixing[btn.tag-5858];
        
        
    }
 
    if (btn.tag>=6868 &&btn.tag<=6868+jigouArr.count)
    {
        for (NSInteger i=0; i<jigouArr.count; i++)
        {
            UIButton * btn1 =[downView viewWithTag:6868+i];
            btn1.selected = NO;
            btn1.backgroundColor = wWhiteColor;
        }
        btn.selected = YES;
        btn.backgroundColor = SHENLANSEcolor;
        
        xingzhiStr = jigouArr[btn.tag - 6868];
        
    }
    
}
-(void)queOrQuxiao:(UIButton*)btn
{
    [downView removeFromSuperview];
    
    [_searchBar resignFirstResponder];
    UIButton * abtn = [self.view viewWithTag:3030+1];
    abtn.selected = NO;
    
    if (btn.tag==9999)
    {
        //取消
        
    }else
    {

        [self requestleiBieDateDatalng:@"" latStr:@"" proStr:@"" cityStr:@"" countyStr:@"" jigouleixingId:xingzhiStr?xingzhiStr:@"" gslx:dengjiStr?dengjiStr:@"" guanjianzi:@""];
}
}

#pragma markk===代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return allData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaoXianWangdianTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (allData.count>=1)
    {
        
        [_cityPickerView hiddenPickerView];
        
        DataModel * dataModel = allData[indexPath.row];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.imgBut sd_setImageWithURL:[NSURL URLWithString:dataModel.logo] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"city"]];
        cell.titLaber.text =  dataModel.name.length >=1?dataModel.name:@"暂无公司";
        cell.titLaber.textColor = wBlackColor;
        cell.addressLaber.text = dataModel.addr.length>=1?dataModel.addr:@"暂无地址";
        
        cell.addressLaber.textColor = HUITUColor;
        
        if ([dataModel.dist floatValue]<1000)
        {
            cell.mapLaber.text = [NSString stringWithFormat:@"%ldM",[dataModel.dist integerValue]];
        }else
        {
            cell.mapLaber.text = [NSString stringWithFormat:@"%.2lfKM",[dataModel.dist floatValue]/1000];
        }
        
        cell.mapLaber.textColor = Wqingse;
        
        [cell.telBut setTitle:dataModel.tel?dataModel.tel:@"暂无电话" forState:UIControlStateNormal];
        
        [cell.telBut setTitleColor:DianhuaColor forState:UIControlStateNormal];
        
        cell.telBut.tag = 100 +indexPath.row;
        cell.telBut.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        
        [cell.telBut addTarget:self action:@selector(telAction:) forControlEvents:(UIControlEventTouchUpInside)];
  
    }
    
          return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (allData.count>=1)
    {
        DataModel * data = allData[indexPath.row];
        AAjigouxiangqingViewController * jigou = [AAjigouxiangqingViewController new];
        
        jigou.myDataModel = data;
        [self.navigationController pushViewController:jigou animated:YES];
    }
    
}

-(void)telAction:(UIButton*)btn
{
    if (allData.count>=1)
    {
        DataModel * data = allData[btn.tag - 100];
        if (data.tel.length > 7)
        {
            [self callPhone:data.tel];
            
        }else
        {
            [WBYRequest showMessage:@"无法获取电话"];
            return;
        }
    }

  }


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BaoXianWangdianTableViewCell * celqq = (BaoXianWangdianTableViewCell *)cell;
    
    celqq.imgBut.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1);
    
    [UIView animateWithDuration:0.8 animations:^{
        
        celqq.imgBut.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}

-(void)dianji:(UIButton*)btn
{
    [_searchBar resignFirstResponder];
    
    btn.selected = !btn.selected;
    for (NSInteger i =0; i<2; i++)
    {
        UIButton * litBtn = [self.view viewWithTag:3030 + i];
        litBtn.selected = NO;
        
        if (btn.tag-1313==litBtn.tag-3030)
        {
            litBtn.selected = btn.selected;
        }
    }
    
    if (btn.tag==1313)
    {
        [downView removeFromSuperview];

        if (btn.selected==YES)
      {
        [self creatpickvie];
        
      }else
       {
        
        [_cityPickerView hiddenPickerView];
           
       }
      }else
      {
          [_cityPickerView hiddenPickerView];
          
          if (btn.selected==YES)
          {
              [self creatshaixuan];
  
          }else
          {
              [downView removeFromSuperview];
          }
        }
 }



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

#pragma mark===地区选择
- (void)pickerviewbuttonclick:(UIButton *)sender
{
    UIButton * aBtn = [self.view viewWithTag:1313];
    for (NSInteger i =0; i<2; i++)
    {
        UIButton * litBtn = [self.view viewWithTag:3030 + i];
        litBtn.selected = NO;
    }
    if ([sender.titleLabel.text isEqualToString:@"确定"])
    {
        aBtn.titleLabel.text = [NSString stringWithFormat:@"%@",_cityPickerView.qu];
        
        [self requestleiBieDateDatalng:@"" latStr:@"" proStr:_cityPickerView.idprovence.length>1?_cityPickerView.idprovence:@"" cityStr:_cityPickerView.idcity.length>1?_cityPickerView.idcity:@"" countyStr:_cityPickerView.idarea.length>1?_cityPickerView.idarea:@"" jigouleixingId:@"" gslx:@"" guanjianzi:@""];
    }
    
    [_cityPickerView hiddenPickerView];
}

-(void)sousuokuang
{
   
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
    
    [[[[_searchBar.subviews objectAtIndex:0] subviews] objectAtIndex:0] removeFromSuperview];
    
    [_searchBar setBackgroundColor:[UIColor clearColor]];
    
    
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
       [self requestleiBieDateDatalng:@"" latStr:@"" proStr:@"" cityStr:@"" countyStr:@"" jigouleixingId:@"" gslx:@"" guanjianzi:_searchBar.text?_searchBar.text:@""];
    }else
    {
        [WBYRequest showMessage:@"请输入搜索内容"];
    }
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_searchBar resignFirstResponder];

    if (_searchBar.text.length>=1)
    {
        [self requestleiBieDateDatalng:@"" latStr:@"" proStr:@"" cityStr:@"" countyStr:@"" jigouleixingId:@"" gslx:@"" guanjianzi:_searchBar.text?_searchBar.text:@""];
    }else
    {
        [WBYRequest showMessage:@"请输入搜索内容"];
    }
    
}

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
        [self requestleiBieDateDatalng:@"" latStr:@"" proStr:@"" cityStr:@"" countyStr:@"" jigouleixingId:@"" gslx:@"" guanjianzi:_searchBar.text?_searchBar.text:@""];
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

#pragma mark---请求类
-(void)requestleiBieDateDatalng:(NSString*)lng   latStr:(NSString * )alatStr  proStr:(NSString *)proStr  cityStr:(NSString *)cityStr countyStr:(NSString *)countyStr jigouleixingId:(NSString *)comId  gslx:(NSString *)leixing
guanjianzi:(NSString *)keyword

{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSString stringWithFormat:@"%ld",numindex] forKey:@"p"];
    [dic setObject:@"10" forKey:@"pagesize"];
    
    [dic setObject:lng forKey:@"lng"];
    [dic setObject:alatStr forKey:@"lat"];
    [dic setObject:@"2000" forKey:@"distance"];
    [dic setObject:leixing forKey:@"type"];
    [dic setObject:comId forKey:@"cate"];
    [dic setObject:keyword forKey:@"keyword"];

    [dic setObject:proStr forKey:@"prov"];
    [dic setObject:cityStr forKey:@"city"];
    [dic setObject:countyStr forKey:@"county"];
    
    WS(weakSelf);
    [WBYRequest wbyPostRequestDataUrl:@"near_org" addParameters:dic success:^(WBYReqModel *model)
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
