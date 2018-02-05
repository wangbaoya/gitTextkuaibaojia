//
//  WoDeBaoDanViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WoDeBaoDanViewController.h"
#import "WodebaodanceTableViewCell.h"
#import "XiuGaiViewController.h"
#import "BaodangerenViewController.h"


@interface WoDeBaoDanViewController ()<UITableViewDelegate,UITableViewDataSource,CMIndexBarDelegate>
{
    NSArray * beibaorenArr;
    UITableView * gongsiTab;
    NSMutableArray * agongsiArray;
    NSMutableArray * _firstArr;
    
    CMIndexBar *indexBar;
    UIView * quanxuanDownview;
    UILongPressGestureRecognizer * longpress;

    NSInteger changanTag;
    
    DataModel * shanchumod;
}


@property (nonatomic,strong)NSMutableDictionary * dic;
@property (nonatomic, strong) NSMutableArray *deleteArray;

@end

@implementation WoDeBaoDanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"被保人";
    agongsiArray = [NSMutableArray array];
    _firstArr = [NSMutableArray array];
    self.dic = [NSMutableDictionary dictionary];
    
    self.deleteArray = [NSMutableArray array];
    
    
    
    [self creatLeftTtem];
    [self creatRight];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self requestData];
}


-(void)creatRight
{
//    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame=CGRectMake(wScreenW-40-40-20, 0, 40, 25);
//    [button setTitle:@"编辑" forState:UIControlStateNormal];
////    [button setTitle:@"取消" forState:UIControlStateSelected];
//
//    [button setTitleColor:wWhiteColor forState:UIControlStateNormal];
//    button.backgroundColor = SHENLANSEcolor;
//    button.titleLabel.font = Font(12);
//    [button addTarget:self action:@selector(bianji:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * aabutton =[UIButton buttonWithType:UIButtonTypeCustom];
    aabutton.frame=CGRectMake(0, 0, 50, 30);
    [aabutton setTitle:@"添加" forState:UIControlStateNormal];
    
    [aabutton setTitleColor:wWhiteColor forState:UIControlStateNormal];
    aabutton.backgroundColor = RGBwithColor(40, 210, 89);
    aabutton.titleLabel.font = Font(14);
    [aabutton addTarget:self action:@selector(tianji:) forControlEvents:UIControlEventTouchUpInside];
    
//     UIBarButtonItem *negativeSpacer=[[UIBarButtonItem alloc] initWithCustomView:button];
   
    UIBarButtonItem *aanegativeSpacer =[[UIBarButtonItem alloc] initWithCustomView:aabutton];
//    negativeSpacer.width = -5;
    
    self.navigationItem.rightBarButtonItems = @[aanegativeSpacer];
    
}
-(void)creatdownView
{
    [quanxuanDownview removeFromSuperview];
    quanxuanDownview = [[UIView alloc] initWithFrame:CGRectMake(0, wScreenH-64-44, wScreenW, 44)];
    
    [self.view addSubview:quanxuanDownview];
    
    NSArray * aar = @[@"   全选",@"取消",@"删除"];
    NSArray * bgcoloorArr = @[wWhiteColor,SHENLANSEcolor,wRedColor];
    
    CGFloat ww = wScreenW/3;
    for (NSInteger i =0; i<3; i++)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.frame= CGRectMake(ww*(i%3),0, ww,44);
        [btn setTitle:aar[i] forState:UIControlStateNormal];
        
        if (i==0)
        {
            [btn setTitleColor:QIANZITIcolor forState:UIControlStateNormal];
            [btn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61b", 16,QIANZITIcolor)] forState:UIControlStateNormal];
            [btn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61c", 16,SHENLANSEcolor)] forState:UIControlStateSelected];
        }else
        {
            [btn setTitleColor:wWhiteColor forState:UIControlStateNormal];
        }
        
        btn.backgroundColor = bgcoloorArr[i];
        btn.titleLabel.font = Font(18);
        btn.tag = 666+i;
        [btn addTarget:self action:@selector(quxiaoshanchu:) forControlEvents:UIControlEventTouchUpInside];
        
        [quanxuanDownview addSubview:btn];
    }
}
-(void)quxiaoshanchu:(UIButton*)btn
{
    btn.selected = !btn.selected;
    
    if (btn.tag==666)
    {
        if (btn.selected==YES)
        {
            if (gongsiTab.editing == NO)
            {
                return;
            }
            else
            {
                for (int i = 0; i < _firstArr.count; i++)
                {
                    NSString * key = _firstArr[i];
                    NSArray * arry = [self.dic objectForKey:key];
                    for (int a  = 0; a < arry.count; a++)
                    {
                      DataModel * mod = arry[a];
                    [self.deleteArray addObject:mod.id];
                        
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:a inSection:i];
    
            [gongsiTab selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                    }
                }
            }
        }else
        {
            [self.deleteArray removeAllObjects];
            [gongsiTab reloadData];
        }
        
    }else if (btn.tag==666+1)
    {
        [quanxuanDownview removeFromSuperview];
        gongsiTab.editing = NO;
        
    }else
    {
        if (self.deleteArray.count>=1)
        {
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要删除被保人" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            view.tag = 666;
            [view show];
        
        }else
        {
            [WBYRequest showMessage:@"请选择被保人"];
        }
        
    }
    
    
}
#pragma mark===删除被保人
-(void)deleteRequest:(NSMutableArray*)arr
{
    WS(weakSelf);
    NSString * str = [arr componentsJoinedByString:@","];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setObject:UID forKey:@"uid"];
    [dic setObject:str forKey:@"rela_ids"];
    [WBYRequest wbyLoginPostRequestDataUrl:@"del_rela" addParameters:dic success:^(WBYReqModel *model)
    {
        if ([model.err isEqualToString:TURE])
        {
            [weakSelf requestData];
        }
        
        [WBYRequest showMessage:model.info];
     } failure:^(NSError *error) {
        
    }];
    
    
}
#pragma mark===添加  编辑
-(void)tianji:(UIButton*)btn
{
    XiuGaiViewController * xiugai = [XiuGaiViewController new];
    
    [self.navigationController pushViewController:xiugai animated:YES];
}

-(void)bianji:(UIButton*)btn
{
    btn.selected = !btn.selected;
    if (btn.selected==YES)
    {
        [self creatdownView];
        gongsiTab.editing = YES;
        gongsiTab.allowsMultipleSelectionDuringEditing = YES;

    }else
    {
        [quanxuanDownview removeFromSuperview];
        gongsiTab.editing = NO;
        [self.deleteArray removeAllObjects];
        
    }
}

-(void)creatupview
{
    gongsiTab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, wScreenW, wScreenH - 64) style:UITableViewStylePlain];
    gongsiTab.dataSource = self;
    gongsiTab.delegate =self;
    gongsiTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [gongsiTab registerClass:[WodebaodanceTableViewCell class] forCellReuseIdentifier:@"cell"];
    gongsiTab.rowHeight = 80;
    [self.view addSubview:gongsiTab];
    
    
    [gongsiTab setSeparatorInset:UIEdgeInsetsZero];
    [gongsiTab setLayoutMargins:UIEdgeInsetsZero];
    
    
    gongsiTab.tableFooterView = [UIView new];
    
    [self createList];
}
- (void)createList
{
    
    indexBar = [[CMIndexBar alloc] initWithFrame:CGRectMake(wScreenW-20, 30, 20.0, wScreenH - 40 - 35 - 60- 50)];
//   indexBar.backgroundColor = [UIColor redColor];
    indexBar.textColor = QIANZITIcolor;
    indexBar.textFont = [UIFont systemFontOfSize:12];
    [indexBar setIndexes:@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"#"]];
//    [indexBar setIndexes:_firstArr];
    
    indexBar.delegate = self;
    [self.view addSubview:indexBar];
    
}

-(void)requestData
{
    WS(weakSelf);
    if (KEY&&UID)
    {
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        
        [dic setObject:UID forKey:@"uid"];
        
        [WBYRequest wbyLoginPostRequestDataUrl:@"get_rela" addParameters:dic success:^(WBYReqModel *model)
        {
            
            if ([model.err isEqualToString:TURE])
            {
                [weakSelf.beijingDateView removeFromSuperview];
                
                [_firstArr removeAllObjects];
                [agongsiArray removeAllObjects];
                [weakSelf.dic removeAllObjects];
                
                for (DataModel * data in model.data)
                {
                    [agongsiArray addObject:data];
                }
                if (agongsiArray.count==0)
                {
                    [weakSelf wushuju];
                }                
                NSArray * array = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"#"];
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
                
                
                [weakSelf creatupview];
            }
            
            if ([model.err isEqualToString:SAME])
            {
                UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要去登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                
                [view show];
            }
            
            
        } failure:^(NSError *error) {
            
        }];
        
    }else
    {
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要去登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [view show];
    }
 
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag==666)
    {
        if (buttonIndex==1)
        {
            if (self.deleteArray.count>=1)
            {
                [self deleteRequest:self.deleteArray];
                [quanxuanDownview removeFromSuperview];
                
            }else
            {
                [WBYRequest showMessage:@"请选择被保人"];
            }
        }
    }else if (alertView.tag==888)
    {
        
        if (buttonIndex==1)
        {
            
            [self deleteRequest:[NSMutableArray arrayWithObject:shanchumod.id?shanchumod.id:@""]];
 
        }        
        
    }else
    {
        if (buttonIndex==1)
        {
            [self goLogin];
            
        }else
        {
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }
}

#pragma mark====代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        NSString * key = _firstArr[section];
        return [[self.dic objectForKey:key] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        return _firstArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
   WodebaodanceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.tintColor = wRedColor;
    if (_firstArr.count>=1)
    {
        NSString * key = _firstArr[indexPath.section];
        NSArray * arry = [self.dic objectForKey:key];
        DataModel * mod = arry[indexPath.row];
        
        [cell.myImg sd_setImageWithURL:[NSURL URLWithString:mod.avatar] placeholderImage:[UIImage imageNamed:@"city"]];
        cell.upLab.text = mod.name?mod.name:@"暂无";
        cell.downLab.text = mod.birthday.length>=1?[WBYRequest timeStr:mod.birthday]:@"2016-08-08";
        
        cell.sexLab.text = [mod.sex isEqualToString:@"1"]?@"男":@"女";
        cell.kehu.text = mod.relation_name?mod.relation_name:@"暂无";
        cell.tag = 50 + 100*indexPath.section +indexPath.row;
        
        longpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(changan:)];
        
        [cell addGestureRecognizer:longpress];

    }
        return cell;
}

#pragma mark===删除
-(void)changan:(UILongPressGestureRecognizer*)longp
{
 
//    cell.tag = 50 + 100*indexPath.section +indexPath.row;

    UITableViewCell * cell = (UITableViewCell *)longp.view;
    
    
    if ([longp state] == UIGestureRecognizerStateBegan)
    {
        changanTag = cell.tag;
        
        NSIndexPath * indexPath = [gongsiTab indexPathForCell:cell];
        
        
        NSString * key = _firstArr[indexPath.section];
        NSArray * arry = [self.dic objectForKey:key];
        
        DataModel * mod = arry[indexPath.row];

        shanchumod = mod;
        [XuanXIngBie showWithTitle:@"请选择编辑或者删除" titles:@[@"编辑",@"删除"] selectIndex:^(NSInteger selectIndex)
         {
             if (selectIndex==0)
             {
                 
                 XiuGaiViewController * xiugai = [XiuGaiViewController new];
                 
                 xiugai.aModel = mod;
                 xiugai.xiugaiNumber = 666;
                 
                 [self.navigationController pushViewController:xiugai animated:YES];
                 
             }else
             {
                 UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要删除被保人" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                 view.tag = 888;
                 
                 [view show];
                 
                 
             }
             
         } selectValue:^(NSString *selectValue) {
             
         } showCloseButton:YES];
     }
    
}




- (void)indexSelectionDidChange:(CMIndexBar *)indexBar index:(NSInteger)index title:(NSString *)title
{
    
    if ([_firstArr containsObject:title])
    {
    NSInteger aaa = [_firstArr indexOfObject:title];
  
      [gongsiTab scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:aaa] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
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
    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (gongsiTab.editing==YES)
    {
        NSString * key = _firstArr[indexPath.section];
        NSArray * arry = [self.dic objectForKey:key];
        DataModel * mod = arry[indexPath.row];
        [self.deleteArray addObject:mod.id];
    }else
    {
        NSString * key = _firstArr[indexPath.section];
        NSArray * arry = [self.dic objectForKey:key];
        DataModel * mod = arry[indexPath.row];

        if ([_tijian isEqualToString:@"tijian"]&&mod)
        {
            _tijianBlock(mod);
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            BaodangerenViewController * baodan = [BaodangerenViewController new];
            baodan.name = mod.name;
            baodan.beibaoId = mod.id;
            
            [self.navigationController pushViewController:baodan animated:YES];            
        }
        
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (gongsiTab.editing==YES&&![_tijian isEqualToString:@"tijian"])
    {
        NSString * key = _firstArr[indexPath.section];
        NSArray * arry = [self.dic objectForKey:key];
        DataModel * mod = arry[indexPath.row];
        [self.deleteArray removeObject:mod.id];
    }
    
    
    
    
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
