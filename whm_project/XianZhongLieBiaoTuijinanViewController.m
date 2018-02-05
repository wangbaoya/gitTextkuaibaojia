//
//  XianZhongLieBiaoTuijinanViewController.m
//  whm_project
//
//  Created by apple on 17/7/18.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "XianZhongLieBiaoTuijinanViewController.h"
#import "XianzhongliebiaoTableViewCell.h"


@interface XianZhongLieBiaoTuijinanViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,IFlyRecognizerViewDelegate,UISearchBarDelegate>
{
    UITableView * myTab;
    NSMutableArray * allArr;
    NSInteger numindex;
    UISearchBar * _searchBar;

}

@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;//带界面的识别对象
@property (nonatomic,strong) IFlyPcmRecorder *pcmRecorder;//录音器，用于音频流识别的数据传入

@end

@implementation XianZhongLieBiaoTuijinanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatLeftTtem];
    allArr = [NSMutableArray array];
    

    [self requestData:@""];
    
    [self creatupview];

    
}
-(void)creatupview
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
    
    UIButton * myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    myBtn.frame = CGRectMake(CGRectGetMaxX(_searchBar.frame) - 40 - 2,2.5, 30, 25);
    [myBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e60c", 20,QIANLANSEcolor)] forState:UIControlStateNormal];
    myBtn.tag = 12345;
    
    [myBtn addTarget:self action:@selector(onClickMyBtn) forControlEvents:UIControlEventTouchUpInside];
    [_searchBar addSubview:myBtn];
    
    UITextField *searchField=[_searchBar valueForKey:@"_searchField"];
    
//    [searchField addTarget:self action:@selector(bianhua:) forControlEvents:UIControlEventEditingChanged];
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
    
    
    [self creatTab];
}
#pragma mark===搜索

-(void)backButtonClick
{
    [_searchBar resignFirstResponder];
    if (_searchBar.text.length>=1)
    {        
        [self requestData:_searchBar.text];
    }else
    {
        [WBYRequest showMessage:@"请输入搜索内容"];
    }
    
}

-(void)onClickMyBtn
{
    [_searchBar resignFirstResponder];
    [self changeOnclick];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (_searchBar.text.length>=1)
    {
        [self requestData:_searchBar.text];
        
    }
    
    [_searchBar resignFirstResponder];
    
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
        [self requestData:_searchBar.text];
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








-(void)creatTab
{
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, wScreenW, wScreenH - 64) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    myTab.tag = 500;
    [myTab   setSeparatorColor:FENGEXIANcolor];
    myTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [myTab registerClass:[XianzhongliebiaoTableViewCell class] forCellReuseIdentifier:@"cell"];
    myTab.rowHeight = 110;
    
    
    myTab.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    myTab.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
    
    
    myTab.tableFooterView = [UIView new];
    [self.view addSubview:myTab];
    
    
}
#pragma mark===加载

-(void)headerRereshing
{
    numindex = 1 ;
    
    _searchBar.text = @"";
    [self requestData:@""];
    [myTab.mj_header endRefreshing];
    
    
}
//下拉
-(void)footerRefreshing
{
    
    numindex ++ ;
    _searchBar.text = @"";
    [self requestData:@""];
    [myTab.mj_footer endRefreshing];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return allArr.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XianzhongliebiaoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (allArr)
    {
        DataModel * data = allArr[indexPath.row];
        [cell.lImg sd_setImageWithURL:[NSURL URLWithString:data.logo]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.upLab.text = data.name?data.name:data.short_name;
        
        cell.midL.text = [NSString stringWithFormat:@"投保年龄:%@",data.limit_age_name.length > 1?data.limit_age_name:@"暂无"];  //limit_age_name
        cell.midR.text = [NSString stringWithFormat:@"产品类型:%@",data.pro_type_code_name.length >1 ?data.pro_type_code_name:@"暂无"];
//        NSArray * arr = [data.sign componentsSeparatedByString:@","];
        
//        if (arr.count >= 1)
//        {
//            cell.downL.hidden = NO;
//            cell.downL.text = [arr firstObject];
//        }else
//        {
//            cell.downL.hidden = YES;
//        }
        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==myTab)
    {
        XianzhongliebiaoTableViewCell * acell = (XianzhongliebiaoTableViewCell *)cell;
        acell.lImg.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1);
        
        [UIView animateWithDuration:0.8 animations:^{
            
            acell.lImg.layer.transform = CATransform3DMakeScale(1, 1, 1);
        }];
        
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (allArr.count>=1)
    {
        
        DataModel * data = allArr[indexPath.row];
//        _ablock(data);
        [self tianxianzhong:data.id?data.id:@""];
        
    }
    
}

-(void)tianxianzhong:(NSString*)xiangzhid
{
    WS(weakSelf);
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:xiangzhid forKey:@"pids"];
  
    [WBYRequest wbyLoginPostRequestDataUrl:@"save_rec" addParameters:dic success:^(WBYReqModel *model)
    {
        if ([model.err isEqualToString:TURE])
        {
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
   
        }else
        {
            
            [WBYRequest showMessage:model.info];
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
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

//-(void)bianhua:(UITextField*)tf
//{
//    UIButton * btn = [[[UIApplication sharedApplication].delegate window] viewWithTag:12345];
//    
//    
//    if (tf.text.length>0)
//    {
//        btn.hidden = YES;
//    }else
//    {
//        btn.hidden = NO;
//    }
// 
//    
//}

-(void)requestData:(NSString*)key
{
    WS(weakSelf);
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:key forKey:@"keyword"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)numindex] forKey:@"p"];
    [dic setObject:@"15" forKey:@"pagesize"];
    [dic setObject:UID?UID:@"" forKey:@"agent_uid"];

    
    [WBYRequest wbyLoginPostRequestDataUrl:@"pro_list" addParameters:dic success:^(WBYReqModel *model)
     {
         if ([model.err isEqualToString:TURE])
         {
             if (numindex == 1)
             {
                 [allArr removeAllObjects];
             }
             
             [allArr addObjectsFromArray:model.data];
             
             if (allArr.count==0)
             {
                 [WBYRequest showMessage:@"没有数据"];
                 
                 [weakSelf wushuju];
             }
             
         }else{
             
             [WBYRequest showMessage:model.info];
         }
         
         [myTab reloadData];
 
         
         
    } failure:^(NSError *error) {
        
        
    }];
    
//    [WBYRequest wbyPostRequestDataUrl:@"pro_list" addParameters:dic success:^(WBYReqModel *model)
//     {
//         if ([model.err isEqualToString:TURE])
//         {
//             if (numindex == 1)
//             {
//                 [allArr removeAllObjects];
//             }
//             
//             [allArr addObjectsFromArray:model.data];
//             
//             if (allArr.count==0)
//             {
//                 [WBYRequest showMessage:@"没有数据"];
//                 
//                 [weakSelf wushuju];
//             }
//             
//         }else{
//             
//             [WBYRequest showMessage:model.info];
//         }
//         
//         [myTab reloadData];
//     } failure:^(NSError *error) {
//         
//     } isRefresh:NO];
//    
    
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
