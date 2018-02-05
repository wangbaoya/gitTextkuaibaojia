//
//  RemenzixunViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RemenzixunViewController.h"
#import "WangShouyeTableViewCell.h"
#import "XinwenxiangqingViewController.h"

@interface RemenzixunViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,IFlyRecognizerViewDelegate>
{
    UITableView * myTab;
    UISearchBar * _searchBar;
    
    NSMutableArray * allData;
    NSInteger numindex;
}
@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;//带界面的识别对象
@property (nonatomic,strong) IFlyPcmRecorder *pcmRecorder;//录音器，用于音频流识别的数据传入
@end

@implementation RemenzixunViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    numindex = 1;
    [self request];
    allData = [NSMutableArray array];

    [self creatview];
    //[self sousuokuang];
    self.title = @"热门资讯";
    
    [self creatLeftTtem];
}
-(void)request
{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setObject:[NSString stringWithFormat:@"%ld",numindex] forKey:@"p"];
    [dic setObject:@"15" forKey:@"pagesize"];
    
    [WBYRequest wbyPostRequestDataUrl:@"news" addParameters:dic success:^(WBYReqModel *model)
     {
         if ([model.err isEqualToString:TURE])
         {
             if (numindex == 1)
             {
                 [allData removeAllObjects];
             }
             [allData addObjectsFromArray:model.data];
         }
         
         [myTab reloadData];
         
     } failure:^(NSError *error) {
         
     } isRefresh:NO];
}
#pragma mark===加载

-(void)headerRereshing
{
    numindex = 1 ;
    
    [self request];
    [myTab.mj_header endRefreshing];
    
}
//下拉
-(void)footerRefreshing
{
    
    numindex ++ ;
    [self request];
    [myTab.mj_footer endRefreshing];
    
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
    [_searchBar changeLeftPlaceholder:@"请输入搜索内容"];
    [titleView addSubview:_searchBar];
    
    UIButton * myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    myBtn.frame = CGRectMake(CGRectGetMaxX(_searchBar.frame) - 40 - 2,2.5, 30, 25);
    [myBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e60c", 20,QIANLANSEcolor)] forState:UIControlStateNormal];
    myBtn.tag = 12345;
    [myBtn addTarget:self action:@selector(onClickMyBtn) forControlEvents:UIControlEventTouchUpInside];
    [_searchBar addSubview:myBtn];
    
    UILabel * aLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_searchBar.frame) - 40 - 2-6, 5, 1, 20)];
    aLab.backgroundColor = FENGEXIANcolor;
    
    [_searchBar addSubview:aLab];
    
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



-(void)backButtonClick
{
    
    
}

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
    
    _searchBar.text = [NSString stringWithFormat:@"%@%@",_searchBar.text,result];
    
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


-(void)creatview
{
    UIView * midView = [[UIView alloc] initWithFrame:CGRectMake(0,0, wScreenW, 7.5+35)];
    midView.backgroundColor = JIANGEcolor;
 
    UIView * downView = [[UIView alloc] initWithFrame:CGRectMake(0,7.5, wScreenW, 35)];
    downView.backgroundColor = wWhiteColor;
    [midView addSubview:downView];

    UIButton * remenLab = [UIButton buttonWithType:UIButtonTypeCustom];
    remenLab.frame = CGRectMake(0, 0, 90, 35);
    
    [remenLab setTitle:@"热门资讯" forState:UIControlStateNormal];
    remenLab.titleLabel.font = Font(16);
    [remenLab setTitleColor:RGBwithColor(64, 64, 64) forState:UIControlStateNormal];
   
    
    //    remenLab.font = Font(16);
    //    remenLab.text = @"热门资讯";
    //    remenLab.textAlignment = 1;
    //    remenLab.textColor = RGBwithColor(64, 64, 64);
    [downView addSubview:remenLab];
    //
    
    remenLab.center = CGPointMake(self.view.center.x,35/2);
    
    UILabel * llab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW/2-45-70, 35/2, 70, 1)];
    llab.backgroundColor = FENGEXIANcolor;
    [downView addSubview:llab];
    
    UILabel * rlab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW/2+45, 35/2, 70, 1)];
    rlab.backgroundColor = FENGEXIANcolor;
    [downView addSubview:rlab];
    

    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, wScreenW, wScreenH -64) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    myTab.separatorColor = FENGEXIANcolor;
    myTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [myTab registerClass:[WangShouyeTableViewCell class] forCellReuseIdentifier:@"cell"];
    myTab.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    myTab.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];


    myTab.tableHeaderView =  midView;
    [myTab setSeparatorInset:UIEdgeInsetsZero];
    [myTab setLayoutMargins:UIEdgeInsetsZero];
    
    [self.view addSubview:myTab];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return allData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WangShouyeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (allData.count>=1)
    {
        DataModel * dataMod = allData[indexPath.row];
        
        [cell.myImg sd_setImageWithURL:[NSURL URLWithString:dataMod.thumbnail] placeholderImage:[UIImage imageNamed:@"city"]];
        cell.myTit.text = dataMod.title;
        
        cell.readNum.text = [NSString stringWithFormat:@"%@ 阅读",dataMod.mycount];
        
        cell.styLaber.text = [NSString stringWithFormat:@"类型:%@",dataMod.cate_name];
        cell.timeLaber.text = [WBYRequest timeStr:dataMod.created_time];
     }
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    WangShouyeTableViewCell * celqq = (WangShouyeTableViewCell *)cell;
    celqq.myImg.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1);
    [UIView animateWithDuration:0.8 animations:^{
        celqq.myImg.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (allData.count>=1)
    {
        DataModel * dataMod = allData[indexPath.row];
 
        XinwenxiangqingViewController * xiangqing = [XinwenxiangqingViewController new];
        xiangqing.myId = dataMod.id;
        
        [self.navigationController pushViewController:xiangqing animated:YES];
    }
    
    NSLog(@"===%ld",(long)indexPath.row);
    
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
