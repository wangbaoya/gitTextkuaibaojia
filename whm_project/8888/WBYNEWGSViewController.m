//
//  WBYNEWGSViewController.m
//  whm_project
//
//  Created by apple on 17/3/6.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WBYNEWGSViewController.h"
#import "WbynengongsiTableViewCell.h"
#import "ZYPinYinSearch.h"


@interface WBYNEWGSViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,IFlyRecognizerViewDelegate>
{
    NSMutableArray * agongsiArray;
    NSMutableArray * _firstArr;
    UITableView * gongsiTab;
    NSMutableArray * searchData;
    NSMutableArray * allCityNames;
    BOOL isSearch;
}
@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;//带界面的识别对象
@property (nonatomic,strong) IFlyPcmRecorder *pcmRecorder;//录音器，用于音频流识别的数据传入

@property(nonatomic,strong)UISearchBar * searchBar;

@property (strong, nonatomic) NSDictionary *allDataSource;/**<排序后的整个数据源*/
@property (strong, nonatomic) NSArray *indexDataSource;/**<索引数据源*/
@property (nonatomic,strong)NSMutableDictionary * dic;

@end

@implementation WBYNEWGSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"公司名称";
    [self creatLeftTtem];

    allCityNames = [NSMutableArray new];

    searchData = [NSMutableArray array];
    agongsiArray =[NSMutableArray array];
    _firstArr = [NSMutableArray array];
    _dic = [NSMutableDictionary dictionary];
    isSearch = NO;
    
    [self requestBaoXianGongSi:@""];
    
    [self creatmyTab];
    
}

#pragma mark===请求公司
-(void)requestBaoXianGongSi:(NSString*)str
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setObject:str forKey:@"keyword"];
    [dic setObject:_type?_type:@"" forKey:@"type"];
    
    [WBYRequest wbyPostRequestDataUrl:@"org_com" addParameters:dic success:^(WBYReqModel *model)
     {
         if ([model.err isEqualToString:TURE])
         {
             [_firstArr removeAllObjects];
             [agongsiArray removeAllObjects];
             for (DataModel * data in model.data)
             {
                 [allCityNames addObject:data.name];
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
         
         
         if ([model.err isEqualToString:WUSHUJU])
         {
             [WBYRequest showMessage:model.info];
         }
         
           [gongsiTab reloadData];
     } failure:^(NSError *error) {
         
     } isRefresh:NO];
}

-(void)creatmyTab
{
    UIView * bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 45)];
    bgview.backgroundColor = RGBwithColor(245, 245, 245);
    
    
    [self.view addSubview:bgview];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10,5,wScreenW - 20, 40)];
    
    _searchBar.backgroundColor = wWhiteColor;
  [_searchBar changeLeftPlaceholder:@"请输入搜索内容"];
    
    _searchBar.delegate = self;
    [bgview addSubview:_searchBar];
    UIButton * myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    myBtn.frame = CGRectMake(wScreenW-30 - 20 - 4,2.5, 30, 30);
    myBtn.tag = 3333;

    [myBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e60c", 20,QIANLANSEcolor)] forState:UIControlStateNormal];
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
    [[[[_searchBar.subviews objectAtIndex:0] subviews] objectAtIndex:0] removeFromSuperview];
    [_searchBar setBackgroundColor:[UIColor whiteColor]];

    
    gongsiTab = [[UITableView alloc] initWithFrame:CGRectMake(0,45, wScreenW, wScreenH - 64-45) style:UITableViewStylePlain];
    gongsiTab.dataSource = self;
    gongsiTab.delegate =self;
    gongsiTab.rowHeight = HANGGAO;
    gongsiTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [gongsiTab registerClass:[WbynengongsiTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:gongsiTab];
    
    gongsiTab.tableFooterView = [UIView new];
    [gongsiTab setSeparatorInset:UIEdgeInsetsZero];
    [gongsiTab setLayoutMargins:UIEdgeInsetsZero];
}

-(void)onClickMyBtn
{
    [_searchBar resignFirstResponder];
    [self changeOnclick];
    
    
}

-(void)quxiao
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    UIButton * btn = [[[UIApplication sharedApplication].delegate window] viewWithTag:3333];
    
    if (_searchBar.text.length < 1)
    {
        btn.hidden = NO;
    }else
    {
        isSearch = YES;
        btn.hidden = YES;
    }
    
    [searchData removeAllObjects];
    NSArray * ary = [NSArray new];
    
    ary = [ZYPinYinSearch searchWithOriginalArray:agongsiArray andSearchText:searchText andSearchByPropertyName:@"shortn"];
    
    if (searchText.length == 0)
    {
        
        isSearch = NO;
    }else
    {
        [searchData addObjectsFromArray:ary];
        isSearch = YES;
    }
    [gongsiTab reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_searchBar resignFirstResponder];
}

-(void)deletext:(UIButton*)btn
{
    _searchBar.text = @"";
    btn.hidden =YES;
    
    UIButton * btn1 = [[[UIApplication sharedApplication].delegate window] viewWithTag:3333];
    btn1.hidden = NO;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (isSearch==YES)
    {
        return searchData.count;
    }else
    {
        return [[self.dic objectForKey:_firstArr[section]] count];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (isSearch==YES)
    {
        return 1;
    }else
    {
        return _firstArr.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WbynengongsiTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if (isSearch==YES)
    {
        DataModel * mod = searchData[indexPath.row];
        [cell.myimg sd_setImageWithURL:[NSURL URLWithString:mod.logo] placeholderImage:[UIImage imageNamed:@"city"]];
        cell.aLab.text = mod.shortn?mod.shortn:mod.name;
        
    }else
    {
        DataModel * model = [self.dic objectForKey:_firstArr[indexPath.section]][indexPath.row];
        [cell.myimg sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"city"]];

        cell.aLab.text = model.shortn?model.shortn:model.name;
    }
     return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isSearch==YES)
    {
        DataModel * mod = searchData[indexPath.row];
        self.myZCid(mod.cid,mod.shortn?mod.shortn:mod.name);
        
    }else
    {
        DataModel * model = [self.dic objectForKey:_firstArr[indexPath.section]][indexPath.row];
        self.myZCid(model.cid,model.shortn?model.shortn:model.name);

    }

    [self.navigationController popViewControllerAnimated:YES];
    
}



-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (!isSearch)
    {
        return [NSString stringWithFormat:@"   %@",_firstArr[section]];
        
    }else
    {
        return nil;
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
    
    
    [self requestBaoXianGongSi:_searchBar.text?_searchBar.text:@""];

    
    UIButton * btn = [[[UIApplication sharedApplication].delegate window] viewWithTag:3333];
    
    if (_searchBar.text.length>=1)
    {
        btn.hidden = YES;
    }
}


- (void)onError: (IFlySpeechError *) error
{
    NSLog(@"===%@",error);
    
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
