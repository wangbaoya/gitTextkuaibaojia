//
//  WOdetextViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WOdetextViewController.h"
#import "GuanzhuOneTableViewCell.h"
#import "GuanzhugongsiTableViewCell.h"
#import "GuanzhuxiangzhongTableViewCell.h"
#import "WangShouyeTableViewCell.h"
#import "WeizhanViewController.h"
#import "XinwenxiangqingViewController.h"
#import "ChanpinxiangqingViewController.h"
#import "AAgongsixiangqingViewController.h"
#import "myScrollView.h"
#import "FujindailirenTableViewCell.h"

@interface WOdetextViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger dijige;
    myScrollView * litscroll;
    NSMutableArray * weizhanArr;
    NSMutableArray * zixunArr;
    NSMutableArray * gongsiArr;
    NSMutableArray * xianzhongArr;
    
    UITableView * myTab;
    NSString * tel;
    NSInteger numindex;
    NSArray * jiekouArr;
    UIView * quanxuanDownview;
    
}

@property(nonatomic,strong)UIView * myView;
@property (nonatomic, strong) NSMutableArray *deleteArray;

@end

@implementation WOdetextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
       self.title = @"我的关注";
    
       weizhanArr = [NSMutableArray array];
    
    [self requestdata:@"collect_agent" aint:0];
//    [self requestdata:@"collect_news" aint:1];
//    [self requestdata:@"collect_com" aint:2];
//    [self requestdata:@"collect_pro" aint:3];
  
    [self creatLeftTtem];
    [self creatrightbtn];
//    [self creatmyupview];
    
    
    [self creattab];
}



-(void)creatrightbtn
{
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 40, 20);
    [button setTitle:@"编辑" forState:UIControlStateNormal];
//    [button setTitle:@"取消" forState:UIControlStateSelected];
    
    [button setTitleColor:wWhiteColor forState:UIControlStateNormal];
    button.backgroundColor = SHENLANSEcolor;
    
    button.titleLabel.font = Font(12);
    [button addTarget:self action:@selector(bianji:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:button];
}

-(void)bianji:(UIButton*)btn
{
    btn.selected = !btn.selected;
    
    if (btn.selected==YES)
    {
        myTab.editing = YES;
        myTab.allowsMultipleSelectionDuringEditing = YES;
        
    }else
    {
        myTab.editing = NO;
 
    }
}



-(void)creattab
{
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, wScreenW, wScreenH - 64 ) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    
    [myTab registerClass:[GuanzhuOneTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    myTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
       [self.view addSubview:myTab];
    
    UIView * bgv = [[UIView alloc] init];
    myTab.tableFooterView = bgv;
    
    [myTab setSeparatorInset:UIEdgeInsetsZero];
    [myTab setLayoutMargins:UIEdgeInsetsZero];
  
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        return 60;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        return weizhanArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        GuanzhuOneTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (weizhanArr.count>=1)
        {
            DataModel * mod = weizhanArr[indexPath.row];
            [cell.myImg sd_setImageWithURL:[NSURL URLWithString:mod.avatar] placeholderImage:[UIImage imageNamed:@"city"]];
            cell.upLab.text = mod.name?mod.name:@"暂无";
            cell.downLab.text = [NSString stringWithFormat:@"%@ %@ %ld %@",mod.cname,mod.profession,[WBYRequest getAge:mod.birthday],mod.provn?mod.provn:@""];
            cell.sexLab.text = [mod.sex isEqualToString:@"1"]?@"男":@"女";
            
//            [cell.telbtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
        
    
}



- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
}



-(void)requestdata:(NSString*)url aint:(NSInteger)a
{
    
    WS(weakSelf);
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:UID forKey:@"uid"];
    [dic setObject:[NSString stringWithFormat:@"%ld",numindex] forKey:@"p"];
    [dic setObject:@"10" forKey:@"pagesize"];
    
    [WBYRequest wbyLoginPostRequestDataUrl:url addParameters:dic success:^(WBYReqModel *model)
     {
         [weakSelf.beijingDateView removeFromSuperview];
         
         if ([model.err isEqualToString:TURE])
         {
             if (a==0)
             {
                 if (numindex == 1)
                 {
                     [weizhanArr removeAllObjects];
                 }
                 
                 [weizhanArr addObjectsFromArray:model.data];
                 
                 if (weizhanArr.count==0)
                 {
                     [weakSelf wushuju];
                 }
                 
             }else if (a==1)
             {
                 //                zixunArr = model.data;
                 
                 if (numindex == 1)
                 {
                     [zixunArr removeAllObjects];
                 }
                 
                 [zixunArr addObjectsFromArray:model.data];
                 
                 if (zixunArr.count==0)
                 {
                     [weakSelf wushuju];
                 }
                 
                 
             }else if (a==2)
             {
                 //                gongsiArr = model.data;
                 if (numindex == 1)
                 {
                     [gongsiArr removeAllObjects];
                 }
                 
                 [gongsiArr addObjectsFromArray:model.data];
                 
                 if (gongsiArr.count==0)
                 {
                     [weakSelf wushuju];
                 }
                 
                 
                 
             }else
             {
                 //                xianzhongArr = model.data;
                 if (numindex == 1)
                 {
                     [xianzhongArr removeAllObjects];
                 }
                 
                 [xianzhongArr addObjectsFromArray:model.data];
                 
                 if (xianzhongArr.count==0)
                 {
                     [weakSelf wushuju];
                 }
             }
             
         }
         
         [myTab reloadData];
         
     } failure:^(NSError *error)
     {
         
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
