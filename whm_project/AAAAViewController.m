//
//  AAAAViewController.m
//  SearchHistory
//
//  Created by apple on 17/5/23.
//  Copyright © 2017年 机智的新手. All rights reserved.
//

#import "AAAAViewController.h"
#import "PlayVcEverLike.h"
#import "aaaCollectionReusableView.h"
#import "AACollectionViewCell.h"
#import "XianZhongliebiaoViewController.h"
#import "LISHIViewController.h"

@interface AAAAViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate,UIScrollViewDelegate,IFlyRecognizerViewDelegate>
{
    UISearchBar * _searchBar;
    UIImageView * xiaoImg;
    UILabel * xiaolab;
    UIScrollView * myScroll;
    UIView * bigView;
    

    UIView * cView;
    
    NSArray * allArr;
    
    NSInteger index;
    
    NSArray * remensousuoArr;
    NSArray * resouArr;
    NSArray * fenleiArr;
    UICollectionView * momentCollectionView;
    
//    CGSize aSize;
    
    BOOL isSearch;
    
    

}
@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;//带界面的识别对象
@property (nonatomic,strong) IFlyPcmRecorder *pcmRecorder;//录音器，用于音频流识别的数据传入
//@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation AAAAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = wWhiteColor;
    index = 0;
    allArr = [NSArray array];
    remensousuoArr = [NSArray array];
    resouArr = [NSArray array];
    fenleiArr = [NSArray array];

    [self requesFenleiData];
    [self requestremenxianzhongData];
    [self requestresouguanjianziData];
    [self creatupview];
    
    
    isSearch = NO;
    
    
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
    [_searchBar changeLeftPlaceholder:@" 请输入搜索内容"];
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
    [self creatbigView];
    
}
-(void)creatbigView
{
    myScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0,90, wScreenW, wScreenH-90)];
    myScroll.bounces = NO;
    myScroll.delegate = self;
    myScroll.contentSize = CGSizeMake(wScreenW*3, wScreenH-90);
    //    myScroll.scrollEnabled = NO;
    myScroll.showsVerticalScrollIndicator = NO;
    myScroll.pagingEnabled = YES;
    
    myScroll.backgroundColor = wWhiteColor;
    [self.view addSubview:myScroll];
    
    [self creatmycolle];
   
}

#pragma mark==滑动视图代理

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView==myScroll)
    {
        index = scrollView.contentOffset.x/wScreenW;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView==myScroll)
    {
        UIButton * btn = [self.view viewWithTag:5858 + index];
        
        for (NSInteger i =0; i<3; i++)
        {
            UIButton * aBtn = [self.view viewWithTag:5858+i];
            aBtn.selected = NO;
        }
        btn.selected = YES;
        xiaoImg.center = CGPointMake(btn.center.x, btn.center.y+2.5-15);
        xiaolab.center = CGPointMake(btn.center.x, btn.center.y+2.5-11);
        
        momentCollectionView.frame = CGRectMake(wScreenW * index, 0, wScreenW,wScreenH-90);
        
        [momentCollectionView reloadData];

    }
    
}
-(void)dianjiqingkong
{
    [PlayVcEverLike clearVids];
    allArr = [PlayVcEverLike getVids];
    [momentCollectionView reloadData];
}


-(void)creatmycolle
{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    momentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, wScreenW, wScreenH-90) collectionViewLayout:layout];
    momentCollectionView.delegate = self;
    momentCollectionView.dataSource =self;
    momentCollectionView.backgroundColor = wWhiteColor;
    [myScroll  addSubview:momentCollectionView];
    
    [momentCollectionView registerClass:[AACollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [momentCollectionView registerClass:[aaaCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    
    [self.navigationController pushViewController:[LISHIViewController new] animated:NO];
    
    return NO;
}

//找险
-(void)requestremenxianzhongData
{
    //    WS(weakSelf);
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setObject:[NSString stringWithFormat:@""] forKey:@"p"];
    [dic setObject:@"" forKey:@"pagesize"];
    
    [WBYRequest wbyPostRequestDataUrl:@"hot_keys" addParameters:dic success:^(WBYReqModel *model)
     {
         if ([model.err isEqualToString:TURE])
         {
             remensousuoArr = model.data;
             
         }else
         {
             [WBYRequest showMessage:model.err];
         }
         
         [momentCollectionView reloadData];
     } failure:^(NSError *error) {
         
     } isRefresh:NO];
    
}


//热搜

-(void)requestresouguanjianziData
{
    //    WS(weakSelf);
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setObject:[NSString stringWithFormat:@""] forKey:@"p"];
    [dic setObject:@"" forKey:@"pagesize"];
    
    [WBYRequest wbyPostRequestDataUrl:@"cate_keys" addParameters:dic success:^(WBYReqModel *model)
     {
         if ([model.err isEqualToString:TURE])
         {
             resouArr = model.data;
             
         }else
         {
             [WBYRequest showMessage:model.err];
         }
         
     } failure:^(NSError *error) {
         
     } isRefresh:NO];
    
}
//分类

-(void)requesFenleiData
{
    //    WS(weakSelf);
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    //    [dic setObject:[NSString stringWithFormat:@""] forKey:@"p"];
    //    [dic setObject:@"" forKey:@"pagesize"];
    
    [WBYRequest wbyPostRequestDataUrl:@"cates" addParameters:dic success:^(WBYReqModel *model)
     {
         if ([model.err isEqualToString:TURE])
         {
             fenleiArr = model.data;
             
         }else
         {
             [WBYRequest showMessage:model.err];
         }
         
     } failure:^(NSError *error) {
         
     } isRefresh:NO];
    
}

#pragma mark===代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (index==0)
    {
       
        if (section==0)
        {
           return remensousuoArr.count;
            
        }else
        {
            return allArr.count;
        }
        
        
    }else if (index==1)
    {
        DataModel * data = resouArr[section];
        
        return data.words.count;
        
    }else
    {
        DataModel * data = fenleiArr[section];
        return data.child.count;
     }
    
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    if (index==0)
    {
        return 2;
        
    }else if (index==1)
    {
     return   resouArr.count;
        
    }else
    {
      return  fenleiArr.count;
        
    }
    
}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        
   aaaCollectionReusableView * tagcell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        
         tagcell.qingchuBtn.hidden = YES;
        tagcell.backgroundColor = JIANGEcolor;
        
        tagcell.title.backgroundColor = wWhiteColor;
        tagcell.title.textColor = wBlackColor;
//         tagcell.title.font = ZHONGZITI;
        
        if (index==0)
        {
            if (indexPath.section==0)
            {
               
        tagcell.title.text = [NSString stringWithFormat:@"   热门"];
               
            }else
            {
               
         tagcell.title.text = [NSString stringWithFormat:@"   历史记录"];
            tagcell.qingchuBtn.hidden = NO;
            [tagcell.qingchuBtn addTarget:self action:@selector(dianjiqingkong) forControlEvents:UIControlEventTouchUpInside];
              
            }
        }else if (index==1)
        {
            if (resouArr.count>=1)
            {
                DataModel * mod = resouArr[indexPath.section];
                tagcell.title.text = [NSString stringWithFormat:@"  %@",mod.name];
                
            }
        }else if(index==2)
        {
            if (fenleiArr.count>=1)
            {
                DataModel * mod = fenleiArr[indexPath.section];
                tagcell.title.text = [NSString stringWithFormat:@"  %@",mod.name];
            }
        }
        
        return tagcell;
        
        
    }else //有兴趣的也可以添加尾部视图
    {
        return nil;
    }
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    AACollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.aLab.textColor = wBlackColor;
    if (index==0)
    {
        if (indexPath.section==0)
        {
            if (remensousuoArr.count>=1)
            {
                DataModel * mod = remensousuoArr[indexPath.item];
                cell.keyword = mod.name;
            }
        }else
        {
            if (allArr.count>=1)
            {
                 cell.keyword = allArr[indexPath.item];
            }
        }
    }else if (index==1)
    {
        if (resouArr.count>=1)
        {
            DataModel * mod = resouArr[indexPath.section];
           
            WwordsModel * amod = mod.words[indexPath.item];
            
             cell.keyword = amod.name;
        }
    }else if(index==2)
    {
        if (fenleiArr.count>=1)
        {
            DataModel * mod = fenleiArr[indexPath.section];
            childModel * amod = mod.child[indexPath.item];
            cell.keyword = amod.name;

           }
    }
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    AACollectionViewCell * _cell =  [AACollectionViewCell new];
    
    if (index==0)
    {
        if (indexPath.section==0)
        {
            if (remensousuoArr.count>=1)
            {
                DataModel * mod = remensousuoArr[indexPath.item];
                _cell.keyword = mod.name;
            }
        }else
        {
            if (allArr.count>=1)
            {
                _cell.keyword = allArr[indexPath.item];
            }
        }
    }else if (index==1)
    {
        if (resouArr.count>=1)
        {
            DataModel * mod = resouArr[indexPath.section];
            
            WwordsModel * amod = mod.words[indexPath.item];
            
            _cell.keyword = amod.name;
        }
    }else if(index==2)
    {
        if (fenleiArr.count>=1)
        {
            DataModel * mod = fenleiArr[indexPath.section];
            childModel * amod = mod.child[indexPath.item];
            
            _cell.keyword = amod.name;
        }
    }
    
    [_cell layoutIfNeeded];
    
    CGRect frame = _cell.frame;
    
    return CGSizeMake(frame.size.width, frame.size.height );
   
}



  -(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake(wScreenW, 54.0);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
   
        return UIEdgeInsetsMake(10, 20, 10, 20);
   }


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
      XianZhongliebiaoViewController * xianzhong = [XianZhongliebiaoViewController new];
    
    if (index==0)
    {
        if (indexPath.section==0)
        {
            if (remensousuoArr.count>=1)
            {
                DataModel * mod = remensousuoArr[indexPath.item];
                xianzhong.xianzhong = mod.name;
                xianzhong.mong_id = mod.mongo_id;
                
                [PlayVcEverLike writeToFileDocumentPathByVid:mod.name?mod.name:@""];
            }
        }else
        {
            if (allArr.count>=1)
            {
//                _cell.keyword = allArr[indexPath.item];
                xianzhong.xianzhong = allArr[indexPath.item];
                xianzhong.keywored = allArr[indexPath.item];
            }
        }
    }else if (index==1)
    {
        if (resouArr.count>=1)
        {
            DataModel * mod = resouArr[indexPath.section];
            
            WwordsModel * amod = mod.words[indexPath.item];
            
//            _cell.keyword = amod.name;
            xianzhong.xianzhong = amod.name;
            xianzhong.mong_id = amod.mongo_id;
            [PlayVcEverLike writeToFileDocumentPathByVid:amod.name?amod.name:@""];


        }
    }else if(index==2)
    {
        if (fenleiArr.count>=1)
        {
            DataModel * mod = fenleiArr[indexPath.section];
            childModel * amod = mod.child[indexPath.item];
            xianzhong.xianzhong = amod.name;
            xianzhong.cate_id = amod.id;
            [PlayVcEverLike writeToFileDocumentPathByVid:amod.name?amod.name:@""];
        }
    }
    
    [self.navigationController pushViewController:xianzhong animated:YES];
    
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
    myScroll.contentOffset = CGPointMake(wScreenW*(btn.tag-5858), 0);
    
    momentCollectionView.frame = CGRectMake(wScreenW * (btn.tag-5858), 0, wScreenW,wScreenH-90);
    
    [momentCollectionView reloadData];
}



#pragma mark==搜索
-(void)sousuoButtonClick
{
    [_searchBar resignFirstResponder];    
    if (_searchBar.text.length>=1)
    {
        [self searchByKeyword:_searchBar.text?_searchBar.text:@""];
        
        XianZhongliebiaoViewController * xianzhong = [XianZhongliebiaoViewController new];
        
        xianzhong.keywored = _searchBar.text;
        xianzhong.xianzhong = _searchBar.text;
        [self.navigationController pushViewController:xianzhong animated:YES];
 
    }else
    {
        
        [WBYRequest showMessage:@"请输入搜索内容"];
    }
    
    
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_searchBar resignFirstResponder];
    
    [self searchByKeyword:_searchBar.text?_searchBar.text:@""];
    
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
-(void)searchByKeyword:(NSString *)keyWord
{
    [PlayVcEverLike writeToFileDocumentPathByVid:keyWord];
    allArr = [PlayVcEverLike getVids];
    
    [momentCollectionView reloadData];
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark==语音
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
    
    if (_searchBar.text.length >= 1)
    {
        LISHIViewController * sousuo =  [LISHIViewController new];
        sousuo.lishiStr = _searchBar.text;
        [self.navigationController pushViewController:sousuo animated:NO];
        
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
    
    allArr = [PlayVcEverLike getVids];
    
    _searchBar.text = @"";
    
    [momentCollectionView reloadData];

    [self.navigationController setNavigationBarHidden:YES animated:NO];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
