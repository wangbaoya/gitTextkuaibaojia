//
//  LISHIViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "LISHIViewController.h"
#import "SousuoguanjianciTableViewCell.h"
#import "XianZhongliebiaoViewController.h"
#import "PlayVcEverLike.h"

@interface LISHIViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,IFlyRecognizerViewDelegate>
{
    UISearchBar * _searchBar;
    UIImageView * xiaoImg;
    UILabel * xiaolab;
    NSMutableArray *lishiArr;
    UITableView * myTab;

}

@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;//带界面的识别对象
@property (nonatomic,strong) IFlyPcmRecorder *pcmRecorder;//录音器，用于音频流识别的数据传入



@end

@implementation LISHIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    lishiArr = [NSMutableArray array];
    [self creatupview];
}



-(void)creatupview
{
    CGFloat ww = (wScreenW-100)/3;
    
    UIView * myview = [[UIView alloc] initWithFrame:CGRectMake(0, 20, wScreenW, 30)];
    
    [self.view addSubview:myview];
    
    NSArray * strArr = @[@"找险",@"热搜",@"分类"];
    for (NSInteger i=0; i<strArr.count; i++)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(50+ww * (i%3),0, ww,30);
        
        btn.tag = 5858 + i;
        [btn addTarget:self action:@selector(jinru:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:strArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:wBlackColor forState:UIControlStateNormal];
        [btn setTitleColor:QIANLANSEcolor forState:UIControlStateSelected];
        btn.titleLabel.font = Font(16);
        if (i==0)
        {
            btn.selected = YES;
        }
        [myview addSubview:btn];
    }
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(myview.frame), wScreenW, 35)];
    UIColor *color =  self.navigationController.navigationBar.barTintColor;
    [titleView setBackgroundColor:color];
    [self.view addSubview:titleView];
    
    
    UIButton * mybutton =[UIButton buttonWithType:UIButtonTypeCustom];
    mybutton.frame = CGRectMake(5,5+2.5, 25, 25);
    [mybutton setBackgroundImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e60e",25, wBlackColor)] forState:UIControlStateNormal];
    
    [mybutton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:mybutton];
    
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.delegate = self;
    _searchBar.frame = CGRectMake(35, 5, wScreenW-50-35, 30);
    _searchBar.backgroundColor = wWhiteColor;
    [_searchBar.layer setBorderWidth:0.3];
    [_searchBar.layer setBorderColor:QIANLANSEcolor.CGColor];  //设置边框为白色
    
       [titleView addSubview:_searchBar];
    _searchBar.barTintColor = wWhiteColor;
    
    
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(wScreenW-38-10,5, 38+10, 30);
    [button setTitle:@"搜索" forState:UIControlStateNormal];
    button.titleLabel.font = Font(16);
    [button setTitleColor:SHENLANSEcolor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sousuoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:button];
    
    
    
    UIButton * myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    myBtn.frame = CGRectMake(wScreenW-50-30,5, 30, 30);
    
    [myBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e60c", 20,QIANLANSEcolor)] forState:UIControlStateNormal];
    myBtn.tag = 12345;
    [myBtn addTarget:self action:@selector(onClickMyBtn) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:myBtn];
    
    
    
    UILabel * aLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(myBtn.frame) - 6 , 5+5, 1, 20)];
    aLab.backgroundColor = FENGEXIANcolor;
    [titleView addSubview:aLab];
    
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
    
    xiaoImg = [[UIImageView alloc] initWithFrame:CGRectMake(50+ww/2-6.5,0, 13, 5)];
    xiaoImg.image = [UIImage imageNamed:@"sanjiao"];
    [titleView addSubview:xiaoImg];
    
    xiaolab = [[UILabel alloc] initWithFrame:CGRectMake(50+ww/2-6.5, 5, 13, 3)];
    xiaolab.backgroundColor = wWhiteColor;
    
    [titleView addSubview: xiaolab];
    
    [self creatTab];
}

-(void)creatTab
{
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0,85,wScreenW, wScreenH - 85 ) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    myTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    myTab.rowHeight = HANGGAO;
    
    [myTab registerClass:[SousuoguanjianciTableViewCell  class] forCellReuseIdentifier:@"cell"];
  myTab.tableFooterView = [[UIView alloc] init];
    
    [myTab setSeparatorInset:UIEdgeInsetsZero];
    [myTab setLayoutMargins:UIEdgeInsetsZero];
    
    [self.view addSubview:myTab];

    

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return lishiArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SousuoguanjianciTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [_searchBar resignFirstResponder];
    
    
    if (lishiArr.count>=1)
    {
        
//        [_searchBar resignFirstResponder];
        
        DataModel * mod = lishiArr[indexPath.row];
        
        cell.lImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e609", 16, wBlackColor)];
        cell.myLab.text = mod.name;
        cell.rLab.text = mod.type_name;
        
        
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (lishiArr.count>=1)
    {
        DataModel * mod = lishiArr[indexPath.row];

        XianZhongliebiaoViewController * xianzhong = [XianZhongliebiaoViewController new];
        xianzhong.mong_id = mod.mongo_id;
        xianzhong.xianzhong = mod.name;
        
         [PlayVcEverLike writeToFileDocumentPathByVid:mod.name?mod.name:@""];
        [self.navigationController pushViewController:xianzhong animated:YES];
    }
    
}




-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark===点击事件
-(void)jinru:(UIButton *)btn
{
    btn.selected = !btn.selected;
    for (NSInteger i =0; i<3; i++)
    {
        UIButton * aBtn = [self.view viewWithTag:5858+i];
        aBtn.selected = NO;
    }
    btn.selected = YES;
    xiaoImg.center = CGPointMake(btn.center.x, btn.center.y+2.5-15);
    xiaolab.center = CGPointMake(btn.center.x, btn.center.y+2.5-11);
   
}
#pragma mark==搜索
-(void)sousuoButtonClick
{
    [_searchBar resignFirstResponder];
    if (_searchBar.text.length>=1)
    {
       

//        [self searchByKeyword:_searchBar.text?_searchBar.text:@""];
//        
//        XianZhongliebiaoViewController * xianzhong = [XianZhongliebiaoViewController new];
//        
//        xianzhong.keywored = _searchBar.text;
//        xianzhong.xianzhong = _searchBar.text;
//        [self.navigationController pushViewController:xianzhong animated:YES];
        
    }else
    {
        [WBYRequest showMessage:@"请输入搜索内容"];
    }
    
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    UIButton * btn = [self.view viewWithTag:12345];
    if (searchText.length>0)
    {
        btn.hidden = YES;
    }else
    {
        btn.hidden = NO;
    }
    
    
    
    if (_searchBar.text.length>=1)
    {
        [self requestData:_searchBar.text];
    }
    
    
    
}




-(void)requestData:(NSString *)keyword
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setObject:keyword forKey:@"keyword"];
    
    [WBYRequest wbyPostRequestDataUrl:@"search_keys" addParameters:dic success:^(WBYReqModel *model)
     {
         [lishiArr removeAllObjects];
         
         if ([model.err isEqualToString:TURE])
         {
             [lishiArr addObjectsFromArray:model.data];
             
         }else
         {
             [WBYRequest showMessage:model.info];
         }
         
         [myTab reloadData];
     } failure:^(NSError *error) {
         
     } isRefresh:NO];
    
}

#pragma mark===语音

-(void)onClickMyBtn
{
    
    [_searchBar resignFirstResponder];
    [self changeOnclick];
    
  
    
}

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
    
    UIButton * btn = [self.view viewWithTag:12345];

    _searchBar.text = [NSString stringWithFormat:@"%@%@",_searchBar.text,result];
    
    if (_searchBar.text.length > 1)
    {
        btn.hidden = YES;

        [self requestData:_searchBar.text];
        
        [_searchBar resignFirstResponder];

    }
    
    
    NSLog(@"====%@",result);
}


- (void)onError: (IFlySpeechError *) error
{
    NSLog(@"===%@",error);
    
}







- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
     UIButton * btn = [self.view viewWithTag:12345];
    
    if (_lishiStr.length>1)
    {
        _searchBar.text = _lishiStr;
        btn.hidden = YES;

        [self requestData:_searchBar.text];
        
    }else
    {
        [_searchBar changeLeftPlaceholder:@" 请输入搜索内容"];
        [_searchBar becomeFirstResponder];
    }

   
   
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
