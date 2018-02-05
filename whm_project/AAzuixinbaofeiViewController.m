//
//  AAzuixinbaofeiViewController.m
//  whm_project
//
//  Created by apple on 17/4/5.
//  Copyright © 2017年 chenJw. All rights reserved.

#import "AAzuixinbaofeiViewController.h"
#import "WBYbaofeiTableViewCell.h"
#import "AAbaoffTableViewCell.h"
#import "SelectAlert.h"


@interface AAzuixinbaofeiViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * myTab;
    NSArray * allArr;
    NSArray * coluArr;
    NSArray * downvalArr;
    NSMutableDictionary * mydic;
    NSMutableArray * sectionAry;
    
    NSArray * groupsArray;
    
    BOOL isGroups;
}
@end

@implementation AAzuixinbaofeiViewController
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.title = @"保费测算";
    allArr = [NSArray array];
    coluArr = [NSArray array];
    
    downvalArr = [NSArray array];
    mydic = [NSMutableDictionary dictionary];
    
    sectionAry = [NSMutableArray array];
    groupsArray = [NSArray array];
    [self requestAllData];
    [self liaanniu];
}
-(void)requestAllData
{
    WS(weakSelf);
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:_aamyModel.id?_aamyModel.id:@"" forKey:@"pid"];
    
    [WBYRequest wbyPostRequestDataUrl:@"guess_ret" addParameters:dic success:^(WBYReqModel *model)
    {
        if ([model.err isEqualToString:TURE])
        {
            allArr = model.data;
            DataModel * daModel = [allArr firstObject];
            WBYMongo_rataModel * mongoModel = [daModel.rate firstObject];
            coluArr = mongoModel.columns;
            groupsArray = daModel.groups;
            downvalArr = daModel.interets;
            
            if (groupsArray.count>=1)
            {
                isGroups = YES;
                for (int i = 0; i<groupsArray.count; i++)
                {
                    [sectionAry addObject:@NO];
                }
                
            }else
            {
                isGroups = NO;
                for (int i = 0; i<downvalArr.count; i++)
                {
                    [sectionAry addObject:@NO];
                }

            }
                          [weakSelf creatUI];
            
        }
    } failure:^(NSError *error) {
        
    } isRefresh:YES];
    
    
}

-(void)creatUI
{
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, wScreenW, wScreenH - 64) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    myTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [myTab registerClass:[WBYbaofeiTableViewCell class] forCellReuseIdentifier:@"cell"];
    [myTab registerClass:[AAbaoffTableViewCell class] forCellReuseIdentifier:@"acell"];
    [self.view addSubview:myTab];
    
    [myTab setSeparatorInset:UIEdgeInsetsZero];
    [myTab setLayoutMargins:UIEdgeInsetsZero];
    
    
    myTab.tableFooterView = [[UIView alloc] init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isGroups==YES)
    {
        if (indexPath.section==0)
        {
            return HANGGAO;
            
            
        }else
        {
            
            WwwGroupsModel * wwModel = groupsArray[indexPath.section-1];
            
            WBYInsured * myMod =[wwModel.interets firstObject];
            return [WBYRequest getAutoHeightForString:[NSString stringWithFormat:@"   %@", myMod.content] withWidth:wScreenW-20 withFontSize:15]+20;
        }
        
        
    }else
    {
        if (indexPath.section==0)
        {
            return HANGGAO;
            
        }else if (indexPath.section==1)
        {
            return 0.000000000001;
        }else
        {
            
                WBYInsured * myMod = downvalArr[indexPath.section-2];
                
                return [WBYRequest getAutoHeightForString:[NSString stringWithFormat:@"   %@", myMod.content] withWidth:wScreenW-20 withFontSize:15]+20;
            
        }
    }
  }

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (isGroups==YES)
    {
        return 1 + groupsArray.count;
  
    }else
    {
        return 2 + downvalArr.count;
   
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section==0)
    {
        return 0;
    }else
    {
        return HANGGAO;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * myView;
    UILabel * uplab;
    UIButton * bigBtn;
    UILabel * midLab;
    UILabel * rLab;
    UIImageView * rImg;
    UIImageView * lImg;

    
    UILabel * dowLab;
    
    if (isGroups==YES)
    {
        if (section==0)
        {
            return nil;
        }else
        {
            WwwGroupsModel * model = groupsArray[section-1];
            
            CGFloat hh = HANGGAO;
            if (!myView)
            {
                myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, hh)];
                myView.backgroundColor = wWhiteColor;
                
                bigBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                bigBtn.frame = CGRectMake(0,0, wScreenW, hh);
                bigBtn.tag = section+250;
                [bigBtn addTarget:self action:@selector(dianjikai:) forControlEvents:UIControlEventTouchUpInside];
                [myView addSubview:bigBtn];
                
                dowLab = [[UILabel alloc] initWithFrame:CGRectMake(0, hh-0.5, wScreenW, 0.5)];
//                dowLab.backgroundColor = wGrayColor;
                [bigBtn addSubview:dowLab];
                
                
                midLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, wScreenW-90, HANGGAO)];
                midLab.textColor = ZTCOlor;
//                midLab.numberOfLines = 0;
                
                [bigBtn addSubview:midLab];
                
                lImg = [[UIImageView alloc] initWithFrame:CGRectMake(wScreenW-30-20-20, 15, 30, 30)];
                
                if ([model.is_main isEqualToString:@"1"])
                {
                    lImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e618", 20, SHENLANSEcolor)];
                }
                else if ([model.is_main isEqualToString:@"2"])
                {
                    lImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61e", 20, wRedColor)];
                }
                else
                {
                    lImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61a", 20,ZuoHeXianColour)];
                }
                

                
                [bigBtn addSubview:lImg];
                rLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,wScreenW, 0.5)];
//                rLab.font = ZT14;
//                rLab.tag = 1000 + section;
//                rLab.textColor = ZTCOlor;
//                rLab.textAlignment = 2;
                rLab.backgroundColor = ZTCOlor;
                [bigBtn addSubview:rLab]; 
                
                rImg = [[UIImageView alloc]initWithFrame:CGRectMake(wScreenW -20-10, 20, 20, 20)];
                rImg.tag = 500+section;
                
                if ([sectionAry[section-1] boolValue]==NO)
                {
                    rImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e616",20, wBlackColor)];
                    
                }else
                {
                    rImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e617",20, wBlackColor)];
                }
                
                [bigBtn addSubview:rImg];
            }
            
            midLab.font = Font(18);

            midLab.text =[NSString stringWithFormat:@"%@",model.short_name];
            
            return myView;
  
            
            
        }
        
    }else
    {
        if (section==0)
        {
            return nil;
        }
        else if (section==1)
        {
            if (!uplab)
            {
                uplab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, wScreenW, HANGGAO)];
                uplab.backgroundColor = wBaseColor;
                uplab.textColor = wBlackColor;
                uplab.font = daFont;
            }
            uplab.text = @"    保险责任";
            return uplab;
        }else
        {
            WBYInsured * model = downvalArr[section-2];
            
            CGFloat hh = HANGGAO;
            if (!myView)
            {
                myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, hh)];
                myView.backgroundColor = wWhiteColor;
                
                bigBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                bigBtn.frame = CGRectMake(0,0, wScreenW, hh);
                bigBtn.tag = section+250;
                [bigBtn addTarget:self action:@selector(dianjikai:) forControlEvents:UIControlEventTouchUpInside];
                [myView addSubview:bigBtn];
                
                dowLab = [[UILabel alloc] initWithFrame:CGRectMake(0, hh-0.5, wScreenW, 0.5)];
                dowLab.backgroundColor = wGrayColor;
                
                [bigBtn addSubview:dowLab];
                
                
                midLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, wScreenW/2, HANGGAO)];
                midLab.font = zhongFont;
                midLab.textColor = wBlackColor;
                midLab.numberOfLines = 0;
                
                [bigBtn addSubview:midLab];
                
                rLab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW/2, 0,wScreenW/2-30-10, HANGGAO)];
               
                rLab.tag = 1000 + section;
                rLab.textColor = ZTCOlor;
                rLab.textAlignment = 2;
                rLab.numberOfLines = 0;
                rLab.font = zhongFont;
                [bigBtn addSubview:rLab];
                
                rImg = [[UIImageView alloc]initWithFrame:CGRectMake(wScreenW -20-10, 20, 20, 20)];
                rImg.tag = 500+section;
                
                if ([sectionAry[section-2] boolValue]==NO)
                {
                    rImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e616",20, wBlackColor)];
                    
                }else
                {
                    rImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e617",20, wBlackColor)];
                }
                
                [bigBtn addSubview:rImg];
            }
            midLab.text =[NSString stringWithFormat:@"   %@",model.name];
            rLab.text =[NSString stringWithFormat:@"   %@",model.show];
            return myView;
        }
  
        
    }
    
   }

-(void)dianjikai:(UIButton*)btn
{
    btn.selected = !btn.selected;
    NSInteger newTag;
    
    
    if (isGroups==YES)
    {
         newTag = btn.tag - 250-1;
   
    }else
    {
        newTag = btn.tag - 250-2;
   
    }
    
    // 改变你点击的那个区的值,替换数组响应位置的值就可以了
    [sectionAry replaceObjectAtIndex:newTag withObject:@(![sectionAry[newTag] boolValue])];
//    mySection = btn.tag;
    
    
    [myTab reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isGroups==YES)
    {
        if (section==0)
        {
            return coluArr.count;
            
        }else
        {
            if ([sectionAry[section-1] boolValue])
            {
                
                return 1;
            }else
            {
                
                return 0;
            }
        }
   
        
        
    }else
    {
        if (section==0)
        {
            return coluArr.count;
            
        }else if (section==1)
        {
            return 0;
        }else
        {
            if ([sectionAry[section-2] boolValue])
            {
                
                return 1;
            }else
            {
                
                return 0;
            }
        }
    
        
    }
    
    
 }

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (isGroups==YES)
    {
        if (indexPath.section==0&&coluArr.count>=1)
        {
            WBYaaColumnsModel * colModel = coluArr[indexPath.row];
            
            WBYbaofeiTableViewCell * aCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            
            aCell.selectionStyle = UITableViewCellSelectionStyleNone;
            aCell.lLab.text = colModel.name;
            aCell.lLab.textColor = wBlackColor;
            aCell.lLab.font = daFont;
            
            aCell.Rlab.textAlignment = NSTextAlignmentRight;
            aCell.lLab.tag = 666 + indexPath.row;
            aCell.Rlab.tag = 110 + indexPath.row;
            aCell.Rlab.enabled = NO;
            aCell.Rlab.placeholder = @"请选择";
            aCell.Rlab.font = daFont;
            
            [aCell.Rlab setValue:daFont forKeyPath:@"_placeholderLabel.font"];
            
            if (indexPath.row==coluArr.count-1)
            {
                aCell.accessoryType=UITableViewCellAccessoryNone;
            }else{
                aCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }
            return aCell;
            
        }
        else
        {
            WwwGroupsModel * wwModel = groupsArray[indexPath.section-1];
            
            WBYInsured * myMod =[wwModel.interets firstObject];
            

//            WBYInsured * myMod = groupsArray[indexPath.section-1];
            
            AAbaoffTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"acell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = wBaseColor;
            cell.nameLabel.backgroundColor = wBaseColor;
            cell.nameLabel.textColor = QIANZITIcolor;
            [cell setModel:myMod];
            return cell;
        }
        
    
        
        
    }else
    {
        if (indexPath.section==0&&coluArr.count>=1)
        {
            WBYaaColumnsModel * colModel = coluArr[indexPath.row];
            
            WBYbaofeiTableViewCell * aCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            
            aCell.selectionStyle = UITableViewCellSelectionStyleNone;
            aCell.lLab.text = colModel.name;
            aCell.lLab.textColor = wBlackColor;
            aCell.lLab.font = daFont;
            
            aCell.Rlab.textAlignment = NSTextAlignmentRight;
            aCell.lLab.tag = 666 + indexPath.row;
            aCell.Rlab.tag = 110 + indexPath.row;
            aCell.Rlab.enabled = NO;
            aCell.Rlab.placeholder = @"请选择";
            
            [aCell.Rlab setValue:newFont(14) forKeyPath:@"_placeholderLabel.font"];
            
            if (indexPath.row==coluArr.count-1)
            {
                aCell.accessoryType=UITableViewCellAccessoryNone;
            }else{
                aCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }
            return aCell;
            
        }else if (indexPath.section==1)
        {
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cccc"];
            
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cccc"];
            }
            
            return cell;
        }else
        {
            WBYInsured * myMod = downvalArr[indexPath.section-2];
            
            AAbaoffTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"acell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = wBaseColor;
            cell.nameLabel.backgroundColor = wBaseColor;
            cell.nameLabel.textColor = QIANZITIcolor;
//            cell.nameLabel.font = daFont;

            [cell setModel:myMod];
            return cell;
        }
        
    
        
    }
    
    
   }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        UITextField * myTf = [myTab viewWithTag:110 + indexPath.row];
        UITextField * aatf = [myTab viewWithTag:110 + indexPath.row+1];
        
        WBYaaColumnsModel * colModel = coluArr[indexPath.row];      

        [mydic setObject:_aamyModel.id?_aamyModel.id:@"" forKey:@"pid"];
        
        [mydic setObject:@"1" forKey:@"guess"];
        
        
        NSMutableArray * myMarr = [NSMutableArray array];
        
        for (WBYaaColumnsModel * colModel in coluArr)
        {
            [myMarr addObject:colModel.en];
        }        
        if ([myMarr containsObject:@"input_num"])
        {
            if ([colModel.en isEqualToString:@"gender"])
            {
                [SelectAlert showWithTitle:@"请选择" titles:@[@"男",@"女"] selectIndex:^(NSInteger selectIndex)
                 {
                 } selectValue:^(NSString *selectValue)
                 {
                     if ([selectValue isEqualToString:@"男"])
                     {
                         [mydic setObject:@"1" forKey:@"gender"];
                     }else
                     {
                         [mydic setObject:@"0" forKey:@"gender"];
                     }
                     myTf.text = selectValue;
                 } showCloseButton:NO];
                
            }else if ([colModel.en isEqualToString:@"input_num"])
            {
                for (NSInteger i=0;i<coluArr.count-2;i++)
                {
                    UITextField * tf = [myTab viewWithTag:110+i];
                    if (tf.text.length<1)
                    {
                        [WBYRequest showMessage:@"数据不完整"];
                        return;
                    }
                }
                        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"请输入保额" message:nil preferredStyle:UIAlertControllerStyleAlert];
                        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField)
                         {
                             textField.keyboardType = UIKeyboardTypeNumberPad;
                             textField.placeholder = @"请输入保额";
                         }];
                        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                        
                        UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                            myTf.text =[NSString stringWithFormat:@"%@元",alertController.textFields.firstObject.text];
                            if ([myTf.text floatValue]<=0)
                            {
                                [WBYRequest showMessage:@"请输入保险金额"];
                                return ;
                            }else{
                                
                                [mydic setObject:alertController.textFields.firstObject.text forKey:colModel.en];
                                
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
                                         //                            AAinterestsModel * amod= mod.interests
                                         
                                         for (NSInteger i = 0; i<mod.interests.count; i++)
                                         {
                                             
//                                             isOpen[i]=YES;
                                             
                                             AAinterestsModel * amod= mod.interests[i];
                                             
                                             UILabel * lab = [myTab viewWithTag:1000+i+2];
                                             
                                             lab.text = amod.show?amod.show:@"暂无";
                                         }
                                     }else{
                                         
                                         
                                         myTf.text = @"";
                                         [WBYRequest showMessage:model.info];
                                     }
                                 } failure:^(NSError *error) {
                                     
                                 } isRefresh:YES];
                            }
                        }];
                        [alertController addAction:cancelAction];
                        [alertController addAction:archiveAction];
                        [self presentViewController:alertController animated:YES completion:nil];
                
            }else if([colModel.en isEqualToString:@"ret_num"])
            {
                myTf.enabled = NO;
                
            }else if ([colModel.en isEqualToString:@"age"])
            {
                NSMutableArray * myaa = [NSMutableArray arrayWithArray:colModel.vals];
                NSArray * paixuaa = [WBYRequest paixuArr:myaa];
                NSString * att = [paixuaa componentsJoinedByString:@","];
                
                [SelectAlert showWithTitle:@"请选择" titles:[att componentsSeparatedByString:@","] selectIndex:^(NSInteger selectIndex)
                 {
                 } selectValue:^(NSString *selectValue)
                 {
                     myTf.text = selectValue;
                     [mydic setObject:selectValue forKey:colModel.en];
                 } showCloseButton:NO];
  
                
                
            }
            else
            {
                NSString *string = [colModel.vals componentsJoinedByString:@","];
                [SelectAlert showWithTitle:@"请选择" titles:[string componentsSeparatedByString:@","] selectIndex:^(NSInteger selectIndex)
                 {
                 } selectValue:^(NSString *selectValue)
                 {
                     myTf.text = selectValue;
                     [mydic setObject:selectValue forKey:colModel.en];
                 } showCloseButton:NO];
            }
        }else
        {
            if([colModel.en isEqualToString:@"ret_num"])
            {
                myTf.enabled = NO;
                for (NSInteger i=0;i<coluArr.count-2;i++)
                {
                    UITextField * tf = [myTab viewWithTag:110+i];
                    
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
                         
                         for (NSInteger i = 0; i<mod.interests.count; i++)
                         {
                             AAinterestsModel * amod= mod.interests[i];
                             UILabel * lab = [myTab viewWithTag:1000+i+2];
                             
                             lab.text = amod.show;
                         }
                         
                     }else{
                         [WBYRequest showMessage:model.info];
                     }
                 } failure:^(NSError *error) {
                     
                 } isRefresh:YES];
     
            }else if ([colModel.en isEqualToString:@"gender"])
            {
                [SelectAlert showWithTitle:@"请选择" titles:@[@"男",@"女"] selectIndex:^(NSInteger selectIndex)
                 {
                 } selectValue:^(NSString *selectValue)
                 {
                     if ([selectValue isEqualToString:@"男"])
                     {
                         [mydic setObject:@"1" forKey:@"gender"];
                         
                     }else
                     {
                         [mydic setObject:@"0" forKey:@"gender"];
                     }
                     myTf.text = selectValue;
                 } showCloseButton:NO];
                
            }else
            {
                NSString *string = [colModel.vals componentsJoinedByString:@","];
                [SelectAlert showWithTitle:@"请选择" titles:[string componentsSeparatedByString:@","] selectIndex:^(NSInteger selectIndex)
                 {
                 } selectValue:^(NSString *selectValue)
                 {
                     myTf.text = selectValue;
                     [mydic setObject:selectValue forKey:colModel.en];
                 } showCloseButton:NO];
            }
        }
 
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
