//
//  TianjiaxinxianzhongViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TianjiaxinxianzhongViewController.h"
#import "TianjiaxianzhongTableViewCell.h"
#import "TijiancanshuViewController.h"

@interface TianjiaxinxianzhongViewController ()<IFlyRecognizerViewDelegate,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UISearchBar * _searchBar;
    NSMutableArray * upArray;
    NSMutableArray * downArray;

}

@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;//带界面的识别对象
@property (nonatomic,strong) IFlyPcmRecorder *pcmRecorder;//录音器，用于音频流识别的数据传入
@property(nonatomic,strong)UITableView * tableV;

@end

@implementation TianjiaxinxianzhongViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    upArray = [NSMutableArray array];
    downArray = [NSMutableArray array];
    [self creatLeftTtem];
    [self requestData:@""];
    [self sousuokuang];
}

-(void)creatTab
{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0,0, wScreenW, wScreenH - 64-45) style:UITableViewStylePlain];
    self.tableV.dataSource = self;
    self.tableV.delegate =self;
    self.tableV.separatorColor = QIANZITIcolor;;
    [self.tableV registerClass:[TianjiaxianzhongTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableV];
    
    [self.tableV setLayoutMargins:UIEdgeInsetsZero];
    [self.tableV setSeparatorInset:UIEdgeInsetsZero];
    
    
   UIButton *  downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    downBtn.frame = CGRectMake(0,wScreenH-64-45, wScreenW,45);
    downBtn.backgroundColor = SHENLANSEcolor;
    [downBtn setTitleColor:wWhiteColor forState:UIControlStateNormal];
    [downBtn setTitle:@"下一步,填写参数" forState:UIControlStateNormal];
    downBtn.titleLabel.font = Font(18);
    [downBtn addTarget:self action:@selector(dianjitijian) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:downBtn];
    
}

#pragma mark===点击事件
-(void)dianjitijian
{
    if (upArray.count>=1)
    {
        NSMutableArray * aaa = [NSMutableArray array];
        
        for (DataModel * data in upArray)
        {
            [aaa addObject:data.id];
        }        
        NSString * str = [aaa componentsJoinedByString:@","];
         
        if (_tianjiaXianzgong.length>=1)
        {
            _xianzhongBlock(str);
            
        [self.navigationController popViewControllerAnimated:YES];
            
        }else
        {
            TijiancanshuViewController * tijian = [TijiancanshuViewController new];
            tijian.xianzhongs = str ;
            tijian.sex = _sex;
            tijian.beibaoid = _beibaoid;
            tijian.aImg = _myimg;
            tijian.aModel = _aModel;
            
            [self.navigationController pushViewController:tijian animated:YES];
        }
        
      }else
    {
        
        [WBYRequest showMessage:@"请选择险种"];
    }
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return 30;
    }else
    {
        
        return 15;
    }
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel * lab;
    
    if (section==0)
    {
        if (!lab)
        {
            lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 30)];
            lab.backgroundColor = JIANGEcolor;
            
            lab.textColor = QIANZITIcolor;
            lab.text =upArray.count<1?@"  请选择险种":@"  已选择险种";
            
        }
    }else
    {
        lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 15)];
        lab.backgroundColor = JIANGEcolor;
        lab.textColor = QIANZITIcolor;
    }
    
    
    return lab;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return HANGGAO;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return upArray.count;
    }else
    {
        return downArray.count;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TianjiaxianzhongTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if (indexPath.section==0)
    {
        if (upArray.count>0)
        {
            
        DataModel * model = upArray[indexPath.row];
            
        [cell.mybtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61c", 22, wRedColor)] forState:UIControlStateNormal];
            
            if ([model.is_main isEqualToString:@"1"])
            {
                cell.midImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e618", 20, SHENLANSEcolor)];
            }
            else if ([model.is_main isEqualToString:@"2"])
            {
                cell.midImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61e", 20, wRedColor)];
            }
            else
            {
                cell.midImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61a", 20,ZuoHeXianColour)];
            }
            cell.mylab.text = model.name;
            
        }
        
    }else
    {
        
        if (downArray.count>0)
        {
            DataModel * model = downArray[indexPath.row];

        [cell.mybtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61b", 22, QIANZITIcolor)] forState:UIControlStateNormal];
            
            if ([model.is_main isEqualToString:@"1"])
            {
                cell.midImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e618", 20, SHENLANSEcolor)];
            }
            else if ([model.is_main isEqualToString:@"2"])
            {
                cell.midImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61e", 20, wRedColor)];
            }
            else
            {
                cell.midImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61a", 20,ZuoHeXianColour)];
            }
            
            cell.mylab.text = model.name;
            
        }
        
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section==0)
    {
        DataModel * model = upArray[indexPath.row];
        [upArray removeObject:model];
        [downArray addObject:model];
        
    }else
    {        
        DataModel * model = downArray[indexPath.row];
        
        NSArray * arr = [_tianjiaXianzgong componentsSeparatedByString:@","];
        
        if ([arr containsObject:model.id])
        {
            [WBYRequest showMessage:@"已添加险种"];
            return;
            
        }else
        {
            [upArray addObject:model];
            [downArray removeObject:model];
        }
        
    }
    
    [_tableV reloadData];
}



-(void)requestData:(NSString*)keyword
{
    WS(weakSelf);
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:keyword?keyword:@"" forKey:@"keyword"];
   
    [dic setObject:@"1" forKey:@"p"];
    [dic setObject:@"100" forKey:@"pagesize"];
    
    [WBYRequest wbyPostRequestDataUrl:@"has_rate_pros" addParameters:dic success:^(WBYReqModel *model)
     {
         [weakSelf.beijingDateView removeFromSuperview];
         [downArray removeAllObjects];

         if ([model.err isEqualToString:TURE])
         {
       
             [downArray addObjectsFromArray:model.data];
             
             if (downArray.count==0)
             {
                 [WBYRequest showMessage:@"没事有数据"];
                 [weakSelf wushuju];
             }
             
             
             [weakSelf creatTab];

         }else{
             
             [WBYRequest showMessage:model.info];
         }
         
         [weakSelf.tableV reloadData];
         
     } failure:^(NSError *error) {
         
     } isRefresh:NO];
    
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
    [_searchBar changeLeftPlaceholder:@"  请输入搜索内容"];
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
        
        
        [self requestData:_searchBar.text];
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
//        [self requestleiBieDateDatalng:@"" latStr:@"" proStr:@"" cityStr:@"" countyStr:@"" jigouleixingId:@"" gslx:@"" guanjianzi:_searchBar.text?_searchBar.text:@""];
        
        [self requestData:_searchBar.text];

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
        
        [self requestData:_searchBar.text];
        
    }else
    {
        [WBYRequest showMessage:@"请输入搜索内容"];
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
