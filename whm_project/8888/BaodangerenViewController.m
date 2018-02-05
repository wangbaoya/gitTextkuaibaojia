//
//  BaodangerenViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BaodangerenViewController.h"
#import "BaodangerenTableViewCell.h"
#import "TijianbaogaoViewController.h"

@interface BaodangerenViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton * downBtn;
    
    NSInteger shanchuid;
    
    NSInteger btn_tag;
}
@property(nonatomic,strong)UITableView * tableV;
@property(nonatomic,strong)NSMutableArray * dataArry;
@property(nonatomic,strong)NSMutableArray * selectArry;

@end

@implementation BaodangerenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"%@的保单",_name];

    [self creatLeftTtem];
    self.selectArry = [NSMutableArray array];
    self.dataArry = [NSMutableArray array];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self.selectArry removeAllObjects];
    
    
    [self requestData];
    
    
    
}
-(void)requestData
{
    WS(weakSelf);
    
    [self.selectArry removeAllObjects];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setObject:_beibaoId?_beibaoId:@"" forKey:@"rela_id"];
    
    [WBYRequest wbyLoginPostRequestDataUrl:@"get_policys" addParameters:dic success:^(WBYReqModel *model)
     {
         [weakSelf.dataArry removeAllObjects];
         [weakSelf.beijingDateView removeFromSuperview];
         
         if ([model.err isEqualToString:TURE])
         {
             [weakSelf.dataArry addObjectsFromArray:model.data];
             
             [weakSelf creatUI];
         }
         
         if (model.data.count==0)
         {
             [weakSelf wushuju];
         }
         
         [weakSelf.tableV reloadData];
    } failure:^(NSError *error) {
        
    }];
    
    
    
}

-(void)creatUI
{
    [self.tableV removeFromSuperview];
    
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH - 64-49) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
//    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableV.rowHeight = 100;
    [self.tableV registerClass:[BaodangerenTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableV];
    
    self.tableV.tableFooterView = [UIView new];
    [_tableV setSeparatorInset:UIEdgeInsetsZero];
    [_tableV setLayoutMargins:UIEdgeInsetsZero];
    
    UIView * bgview = [[UIView alloc] initWithFrame:CGRectMake(0, wScreenH-49-64,wScreenW, 49)];
    
    [self.view addSubview:bgview];
    
   
    [downBtn removeFromSuperview];
    downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    downBtn.frame = CGRectMake(0,0,wScreenW,49);
    downBtn.backgroundColor = QIANZITIcolor;
    downBtn.tag = 999;
    [downBtn setTitleColor:wWhiteColor forState:UIControlStateNormal];
      [downBtn setTitle:@"合并体检" forState:UIControlStateNormal];
    [downBtn addTarget:self action:@selector(hebingtijian) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:downBtn];
    
}

-(void)hebingtijian
{
    
    if (self.selectArry.count>=2)
    {
        [self qingwiu:[self.selectArry componentsJoinedByString:@","]];
        
    }else
    {
        [WBYRequest showMessage:@"请选择多个合并体检"];
    }
 }


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArry.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaodangerenTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArry.count>=1)
    {
        DataModel * data =self.dataArry[indexPath.row];
        AAwprosModel * model = [data.pros firstObject];
        
        if ([model.insured floatValue]<10000)
        {
            cell.baofeiLaber.text =[NSString stringWithFormat:@"保额:￥%.2lf元",[data.insured floatValue]];
        }else
        {
            cell.baofeiLaber.text =[NSString stringWithFormat:@"保额￥%.2lf万",[data.insured floatValue]/10000];
        }
        if ([model.rate floatValue]<10000)
        {
            cell.baoeLaber.text =[NSString stringWithFormat:@"保费￥%.2lf元",[data.rate_m
 floatValue]];
            
        }else
        {
            cell.baoeLaber.text =[NSString stringWithFormat:@"保费￥%.2lf万",[data.rate_m floatValue]/10000];
        }
        cell.scoreLaber.text = [ NSString stringWithFormat:@"%@ 分",data.score];//20
        cell.titLaber.text = model.pro_name?model.pro_name:@"暂无";// 泰康安享人生B款两全保险（分红型）

        [cell.selectBut setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61b", 30, QIANZITIcolor)] forState:UIControlStateNormal];
        
        [cell.selectBut setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61c", 30, wBlue)] forState:UIControlStateSelected];
        
        cell.selectBut.tag = 800+indexPath.row;
        
        [cell.selectBut addTarget:self action:@selector(dianji:) forControlEvents:UIControlEventTouchUpInside];
        
        
        cell.delBut.tag = 500+indexPath.row;
        [cell.delBut addTarget:self action:@selector(shanchu:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.lookBut.tag = 700 + indexPath.row;
        
         [cell.lookBut addTarget:self action:@selector(chakan:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return cell;
}
//删除
-(void)shanchu:(UIButton*)btn
{
    
    UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要删除险种" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [view show];

    shanchuid = btn.tag - 500;

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    WS(weakSelf);

    if (buttonIndex==1)
    {
        DataModel * data =self.dataArry[shanchuid];
        
        
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        
        [dic setObject:data.id?data.id:@"" forKey:@"mongo_id"];
        
        [WBYRequest wbyLoginPostRequestDataUrl:@"del_policy" addParameters:dic success:^(WBYReqModel *model)
         {
             [weakSelf.beijingDateView removeFromSuperview];
             
             if ([model.err isEqualToString:TURE])
             {
                 [weakSelf requestData];
             }
             [WBYRequest showMessage:model.info];
             
             [weakSelf.tableV reloadData];
         } failure:^(NSError *error) {
             
         }];
    }
    
    
    
}



-(void)shanchubaodan
{
    
    
    
}



//查看报告
-(void)chakan:(UIButton*)btn
{
//    UIButton * abtn = [_tableV viewWithTag:btn.tag -700];
    DataModel * data =self.dataArry[btn.tag -700];
    btn.enabled = NO;
    
    btn_tag = btn.tag;
    
    [self qingwiu:data.id];
}


-(void)qingwiu:(NSString*)myid
{
    UIButton * abtn = [_tableV viewWithTag:btn_tag];
    WS(weakSelf);
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:myid?myid:@"" forKey:@"policy_ids"];
    
    [WBYRequest wbyLoginPostRequestDataUrl:@"get_report" addParameters:dic success:^(WBYReqModel *model)
     {
         if ([model.err isEqualToString:TURE])
         {

             abtn.enabled = YES;
             
             TijianbaogaoViewController * tijian = [TijianbaogaoViewController new];
             tijian.isTijian = NO;

             tijian.myarr = model.data;
             
             [weakSelf.navigationController pushViewController:tijian animated:YES];
          }
     } failure:^(NSError *error) {
         
     }];
    
    
}

-(void)dianji:(UIButton*)btn
{
    btn.selected = !btn.selected;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIButton * btn = [_tableV viewWithTag:800+indexPath.row];
    
    UIButton * btn1 = [self.view viewWithTag:999];

    btn.selected = !btn.selected;

    DataModel * data =self.dataArry[indexPath.row];
    
    if (btn.selected==YES)
    {
        [self.selectArry addObject:data.id?data.id:@""];
        
    }else
    {
        [self.selectArry removeObject:data.id?data.id:@""];
  
    }    
    
    if (self.selectArry.count>=2)
    {
        btn1.backgroundColor = SHENLANSEcolor;
        
    }else
    {
        btn1.backgroundColor = QIANZITIcolor;
  
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
