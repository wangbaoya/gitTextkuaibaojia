//
//  ShouYeViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ShouYeViewController.h"
#import "WangShouyeTableViewCell.h"
#import "RemenzixunViewController.h"
#import "XinwenxiangqingViewController.h"
#import "AAAAViewController.h"
#import "LISHIViewController.h"
#import "YaoqingViewController.h"
#import "BaodantijianaaViewController.h"
#import "ShangchengViewController.h"
#import "DailirenzhengxinxiViewController.h"
#import "WeizhantuijianViewController.h"
#import "MyTabbarviewconstrerViewController.h"
#import "LoginViewController.h"
#import "RemenXianZhongViewController.h"


@interface ShouYeViewController ()<UIScrollViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,IFlyRecognizerViewDelegate>
{
    UIScrollView * myScroll;
    UITextField * _searchBar;
    UITableView * myTab;
    CGFloat oldOffset;
    
    NSMutableArray * allData;
    
    NSInteger numindex;
    
    CGFloat hhhh;
    
    NSArray * textArr;

    NSArray * renzhengArr;
}
@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;//带界面的识别对象
@property (nonatomic,strong) IFlyPcmRecorder *pcmRecorder;//录音器，用于音频流识别的数据传入


@end

@implementation ShouYeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    numindex = 1;
    
    
    [self request];
    
    allData = [NSMutableArray array];
    self.view.backgroundColor = wWhiteColor;
    
    renzhengArr = [NSArray array];
    [self creatmyscroview];
    [self wbyUpTextApp];
    
  }

#pragma mark===点击五个热门

-(void)jinru:(UIButton*)btn
{
    if (btn.tag==5858)
    {
        
    MyTabbarviewconstrerViewController  * shangcheng = [MyTabbarviewconstrerViewController new];
        shangcheng.dijici = 666;
        
        shangcheng.selectedIndex = 2;
    [[UIApplication sharedApplication].delegate window].rootViewController = shangcheng;
        
    }else if (btn.tag==5858+1)
    {
        
        YaoqingViewController * yaoqing = [YaoqingViewController new];
        [self.navigationController pushViewController:yaoqing animated:YES];
        
        
    }else if (btn.tag == 5858+2)
    {
        BaodantijianaaViewController * baodan = [BaodantijianaaViewController new];
        
        
        [self.navigationController pushViewController:baodan animated:YES];
        
    }else if (btn.tag==5858+3)
    {
        RemenXianZhongViewController * remenxianzh = [RemenXianZhongViewController new];
        [self.navigationController pushViewController:remenxianzh animated:YES];
        
        
    }else
    {
        
        UILabel *alaa = [self.view viewWithTag:6868+4];
        
        if([alaa.text isEqualToString:@"我的微站"])
        {
            WeizhantuijianViewController * tuijian = [WeizhantuijianViewController new];
            [self.navigationController pushViewController:tuijian animated:YES];
            
        }else
        {
           
            [self dailirenzhengrequest];
            
        }
    }
}

-(void)creatmyscroview
{
    hhhh = 160;
    
    myScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0,20, wScreenW, wScreenH-49-20)];
    myScroll.bounces = NO;
    myScroll.delegate = self;
    myScroll.contentSize = CGSizeMake(wScreenW, wScreenH-49-20+hhhh);
//    myScroll.scrollEnabled = NO;
    myScroll.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myScroll];
    
    UIView * upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, hhhh+40+10)];
    
    [myScroll addSubview:upView];
    
    UIImageView * upImg = [[UIImageView alloc] initWithFrame:CGRectMake(wScreenW/2-(103-15)/2, 27+15, 63+40-15, 66+40-15)];
    
    upImg.image = [UIImage imageNamed:@"logooo"];
    
    upImg.userInteractionEnabled = YES;
    
    upImg.center = CGPointMake(self.view.center.x, 27+15+(106-15)/2);
    
    [upView addSubview:upImg];
   
//    [upImg makeDraggable];
    
    _searchBar = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(upImg.frame)+27+1,wScreenW - 30, 42)];
    
    _searchBar.layer.borderColor = QIANZITIcolor.CGColor;
    _searchBar.layer.borderWidth = 0.5;
    
    _searchBar.placeholder = @"  请输入搜索内容";
    

    _searchBar.delegate = self;
    [upView addSubview:_searchBar];

    UIButton * myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    myBtn.frame = CGRectMake(wScreenW-30 - 30 - 4,4, 30, 30);
    [myBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e60c", 20,QIANLANSEcolor)] forState:UIControlStateNormal];
    
    [myBtn addTarget:self action:@selector(onClickMyBtn) forControlEvents:UIControlEventTouchUpInside];
    [_searchBar addSubview:myBtn];
    
    
   NSArray * imgArr = @[@"\U0000e604",@"\U0000e60b",@"\U0000e601",@"\U0000e600",@"\U0000e60d"];
    
    NSString * type = TYPE;

    if ([type isEqualToString:@"0"])
    {
        textArr = @[@"保险商城",@"推荐有礼",@"保单体检",@"热门险种",@"代理认证"];
    }else
    {
        NSLog(@"===%@",RENZHENGZHUANGTAI);
        
        if ([RENZHENGZHUANGTAI isEqualToString:@"0"])
        {
            textArr = @[@"保险商城",@"推荐有礼",@"保单体检",@"热门险种",@"代理认证"];
        }else if ([RENZHENGZHUANGTAI isEqualToString:@"1"]){
            
            textArr = @[@"保险商城",@"推荐有礼",@"保单体检",@"热门险种",@"我的微站"];
        }else if ([RENZHENGZHUANGTAI isEqualToString:@"2"])
        {
            textArr = @[@"保险商城",@"推荐有礼",@"保单体检",@"热门险种",@"认账驳回"];
        }else if ([RENZHENGZHUANGTAI isEqualToString:@"3"])
        {
            textArr = @[@"保险商城",@"推荐有礼",@"保单体检",@"热门险种",@"审核中"];
        }else
        {
            textArr = @[@"保险商城",@"推荐有礼",@"保单体检",@"热门险种",@"代理认证"];
        }
    }
   NSArray * coloArr = @[RGBwithColor(253, 174, 12),RGBwithColor(251, 71, 78),RGBwithColor(44, 132, 210),RGBwithColor(252, 71, 78),RGBwithColor(50,216,116)];
    
    UIView * midView = [[UIView alloc] initWithFrame:CGRectMake(0,200, wScreenW, 75+7.5+7.5+40)];
    midView.backgroundColor = JIANGEcolor;
//    [self.view addSubview:midView];
    
    UIView * fiveBtnview = [[UIView alloc] initWithFrame:CGRectMake(0, 7.5, wScreenW, 75)];
    fiveBtnview.backgroundColor = wWhiteColor;
    [midView addSubview:fiveBtnview];
    
    CGFloat ww = wScreenW/5;
    
    for (NSInteger i=0; i<imgArr.count; i++)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(ww * (i%5),0, ww, 75*0.65);
        [btn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(imgArr[i], 35, coloArr[i])] forState:UIControlStateNormal];
        btn.tag = 5858 + i;
        [btn addTarget:self action:@selector(jinru:) forControlEvents:UIControlEventTouchUpInside];
//        [btn setImageEdgeInsets:UIEdgeInsetsMake(-10,0, 0, 0)];
        [fiveBtnview addSubview:btn];
        
    }
 
    for (NSInteger i=0; i<textArr.count; i++)
    {
        UILabel * aLab = [UILabel new];
        aLab.frame =  CGRectMake(ww * (i%5),75*0.65-5, ww, 75*0.35+5);
        aLab.font = ZT14;
        aLab.textAlignment = 1;
        aLab.text = textArr[i];
        aLab.tag = 6868 + i;
        aLab.textColor = wBlackColor;
        [fiveBtnview addSubview:aLab];
    }
    
    
    UIView * downView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(fiveBtnview.frame)+7.5, wScreenW, 40)];
    downView.backgroundColor = wWhiteColor;
    [midView addSubview:downView];
    
    UIButton * remenLab = [UIButton buttonWithType:UIButtonTypeCustom];
    remenLab.frame = CGRectMake(0, 0, 90, 40);
    
    [remenLab setTitle:@"保险资讯" forState:UIControlStateNormal];
    remenLab.titleLabel.font = Font(16);
    [remenLab setTitleColor:wBlackColor forState:UIControlStateNormal];
    [remenLab addTarget:self action:@selector(remen) forControlEvents:UIControlEventTouchUpInside];

    [downView addSubview:remenLab];

    
    remenLab.center = CGPointMake(self.view.center.x,40/2);
    
    UILabel * llab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW/2-45-70, 40/2, 70, 1)];
    llab.backgroundColor = FENGEXIANcolor;
    [downView addSubview:llab];
    
    UILabel * rlab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW/2+45, 40/2, 70, 1)];
    rlab.backgroundColor = FENGEXIANcolor;
    [downView addSubview:rlab];
    
    [[AipOcrService shardService] authWithAK:@"VOXEHzMAhgAcIbylrrryBSqD" andSK:@"aL4jWkWhCFNUpkd3zIvjiELs96GRCaA2"];
    

    
//    wScreenH -185-49+hhhh
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0,hhhh+38+10, wScreenW, wScreenH-49-38-20-14) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    myTab.separatorColor = FENGEXIANcolor;
    myTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [myTab registerClass:[WangShouyeTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    myTab.tableHeaderView =  midView;
    myTab.scrollEnabled = NO;
    
    myTab.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    myTab.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
    
    [myTab setSeparatorInset:UIEdgeInsetsZero];
    [myTab setLayoutMargins:UIEdgeInsetsZero];
    
    [myScroll addSubview:myTab];
    
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



-(void)remen
{
    
//    RemenzixunViewController * remen = [RemenzixunViewController new];
//    [self.navigationController pushViewController:remen animated:YES];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return allData.count;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    

//    if (scrollView==myScroll)
//    {
//        
//        if (scrollView.contentOffset.y>oldOffset)
//        {
//            NSLog(@"===向上");
//            NSLog(@"==8888====%lf",scrollView.contentOffset.y);
//
//            
//        }else
//        {
//            NSLog(@"===向xiaxia");
//            NSLog(@"==8888====%lf",scrollView.contentOffset.y);
//
//            myTab.scrollEnabled = YES;
// 
//            
//        }
//        
//        
//    }
    
    
      if (scrollView==myScroll)
    {
        if (scrollView.contentOffset.y>oldOffset)
        {
            NSLog(@"===向上");
            if (scrollView.contentOffset.y>=1)
            {
                [UIView animateWithDuration:0.3 animations:^{
                    myScroll.contentOffset = CGPointMake(0,hhhh);
                    
                    myTab.contentOffset = CGPointMake(0,0);
                    
                    myTab.scrollEnabled = YES;
                    
                }];
            }
            
        }else
        {
            if (scrollView.contentOffset.y>=1)
            {
                [UIView animateWithDuration:0.3 animations:^{
                    myScroll.contentOffset = CGPointMake(0,0);
                    myTab.contentOffset = CGPointMake(0,0);
                    myTab.scrollEnabled = NO;
                    
                }];
            }else
            {       myTab.scrollEnabled = YES;
    
                [self headerRereshing];
            }
         }
        oldOffset = scrollView.contentOffset.y;
    }
    
    if (scrollView==myTab)
    {
        if (scrollView.contentOffset.y<1)
        {
            [UIView animateWithDuration:0.3 animations:^{
                myScroll.contentOffset = CGPointMake(0,0);
                myTab.scrollEnabled = NO;
            }];
        }
    }
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
    
//    celqq.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1);
    celqq.myImg.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1);

    [UIView animateWithDuration:0.9 animations:^{
        
        celqq.myImg.layer.transform= CATransform3DMakeScale(1, 1, 1);
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
}



#pragma mark==语音
-(void)onClickMyBtn
{
    [_searchBar resignFirstResponder];
    [self changeOnclick];
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    AAAAViewController * remenxianzh = [AAAAViewController new];
    [self.navigationController pushViewController:remenxianzh animated:YES];
    return NO;
    
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
    
    _searchBar.placeholder = [NSString stringWithFormat:@"%@%@",_searchBar.text,result];
    
    if (_searchBar.placeholder.length >= 1)
    {
        LISHIViewController * sousuo =  [LISHIViewController new];
        sousuo.lishiStr = _searchBar.placeholder;

        [self.navigationController pushViewController:sousuo animated:NO];        
        
    }else
    {
        
//        [WBYRequest showMessage:@"没有获取到语音信息"];
    }
    
    
    NSLog(@"====%@",result);
}


- (void)onError: (IFlySpeechError *) error
{
    NSLog(@"===%@",error);
    
}


-(void)request
{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSString stringWithFormat:@"%zd",(long)numindex] forKey:@"p"];
    [dic setObject:@"30" forKey:@"pagesize"];
 
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

-(void)wbyUpTextApp
{
    //2先获取当前工程项目版本号
    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];
    
    //3从网络获取appStore版本号
    NSError *error;
    NSData *response = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@",STOREAPPID]]] returningResponse:nil error:nil];
    if (response == nil)
    {
        NSLog(@"你没有连接网络哦");
        
        return;
    }
    NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    if (error) {
        NSLog(@"hsUpdateAppError:%@",error);
        return;
    }
    //    NSLog(@"%@",appInfoDic);
    NSArray *array = appInfoDic[@"results"];
    NSDictionary *dic = array[0];
    //   version
    NSString *appStoreVersion = dic[@"version"];
    //打印版本号
    NSLog(@"当前版本号:%@\n商店版本号:%@",currentVersion,appStoreVersion);
    //设置版本号
    currentVersion = [currentVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    if (currentVersion.length==2)
    {
        currentVersion  = [currentVersion stringByAppendingString:@"0"];
    }else if (currentVersion.length==1)
    {
        currentVersion  = [currentVersion stringByAppendingString:@"00"];
    }
    
    appStoreVersion = [appStoreVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    if (appStoreVersion.length==2) {
        appStoreVersion  = [appStoreVersion stringByAppendingString:@"0"];
    }else if (appStoreVersion.length==1){
        appStoreVersion  = [appStoreVersion stringByAppendingString:@"00"];
    }
    
    //4当前版本号小于商店版本号,就更新
    if([currentVersion floatValue] < [appStoreVersion floatValue])
    {
        UIAlertController *alercConteoller = [UIAlertController alertControllerWithTitle:@"有新版本出现" message:[NSString stringWithFormat:@"检测到新版本(%@),是否更新?",dic[@"version"]] preferredStyle:UIAlertControllerStyleAlert];
        //        https://itunes.apple.com/us/app/gong-wu-yong-che/id1158761757?mt=8
        UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                    {
                                        //此处加入应用在app store的地址，方便用户去更新，一种实现方式如下https://itunes.apple.com/lookup?id=%
                                        //            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8",STOREAPPID]];
                                        
                                        NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/yi-ka-tongbic-ban/id%@?l=en&mt=8",STOREAPPID]];
                                        [[UIApplication sharedApplication] openURL:url];
                                        
                                    }];
        
        UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
                                   {
                                       
                                   }];
        [alercConteoller addAction:actionYes];
        [alercConteoller addAction:actionNo];
        
        [self presentViewController:alercConteoller animated:YES completion:nil];
        
    }else{
        
        NSLog(@"版本号好像比商店大噢!检测到不需要更新");
    }
    
}

-(void)dailirenzhengrequest
{
    WS(weakSelf);
    if (KEY&&UID)
    {
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        
        [WBYRequest wbyLoginPostRequestDataUrl:@"get_verify" addParameters:dic success:^(WBYReqModel *model)
         {
             if ([model.err isEqualToString:TURE])
             {
                 renzhengArr = model.data;
                 DataModel * mod = [renzhengArr firstObject];
                 
                 DailirenzhengxinxiViewController * daili = [DailirenzhengxinxiViewController new];
                 daili.aModel = mod;
                 
                 [weakSelf.navigationController pushViewController:daili animated:YES];
                 
             }
             if ([model.err isEqualToString:SAME])
             {
                 UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要去登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                 
                 [view show];
             }
             
         } failure:^(NSError *error) {
             
         }];
    }
    
    else
    {
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要去登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [view show];
    }
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self creatrequestData];

//    self.hidesBottomBarWhenPushed = NO;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        [self.navigationController pushViewController:[LoginViewController new] animated:YES];
    }
    
}

-(void)creatrequestData
{
    
//    WS(weakSelf);
    //    if (KEY&&UID)
    //    {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [WBYRequest wbyLoginPostRequestDataUrl:@"get_user" addParameters:dic success:^(WBYReqModel *model)
     {
         if ([model.err isEqualToString:TURE])
         {
             DataModel * user = [model.data firstObject];
             NSUserDefaults * stand = [NSUserDefaults standardUserDefaults];
             [stand setObject:user.status forKey:@"renzhengzhuangtai"];
             [stand setObject:user.type forKey:@"type"];
             [stand synchronize];
             
//             NSString * type = TYPE;
             if ([user.type isEqualToString:@"0"])
             {
                 textArr = @[@"保险商城",@"推荐有礼",@"保单体检",@"热门险种",@"代理认证"];
             }else
             {
//                 NSLog(@"===%@",RENZHENGZHUANGTAI);
                 if ([user.status isEqualToString:@"0"])
                 {
                     textArr = @[@"保险商城",@"推荐有礼",@"保单体检",@"热门险种",@"代理认证"];
                 }else if ([user.status isEqualToString:@"1"]){
                     
                     textArr = @[@"保险商城",@"推荐有礼",@"保单体检",@"热门险种",@"我的微站"];
                 }else if ([user.status isEqualToString:@"2"])
                 {
                     textArr = @[@"保险商城",@"推荐有礼",@"保单体检",@"热门险种",@"认账驳回"];
                 }else if ([user.status isEqualToString:@"3"])
                 {
                     textArr = @[@"保险商城",@"推荐有礼",@"保单体检",@"热门险种",@"审核中"];
                 }else
                 {
                     textArr = @[@"保险商城",@"推荐有礼",@"保单体检",@"热门险种",@"代理认证"];
                 }
             }

             for (NSInteger i=0; i<textArr.count; i++)
             {
                 UILabel * lab = [self.view viewWithTag:6868+i];
                 lab.text = textArr[i];
             }
          }
         
         
//         if ([model.err isEqualToString:SAME])
//         {
//             NSUserDefaults * defau = [NSUserDefaults standardUserDefaults];
//             
//             [defau removeObjectForKey:@"key"];
//             [defau removeObjectForKey:@"uid"];
//             [defau removeObjectForKey:@"xingming"];
//             [defau removeObjectForKey:@"type"];
//             [defau removeObjectForKey:@"renzhengzhuangtai"];
//             [defau removeObjectForKey:@"renzhengmingzi"];
//             [defau synchronize];
//             
//             [WBYRequest showMessage:model.info];
//             
//             [weakSelf goLogin];
//             
//         }
         
         
         
     } failure:^(NSError *error) {
         
     }];
    
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
