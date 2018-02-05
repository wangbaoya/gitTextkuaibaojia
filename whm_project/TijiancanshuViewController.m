//
//  TijiancanshuViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TijiancanshuViewController.h"
#import "xingaiTableViewCell.h"
#import "TijianHeaderview.h"
#import "SelectAlert.h"
#import "ZMFloatButton.h"
#import "TianjiaxinxianzhongViewController.h"
#import "TijianbaogaoViewController.h"

#import "DEInfiniteTileMarqueeView.h"

#import "XiuGaiViewController.h"
#import "WoDeBaoDanViewController.h"

@interface TijiancanshuViewController ()<UITableViewDelegate,UITableViewDataSource,ZMFloatButtonDelegate>
{
    NSMutableArray * allArray;
    UITableView * myTab;
    
    NSMutableDictionary * mydic;
    NSMutableArray * panduanArr;
    
    NSMutableDictionary * xiaoDic;
//    NSMutableDictionary * daDic;
    
    NSMutableArray * dashangchuanArray;
    
    NSMutableDictionary * xiaoshangchuanDic;
    
    NSInteger shanDaShangchuan;

    NSUserDefaults * standUser;
    UIButton * touxiangImg;
    BOOL isOpen[2];
    
    UILongPressGestureRecognizer * longpress;
//    TijianHeaderview * haadView;
    NSInteger changandeBtn;
    ZMFloatButton * floatBtn;
    DEInfiniteTileMarqueeView *leftMarquee;

    DataModel * baodanModel;
}




@end

@implementation TijiancanshuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"保单体检";
    allArray = [NSMutableArray array];
    
    panduanArr = [NSMutableArray array];
    
    mydic = [NSMutableDictionary dictionary];
    
    xiaoDic = [NSMutableDictionary dictionary];
//    daDic = [NSMutableDictionary dictionary];
    
    dashangchuanArray = [NSMutableArray array];
    xiaoshangchuanDic = [NSMutableDictionary dictionary];
    shanDaShangchuan = 0;
    
    [self requestData];
    [self creatLeftTtem];
    

    standUser = [NSUserDefaults standardUserDefaults];
    
    for (NSInteger i=0; i<10; i++)
    {
        [standUser removeObjectForKey:[NSString stringWithFormat:@"%ldaaa",(long)i]];
    }
   
    for (NSInteger i=0; i<10; i++)
    {
        [standUser removeObjectForKey:[NSString stringWithFormat:@"%ldccc",(long)i]];
    }
    
    if (_beibaoid.length>=1)
    {
        [standUser setObject:_beibaoid?_beibaoid:@"" forKey:@"beibaorenid"];
   
    }
    
    if (_aImg.length>=1)
    {
        [standUser setObject:_aImg?_aImg:@"" forKey:@"beibaorentupian"];
        
    }
    
  
    [standUser synchronize];
    [self creatView];

     longpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(changan:)];

 }

-(void)huadongbutton
{
    floatBtn = [[ZMFloatButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-40-15,wScreenH-64-40-30-45, 40, 40)];
    floatBtn.delegate = self;
    //floatBtn.isMoving = NO;
    
    floatBtn.bannerIV.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e680", 50, SHENLANSEcolor)];
    
    [self.view addSubview:floatBtn];
    [self.view bringSubviewToFront:floatBtn];
    
}
#pragma mark--添加险种
- (void)floatTapAction:(ZMFloatButton *)sender
{
    WS(weakSelf);
    //点击执行事件
    TianjiaxinxianzhongViewController * tianjia = [TianjiaxinxianzhongViewController new];
    
    tianjia.tianjiaXianzgong = _xianzhongs;
    
    tianjia.xianzhongBlock = ^(NSString * str)
    {
        NSLog(@"===%@",str);
       weakSelf.xianzhongs = [NSString stringWithFormat:@"%@",str];
        
        
        [weakSelf requestData];
        
        
    };
    
    [self.navigationController pushViewController:tianjia animated:YES];
    
}
-(void)requestData
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:_xianzhongs?_xianzhongs:@"" forKey:@"pids"];
    [dic setObject:_sex?_sex:@"" forKey:@"gender"];
    [WBYRequest wbyLoginPostRequestDataUrl:@"test_rate" addParameters:dic success:^(WBYReqModel *model)
     {
//         [allArray removeAllObjects];
//         
//         if (allArray.count)
//         {
//             
//         }
         
         if ([model.err isEqualToString:TURE])
         {
             
             [allArray addObjectsFromArray:model.data];
             
         }else
         {
             [WBYRequest showMessage:model.info];
         }
         
         
         
         
         
         [myTab reloadData];
     } failure:^(NSError *error) {
         
     }];
    
}



-(void)creatView
{
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, wScreenW,136.5)];
    img.image = [UIImage imageNamed:@"bandan"];
    
    img.userInteractionEnabled = YES;
    [self.view addSubview:img];
    
    
    
     touxiangImg = [[UIButton alloc] initWithFrame:CGRectMake(wScreenW/2-35, (273/2-70)/2, 70, 70)];
    
    touxiangImg.layer.masksToBounds = YES;
    touxiangImg.layer.cornerRadius = 35;
    
    
    [touxiangImg sd_setImageWithURL:[NSURL URLWithString:[standUser objectForKey:@"beibaorentupian"]] forState:UIControlStateNormal placeholderImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e62e", 70, wWhiteColor)]];
    
    [touxiangImg addTarget:self action:@selector(huantouxiang) forControlEvents:UIControlEventTouchUpInside];
    
    [img addSubview:touxiangImg];
    
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(img.frame), wScreenW, wScreenH - 64-136.5-45) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    myTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    myTab.separatorColor = FENGEXIANcolor;
    
    [myTab registerClass:[xingaiTableViewCell class] forCellReuseIdentifier:@"cell"];
    myTab.tableFooterView = [[UIView alloc] init];
    [myTab setSeparatorInset:UIEdgeInsetsZero];
    [myTab setLayoutMargins:UIEdgeInsetsZero];
    [self.view addSubview:myTab];

    
  UIButton * downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    downBtn.frame = CGRectMake(0,wScreenH-64-45, wScreenW,45);
    downBtn.backgroundColor = SHENLANSEcolor;
    [downBtn setTitleColor:wWhiteColor forState:UIControlStateNormal];
    [downBtn setTitle:@"开始体检" forState:UIControlStateNormal];
    downBtn.titleLabel.font = Font(18);
    [downBtn addTarget:self action:@selector(dianjitijian) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:downBtn];
    
    [self huadongbutton];

}

-(void)huantouxiang
{
    
//    [self beibaorenqingqiu];
    
    WoDeBaoDanViewController * bandan = [WoDeBaoDanViewController new];
    bandan.tijian = @"tijian";
    
    bandan.tijianBlock = ^(DataModel * mod)
    {
        
        
        baodanModel = mod;
        
        [touxiangImg sd_setImageWithURL:[NSURL URLWithString:mod.avatar] forState:UIControlStateNormal placeholderImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e62e", 70, wWhiteColor)]];
        
        
//        dijige = @"2";
//        beibaorenSex = mod.sex;
//        beibaorenId = mod.id;
//        myimgs = mod.avatar;
//        
//        Amodel = mod;
//        lab1.textColor = wBlackColor;
//        lab2.textColor = wBlackColor;
//        lab3.textColor = QIANZITIcolor;
//        
//        alab1.textColor = SHENLANSEcolor;
//        alab2.textColor = SHENLANSEcolor;
//        alab3.textColor = SHENLANSEcolor;
        
        
    };
    [self.navigationController pushViewController:bandan animated:YES];
    
    
    
}

-(void)beibaorenqingqiu
{
    NSString * aaaaa = [standUser objectForKey:@"beibaorenid"];

    WS(weakSelf);
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setObject:aaaaa?aaaaa:@"" forKey:@"rela_id"];
    
    [WBYRequest wbyTijianPostRequestDataUrl:@"get_rela_info" addParameters:dic success:^(NSArray *amodel)
    {
    
    TijianXinXiModel * model = [amodel firstObject];
     XiuGaiViewController * xiugai = [XiuGaiViewController new];
            xiugai.xiugaiNumber = 666;
        
            xiugai.mModel = model;
        
            [weakSelf.navigationController pushViewController:xiugai animated:YES];
        
     } failure:^(NSError *aerror) {
        
    }];
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HANGGAO;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HANGGAO;
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  TijianHeaderview *  haadView =[[TijianHeaderview alloc]initWithFrame:CGRectMake(0, 0, wScreenW, HANGGAO)];
//    haadView.tag = 333+section;
    
    if (allArray.count>=1)
    {
        DataModel * model = allArray[section];
        
        
        if ([model.is_main isEqualToString:@"1"])
        {
            haadView.lImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e618", 30, SHENLANSEcolor)];
        }
        else if ([model.is_main isEqualToString:@"2"])
        {
             haadView.lImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61e", 30, wRedColor)];
        }
        else
        {
             haadView.lImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61a", 30,ZuoHeXianColour)];
        }
        
        
        haadView.midLabel.text = model.name?model.name:model.short_name;

        [haadView.listHeaderBtn addTarget:self action:@selector(dakai:) forControlEvents:UIControlEventTouchUpInside];
        
        haadView.listHeaderBtn.tag = section;
        
        
        if (isOpen[section]==YES)
       {
           haadView.rimg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e616",20, wBlackColor)];
        }else
        {
            haadView.rimg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e617",20, wBlackColor)];
        }
    }
    
   
//    longpress.delegate = self;
    
    [haadView.listHeaderBtn addGestureRecognizer:longpress];
    

    
    return haadView;
}

#pragma mark===删除
-(void)changan:(UILongPressGestureRecognizer*)longp
{
    
    UIButton * btn = (UIButton *)longp.view;
    
      if ([longp state] == UIGestureRecognizerStateBegan)
      {
    
    UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要删除这个险种" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
          changandeBtn = btn.tag;
    
          [view show];
 
      }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==1)
    {
        [leftMarquee removeFromSuperview];

        if (allArray.count>=1)
        {
            NSArray * myaaa = [_xianzhongs componentsSeparatedByString:@","];
            
            NSMutableArray * xianzhArr = [NSMutableArray arrayWithArray:myaaa];
            
            [xianzhArr removeObjectAtIndex:changandeBtn];
            
            _xianzhongs = [xianzhArr componentsJoinedByString:@","];
            
            [allArray removeObjectAtIndex:changandeBtn];
            [standUser removeObjectForKey:[NSString stringWithFormat:@"%ldaaa",(long)changandeBtn]];
            
            [standUser removeObjectForKey:[NSString stringWithFormat:@"%ldccc",(long)changandeBtn]];
            
            [myTab reloadData];
            
            if (allArray.count<1)
            {
//                [WBYRequest showMessage:@"请添加险种"];
//                floatBtn.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1);
                
                [UIView animateWithDuration:0.8 animations:^{
                    
                     floatBtn.center  = CGPointMake(wScreenW/2, (wScreenH-64-49)/2);
                } completion:^(BOOL finished) {
                    
                    [UIView animateWithDuration:0.5 animations:^{
                        
                         floatBtn.center  = CGPointMake(wScreenW/2, (wScreenH-64-49)/2-30);
                        
                    } completion:^(BOOL finished) {
                        
                        [UIView animateWithDuration:0.5 animations:^{
                            
                          floatBtn.center  = CGPointMake(wScreenW/2, (wScreenH-64-49)/2+30);
                        } completion:^(BOOL finished) {
                            
                            
                            [UIView animateWithDuration:0.6 animations:^{
                                
                                floatBtn.layer.transform = CATransform3DMakeScale(4, 4, 4);
                                
                            } completion:^(BOOL finished) {
                                
                                [UIView animateWithDuration:0.6 animations:^{
                                    
                                    floatBtn.layer.transform = CATransform3DMakeScale(1, 1, 1);
                                    
                                } completion:^(BOOL finished) {
                                    
//                                    [UIView animateWithDuration:0.6 animations:^{
//                                        
//                                        floatBtn.layer.transform = CATransform3DMakeScale(1, 1, 1);
//                                        
//                                    } completion:^(BOOL finished) {
//                                    }];
                                    
                                }];
                            }];
                            

                            
                            
                        }];

                        
                    }];
  
                    
                }];
                
            }
            
            
            
        }else
        {
            
        }
        
        
        
    }
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
}

-(void)dealloc
{
    
   
  
    
}



-(void)dakai:(UIButton*)btn
{
    isOpen[btn.tag] = !isOpen[btn.tag];
    [myTab reloadData];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return allArray.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (allArray.count>=1)
    {
        DataModel * model = allArray[section];
        WBYMongo_rataModel * rateModel = [model.rate firstObject];
        
        if (isOpen[section]==YES)
        {
            return 0;
        }else
        {
            return rateModel.columns.count;
        }
    }else
    {
        
        return 0;
    }
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    xingaiTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (allArray.count>=1)
    {
        DataModel * model = allArray[indexPath.section];
        WBYMongo_rataModel * rateModel = [model.rate firstObject];
        WBYaaColumnsModel * colModel = rateModel.columns[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.midLab.text = colModel.name;
        cell.rText.placeholder = @"请选择";
        cell.rText.enabled = NO;
        cell.rText.tag = 110 + 50*indexPath.section + indexPath.row;
        cell.rText.text =@"";
        
//      NSMutableDictionary * dic = [daDic objectForKey:[NSString stringWithFormat:@"%ldaaa",indexPath.section]];
     NSMutableDictionary * aadic = [standUser objectForKey:[NSString stringWithFormat:@"%ldaaa",(long)indexPath.section]];
        
//         NSMutableDictionary * aadic1 = [stad objectForKey:[NSString stringWithFormat:@"%daaa",0]];
//        
//         NSMutableDictionary * aadic2 = [stad objectForKey:[NSString stringWithFormat:@"%daaa",1]];
//        NSLog(@"====%@===%@",aadic1,aadic2);
        for (NSString * str in aadic.allKeys)
        {
            if ([str isEqualToString:colModel.en])
            {
                cell.rText.text = [aadic objectForKey:str];
            }
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    DataModel * model = allArray[indexPath.section];
    WBYMongo_rataModel * rateModel = [model.rate firstObject];
    WBYaaColumnsModel * colModel = rateModel.columns[indexPath.row];

    UITextField * myTf = [self.view viewWithTag:110 + indexPath.row + 50*indexPath.section];
    UITextField * aatf = [self.view viewWithTag:110 + indexPath.row + 1 + 50*indexPath.section];
    
    [mydic setObject:model.id?model.id:@"" forKey:@"pid"];
    [mydic setObject:@"0" forKey:@"guess"];
    
    [xiaoshangchuanDic setObject:model.id?model.id:@"" forKey:@"pid"];

    [panduanArr removeAllObjects];
    
    for (WBYaaColumnsModel * colModel in rateModel.columns)
    {
        [panduanArr addObject:colModel.en];
    }

    if ([panduanArr containsObject:@"input_num"])
    {
        if ([colModel.en isEqualToString:@"input_num"])
        {
            for (NSInteger i=0; i<indexPath.row; i++)
            {
                UITextField * tf = [self.view viewWithTag:110+50*indexPath.section+i];
                
                if (tf.text.length<1)
                {
                    [WBYRequest showMessage:@"数据不完整"];
                    return;
                }
            }
            
            
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"请输入保额" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField)
             {
                 
                 [textField addTarget:self action:@selector(baoershuru:) forControlEvents:UIControlEventEditingChanged];
                 
                 textField.keyboardType = UIKeyboardTypeNumberPad;
                 textField.placeholder = @"请输入保额";
             }];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            
            UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                            {
   myTf.text =[NSString stringWithFormat:@"%@元",alertController.textFields.firstObject.text];
 if ([myTf.text floatValue]<=0)
   {
  [WBYRequest showMessage:@"请输入保险金额"];
   return;
   }else{
       
    [mydic setObject:alertController.textFields.firstObject.text forKey:colModel.en];
[xiaoDic setObject:alertController.textFields.firstObject.text forKey:colModel.en];
                                                    //                                                    [xiaoshangchuanDic setObject:alertController.textFields.firstObject.text forKey:colModel.en];
       
    [WBYRequest wbyPostRequestDataUrl:@"rate_ret" addParameters:mydic success:^(WBYReqModel *model)
                                                     {
                                                         if ([model.err isEqualToString:TURE])
                                                         {
  DataModel * mod = [model.data firstObject];
 if ([mod.ret_num floatValue]<10000)
  {
    aatf.text = [NSString stringWithFormat:@"%.2lf 元",[mod.ret_num floatValue]];
 }else{
aatf.text = [NSString stringWithFormat:@"%.2lf 万元",[mod.ret_num floatValue]/10000];
                                                             }
[xiaoDic setObject:aatf.text?aatf.text:@"" forKey:@"ret_num"];
//[daDic setObject:xiaoDic forKey:[NSString stringWithFormat:@"%ldaaa",indexPath.section]];
 [standUser setObject:xiaoDic forKey:[NSString stringWithFormat:@"%ldaaa",(long)indexPath.section]];
                                                             
                                                             
[xiaoshangchuanDic setObject:alertController.textFields.firstObject.text forKey:colModel.en];
                                                             
[xiaoshangchuanDic setObject:mod.ret_num?mod.ret_num:@"" forKey:@"ret_num"];
                                                             
shanDaShangchuan ++;
                                                             
                                                             
//[dashangchuanArray addObject:xiaoshangchuanDic];
                                                             
[standUser setObject:xiaoshangchuanDic forKey:[NSString stringWithFormat:@"%ldccc",(long)indexPath.section]];
                                                             
                                                             
                                                             
  }else{
  myTf.text = @"";
      [WBYRequest showMessage:model.info];
                                                         }
   } failure:^(NSError *error)
                                                     {
                                                         
                                                     } isRefresh:YES];
                                                }
                                            }];
            [alertController addAction:cancelAction];
            [alertController addAction:archiveAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
            
        }else if([colModel.en isEqualToString:@"ret_num"])
        {
            myTf.enabled = NO;
            
        }else
        {
            NSString *string = [colModel.vals componentsJoinedByString:@","];
            [SelectAlert showWithTitle:@"请选择" titles:[string componentsSeparatedByString:@","] selectIndex:^(NSInteger selectIndex)
             {
             } selectValue:^(NSString *selectValue)
             {
                 myTf.text = selectValue;
                 
                 [mydic setObject:selectValue?selectValue:@"" forKey:colModel.en];
                 
                 [xiaoDic setObject:myTf.text?myTf.text:@"" forKey:colModel.en];
                 
                 [xiaoshangchuanDic setObject:myTf.text?myTf.text:@"" forKey:colModel.en];
                 
             } showCloseButton:NO];
        }
        
    }else
    {
        
        //无
        if([colModel.en isEqualToString:@"ret_num"])
        {
            myTf.enabled = NO;
            
            for (NSInteger i=0; i<indexPath.row; i++)
            {
                UITextField * tf = [self.view viewWithTag:110+50*indexPath.section+i];
                
                if (tf.text.length<1)
                {
                    [WBYRequest showMessage:@"数据不完整"];
                    return;
                }
            }
            
            [WBYRequest wbyPostRequestDataUrl:@"rate_ret" addParameters:mydic success:^(WBYReqModel *model)
             {
                 if ([model.err isEqualToString:TURE])
                 {
                     DataModel * mod = [model.data firstObject];
                     if ([mod.ret_num floatValue]<10000)
                     {
                         myTf.text = [NSString stringWithFormat:@"%.2lf 元",[mod.ret_num floatValue]];
                     }else{
                         myTf.text = [NSString stringWithFormat:@"%.2lf 万元",[mod.ret_num floatValue]/10000];
                     }
                     [xiaoDic setObject:myTf.text?myTf.text:@"" forKey:colModel.en];
//                     [daDic setObject:xiaoDic forKey:[NSString stringWithFormat:@"%ldaaa",indexPath.section]];
                     
                     [standUser setObject:xiaoDic forKey:[NSString stringWithFormat:@"%ldaaa",(long)indexPath.section]];
                     
                     [xiaoshangchuanDic setObject:mod.ret_num?mod.ret_num:@"" forKey:colModel.en];
                     
                     shanDaShangchuan ++;
                     
//        [dashangchuanArray addObject:xiaoshangchuanDic];
                     [standUser setObject:xiaoshangchuanDic forKey:[NSString stringWithFormat:@"%ldccc",(long)indexPath.section]];
                 }else{
                     myTf.text = @"";
                     [WBYRequest showMessage:model.info];
                 }
             } failure:^(NSError *error)
             {
                 
             } isRefresh:YES];
            
        }else
        {
            NSString *string = [colModel.vals componentsJoinedByString:@","];
            [SelectAlert showWithTitle:@"请选择" titles:[string componentsSeparatedByString:@","] selectIndex:^(NSInteger selectIndex)
             {
             } selectValue:^(NSString *selectValue)
             {
                 
                 myTf.text = selectValue;
                 [mydic setObject:selectValue?selectValue:@"" forKey:colModel.en];
                 [xiaoDic setObject:myTf.text?myTf.text:@"" forKey:colModel.en];
                 [xiaoshangchuanDic setObject:myTf.text?myTf.text:@"" forKey:colModel.en];
                 
             } showCloseButton:NO];
        }
    }

    
    [standUser synchronize];
    
}

-(void)baoershuru:(UITextField*)tf
{
    
    if (tf.text.length>=9)
    {
    
        tf.text = [tf.text substringToIndex:9];
        
    }
    
    
    
}


#pragma mark===开始体检
-(void)dianjitijian
{
  
    NSString * aaaaa = [standUser objectForKey:@"beibaorenid"];
    
    if (allArray.count>=1)
    {
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        
        
        if (baodanModel.id.length>=1)
        {
            [dic setObject:baodanModel.id?baodanModel.id:@"" forKey:@"rela_id"];
  
        }else
        {
            [dic setObject:aaaaa?aaaaa:@"" forKey:@"rela_id"];
            
        }
        
        
        [dashangchuanArray removeAllObjects];
        
        for (NSInteger i =0; i<allArray.count; i++)
        {
            DataModel * model = allArray[i];
            WBYMongo_rataModel * rateModel = [model.rate firstObject];
            NSMutableDictionary * aadic = [standUser objectForKey:[NSString stringWithFormat:@"%ldaaa",(long)i]];
            NSMutableDictionary * xianzh = [standUser objectForKey:[NSString stringWithFormat:@"%ldccc",(long)i]];
            
            if (rateModel.columns.count <= [aadic allKeys].count)
            {
                NSLog(@"===%ld====%ld",rateModel.columns.count,dic.allKeys.count);
            }
            else
            {
                [WBYRequest showMessage:@"数据不完整请选择"];
                return;
            }
            
            [dashangchuanArray addObject:xianzh?xianzh:@""];
            
        }
        
        WS(weakSelf);
        
        NSError * error = nil;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dashangchuanArray options:NSJSONWritingPrettyPrinted error:&error];
        NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [dic setObject:jsonString?jsonString:@"" forKey:@"pros"];
        [dic setObject:UID?UID:@"" forKey:@"uid"];
        
        [WBYRequest wbyLoginPostRequestDataUrl:@"save_policy" addParameters:dic success:^(WBYReqModel *model)
         {
             if ([model.err isEqualToString:TURE])
             {
                 TijianbaogaoViewController * baogao = [TijianbaogaoViewController new];
                 
                 baogao.isTijian = YES;
                 baogao.myarr = model.data;
                 
                 [weakSelf.navigationController pushViewController:baogao animated:YES];
             }
             
         } failure:^(NSError *error) {
             
             NSLog(@"%@",error);
             
             
         }];
    }else
    {
        [WBYRequest showMessage:@"请选择险种"];
        return;
    }
    
   }





- (NSData *)toJSONData:(id)theData{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
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
