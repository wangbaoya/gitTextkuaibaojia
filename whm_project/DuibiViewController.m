//
//  DuibiViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DuibiViewController.h"
#import "WBYduibiiiTableViewCell.h"
#import "WBYxuanzexianzhongViewController.h"
#import "DuibicanshuViewController.h"

@interface DuibiViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * myArr;
    NSMutableArray * idArr;
    NSString * myid;
    UITableView * myTab;

}
@end

@implementation DuibiViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"险种对比";
    myArr = [NSMutableArray array];
    idArr = [NSMutableArray array];
    [self creatLeftTtem];
    [self creatright];
    [self creatview];
    
}

-(void)creatright
{
    UIButton * clearBut = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBut.frame = CGRectMake(wScreenW - 40, 0, 40, 20);
    [clearBut setTitle:@"清空" forState:(UIControlStateNormal)];
    [clearBut setTitleColor:wBlackColor forState:UIControlStateNormal];
    clearBut.titleLabel.font = Font(18);
    [clearBut addTarget:self action:@selector(clearAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    clearBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.navigationItem.rightBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:clearBut];
    
}
-(void)clearAction
{

    UIButton * downBtn = [self.view viewWithTag:88];
    downBtn.backgroundColor = QIANZITIcolor;

    
    
    [myArr removeAllObjects];
    [idArr removeAllObjects];
    [myTab reloadData];
}
-(void)creatview
{
    UIView* myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 60)];
    myView.backgroundColor = wWhiteColor;
    //    [self.view addSubview:myView];
    
    UIView * aaa = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 10)];
    
    aaa.backgroundColor = JIANGEcolor;
    [myView addSubview:aaa];
    UIButton * selBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    selBut.frame = CGRectMake(10, 15+5, 30, 30);
    //    selBut.layer.masksToBounds = YES;
    //    selBut.layer.cornerRadius = 10;
    [selBut setBackgroundImage:[UIImage imageNamed:@"Jw_select"] forState:UIControlStateNormal];
    [myView addSubview:selBut];
    
    
    UILabel * myTitlaber = [[UILabel alloc]init];
    myTitlaber.frame = CGRectMake(CGRectGetMaxX(selBut.frame)+10, 10, wScreenW -20-10, 50);
    myTitlaber.textColor = QIANZITIcolor;
    myTitlaber.text = _dataMod.short_name.length>=1?_dataMod.short_name:_dataMod.name;
    myTitlaber.font = daFont;
    [myView addSubview:myTitlaber];
    
    UIView * xianView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, wScreenW, 1)];
    xianView.backgroundColor = wBaseColor;
    [myView addSubview:xianView];
    
    
    
    UIView * downview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 60)];
    downview.backgroundColor = JIANGEcolor;
    
    
    
    
    UIButton * AddNewBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    AddNewBut.frame = CGRectMake( 0, 15 , wScreenW, 45);
    AddNewBut.backgroundColor = [UIColor whiteColor];
    [AddNewBut setTitle:@"+添加新险种" forState:(UIControlStateNormal)];
    AddNewBut.titleLabel.font = Font(20);
    
    AddNewBut.titleLabel.textAlignment = NSTextAlignmentCenter;
    [AddNewBut setTintColor:UIColorFromHex(0x4367FF)];
    [AddNewBut addTarget:self action:@selector(addNewButAction) forControlEvents:(UIControlEventTouchUpInside)];
    [downview addSubview:AddNewBut];
    
    
    
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH - 64-60) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    myTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    myTab.tableHeaderView = myView;
    myTab.tableFooterView = downview;
    [myTab registerClass:[WBYduibiiiTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:myTab];
    
    
    [myTab setSeparatorInset:UIEdgeInsetsZero];
    
    
    UIView * xiaview = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(myTab.frame), wScreenW, 50)];
    xiaview.backgroundColor = wWhiteColor;
    [self.view addSubview:xiaview];
    
    UIButton * downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    downBtn.frame = CGRectMake(30,5, wScreenW-60,40);
    downBtn.backgroundColor = QIANZITIcolor;
    downBtn.tag = 88;
    [downBtn setTitleColor:wWhiteColor forState:UIControlStateNormal];
    [downBtn setTitle:@"选择参数" forState:UIControlStateNormal];
    
    [downBtn addTarget:self action:@selector(xuancanshu) forControlEvents:UIControlEventTouchUpInside];
    downBtn.layer.masksToBounds = YES;
    downBtn.layer.cornerRadius = 40/2;
    
    [xiaview addSubview:downBtn];
    
}

-(void)xuancanshu
{
    
    
    if (myid.length>=1&&_dataMod.id&&myArr.count>=1)
    {
        DuibicanshuViewController * canshu = [DuibicanshuViewController new];
        canshu.myid = myid;
        canshu.theid = _dataMod.id;
        [self.navigationController pushViewController:canshu animated:YES];
    }else
    {
        [WBYRequest showMessage:@"请选择险种"];
        return;
    }
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return myArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBYduibiiiTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    [cell.selBut setBackgroundImage:[UIImage imageNamed:@"Jw_voal"] forState:(UIControlStateNormal)];
    cell.selBut.tag = 500 + indexPath.row;
    cell.myTitlaber.text = myArr[indexPath.row];
    
    for (NSInteger i=0; i<myArr.count; i++)
    {
        UIButton * btn1 = [myTab viewWithTag:500+i];
        [btn1 setBackgroundImage:[UIImage imageNamed:@"Jw_voal"] forState:(UIControlStateNormal)];
    }
    UIButton  * btn = [self.view viewWithTag:500 + myArr.count-1];
    
    [btn setBackgroundImage:[UIImage imageNamed:@"Jw_select"] forState:UIControlStateNormal];
    
    myid = [idArr lastObject];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIButton * btn = [myTab viewWithTag:500 +indexPath.row];
    for (NSInteger i=0; i<myArr.count; i++)
    {
        UIButton * btn1 = [myTab viewWithTag:500+i];
        
        [btn1 setBackgroundImage:[UIImage imageNamed:@"Jw_voal"] forState:(UIControlStateNormal)];
    }
    
    [btn setBackgroundImage:[UIImage imageNamed:@"Jw_select"] forState:UIControlStateNormal];
    
    myid = idArr[indexPath.row];
    
    
}


-(void)addNewButAction
{
    UIButton * btn= [self.view viewWithTag:88];
    WBYxuanzexianzhongViewController * produce = [[WBYxuanzexianzhongViewController alloc] init];
    
    produce.xianZhongModel = ^(DataModel * dataMod)
    {
        if ([idArr containsObject:dataMod.id])
        {
            [WBYRequest showMessage:@"不要重复加此险种"];
            return ;
        }else
        {
            btn.backgroundColor = wBlue;
            [myArr addObject:dataMod.short_name.length>=1?dataMod.short_name:dataMod.name];
            [idArr addObject:dataMod.id?dataMod.id:@""];
        }
        [myTab reloadData];
    };
    
    [self.navigationController pushViewController:produce animated:YES];
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
