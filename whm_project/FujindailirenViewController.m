
//
//  FujindailirenViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "FujindailirenViewController.h"
#import "FujindailirenTableViewCell.h"
#import "ZMFloatButton.h"
#import "AAdailirendituViewController.h"
#import "WeizhanViewController.h"

@interface FujindailirenViewController ()<UITableViewDelegate,UITableViewDataSource,ZMFloatButtonDelegate>
{
    UITableView * myTab;
    NSMutableArray * allArr;
    NSInteger numindex;
    NSString * tel;
}

@end

@implementation FujindailirenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    numindex = 1;
    allArr = [NSMutableArray array];
    self.title = @"附近代理人";
  
    [self creatLeftTtem];
    NSString * jingdu = LNGONE;
    NSString * weidu = LATTWO;
    
    if (jingdu.length>=1&&weidu.length>=1)
    {
        [self requestdata:jingdu latt:weidu];
    }else
    {
        [WBYRequest showMessage:@"无法获取当前位置"];
    }
    
    [self creatmyview];
    
    }


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
}

-(void)creatmyview
{
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, wScreenW, wScreenH - 64 ) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    
    myTab.tag = 500;
    [myTab registerClass:[FujindailirenTableViewCell class] forCellReuseIdentifier:@"cell"];
    myTab.rowHeight = 90;
    myTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    myTab.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    myTab.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];

    [self.view addSubview:myTab];
    
    UIView * bgv = [[UIView alloc] init];
    myTab.tableFooterView = bgv;
    
    [myTab setSeparatorInset:UIEdgeInsetsZero];
    [myTab setLayoutMargins:UIEdgeInsetsZero];
   
    [self huadongbutton];
}
-(void)huadongbutton
{
    ZMFloatButton * floatBtn = [[ZMFloatButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60-15,wScreenH-64-60-20, 60, 60)];
    floatBtn.delegate = self;
    //floatBtn.isMoving = NO;
    floatBtn.bannerIV.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e624", 60, SHENLANSEcolor)];
    [self.view addSubview:floatBtn];
    [self.view bringSubviewToFront:floatBtn];
    
}
#pragma mark -ZMFloatButtonDelegate
- (void)floatTapAction:(ZMFloatButton *)sender
{
    //点击执行事件
    [self.navigationController pushViewController:[AAdailirendituViewController new] animated:YES];
    
}



#pragma mark===加载

-(void)headerRereshing
{
    numindex = 1 ;
    [self requestdata:LNGONE latt:LATTWO];

    [myTab.mj_header endRefreshing];
    
}
//下拉
-(void)footerRefreshing
{
    
    numindex ++ ;
    [self requestdata:LNGONE latt:LATTWO];

    [myTab.mj_footer endRefreshing];
    
}

#pragma mark===tab代理事件数据源事件

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return allArr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  
    FujindailirenTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if (allArr.count>=1)
    {
        DataModel * dataMod = allArr[indexPath.row];
        
        
        [cell.telBut setBackgroundImage:[UIImage imageNamed:@"tel"] forState:(UIControlStateNormal)];
        
        cell.nameLaber.text = dataMod.name.length >=1?dataMod.name:@"未知";
        [cell.myImage sd_setImageWithURL:[NSURL URLWithString:dataMod.avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"city"]];
        
        if ([dataMod.sex isEqualToString: @"1"])
        {
            cell.sexImg.image = [UIImage imageNamed:@"nande"];

        }else
        {
            cell.sexImg.image = [UIImage imageNamed:@"nvde"];

        }
//        cell.mapImg.image = [UIImage imageNamed:@"maple"];
//        cell.telImg.image = [UIImage imageNamed:@"tel"];
        cell.telLaber.text = dataMod.mobile;
        cell.companyLaber.text = dataMod.cname;
        cell.addressLaber.text  = dataMod.oname.length >= 1?dataMod.oname:@"未知地址";
        
        if ([dataMod.dist floatValue] <1000)
        {
            cell.mapLaber.text = [NSString stringWithFormat:@"%.2lfM",[dataMod.dist floatValue]];
        }else
        {
            cell.mapLaber.text = [NSString stringWithFormat:@"%.2lfKM",[dataMod.dist floatValue]/1000];
        }
        
        cell.mapLaber.textColor = Wqingse;
        
        cell.telBut.tag = 50 + indexPath.row;
        [cell.telBut addTarget:self action:@selector(telAction:) forControlEvents:(UIControlEventTouchUpInside)];
     }
    
    return cell;
   }

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FujindailirenTableViewCell * celqq = (FujindailirenTableViewCell *)cell;
    
    celqq.myImage.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1);
    
    [UIView animateWithDuration:0.8 animations:^{
        celqq.myImage.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}

-(void)telAction:(UIButton*)btn
{        DataModel * data = allArr[btn.tag - 50];
       tel = data.mobile;

    if ([WBYRequest isMobileNumber:data.mobile])
    {

        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要打电话" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
             [view show];
        
    }else
    {
        [WBYRequest showMessage:@"电话号码不合法"];
    }
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",tel];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}


-(void)requestdata:(NSString*)lng latt:(NSString*)lat
{
    WS(weakSelf);
     NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSString stringWithFormat:@"%ld",numindex] forKey:@"p"];
    [dic setObject:@"15" forKey:@"pagesize"];
    [dic setObject:lng forKey:@"lng"];
    [dic setObject:lat forKey:@"lat"];
    [dic setObject:@"2000" forKey:@"distance"];

    [WBYRequest wbyPostRequestDataUrl:@"near_agent" addParameters:dic success:^(WBYReqModel *model)
     {
         if ([model.err isEqualToString:TURE])
         {
             
        [weakSelf.beijingDateView removeFromSuperview];
             
             if (numindex == 1)
             {
                 [allArr removeAllObjects];
             }
             
             [allArr addObjectsFromArray:model.data];
             
             if (allArr.count==0)
             {
                 [weakSelf wushuju];
             }
         }
         
         [myTab reloadData];
     } failure:^(NSError *error) {
        
    } isRefresh:YES];
 }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (allArr.count>=1)
    {
        DataModel * dataMod = allArr[indexPath.row];

        WeizhanViewController * weizhan = [WeizhanViewController new];
        weizhan.agentId = dataMod.uid;
        
        [self.navigationController pushViewController:weizhan animated:YES];
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
