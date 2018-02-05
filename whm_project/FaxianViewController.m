//
//  FaxianViewController.m
//  MYTEXT
//
//  Created by apple on 17/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "FaxianViewController.h"
#import "ShouYETableViewCell.h"
#import "DingdianyiyuanViewController.h"
#import "FujindailirenViewController.h"
#import "BaoxianwangdianViewController.h"


@interface FaxianViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * myTab;
    
    NSArray * imgArr;
    NSArray * ziArr;
    UIImageView * myImg;
    CAKeyframeAnimation * keyAnimaion;
}
@end

@implementation FaxianViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    self.title = @"发现";
    ziArr = @[@"附近代理人",@"保险网点",@"定点医院"];
    imgArr = @[@"\U0000e622",@"\U0000e621",@"\U0000e623"];
    
    [self creatmyview];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self qufengexian];    
    
    [UIView animateWithDuration:0.8 animations:^{
        
        myImg.center  = CGPointMake(self.view.center.x, 126/2);

    } completion:^(BOOL finished)
    {
        keyAnimaion.speed = 1;
        [myImg.layer addAnimation:keyAnimaion forKey:nil];
    }];

    [super viewWillAppear:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self jiafengexian];
    
    [UIView animateWithDuration:0.8 animations:^{
        
        myImg.center  = CGPointMake(0, -126/2);
        
        keyAnimaion.speed = 0;
    }];

    [super viewWillDisappear:YES];
    
}



-(void)creatmyview
{
    myImg = [[UIImageView alloc] init];
    myImg.frame  = CGRectMake(0, 0, 218, 126);
    myImg.image = [UIImage imageNamed:@"组-92"];
    myImg.center  = CGPointMake(0, -126/2);
    [self.view addSubview:myImg];
    
//    CABasicAnimation * baseAnima = [CABasicAnimation  animationWithKeyPath:@""];
    
    
    
    keyAnimaion = [CAKeyframeAnimation animation];
    keyAnimaion.keyPath = @"transform.rotation";
    keyAnimaion.values = @[@(0),@(0.2),@(0)];//度数转弧度
    
    keyAnimaion.removedOnCompletion = NO;
    keyAnimaion.fillMode = kCAFillModeForwards;
    keyAnimaion.duration = 0.3;
    keyAnimaion.repeatCount = 1;
    keyAnimaion.autoreverses = YES;
    
    
    UILabel * aLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(myImg.frame)+25, wScreenW, 1)];
    aLab.backgroundColor = FENGEXIANcolor;
    
    [self.view addSubview:aLab];
    
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(aLab.frame), wScreenW, wScreenH -25- 64-49-CGRectGetHeight(myImg.frame)) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    myTab.bounces = NO;
    myTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    myTab.separatorColor = FENGEXIANcolor;
    myTab.backgroundColor = UIColorFromHex(0xEBF0F4);
    
    [myTab registerClass:[ShouYETableViewCell class] forCellReuseIdentifier:@"cell"];
    
    myTab.tableFooterView = [[UIView alloc] init];
    
    [myTab setSeparatorInset:UIEdgeInsetsZero];
    [myTab setLayoutMargins:UIEdgeInsetsZero];
    
    [self.view addSubview:myTab];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HANGGAO;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return imgArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShouYETableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.lImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(imgArr[indexPath.row], 25, SHENLANSEcolor)];
    cell.midLab.text = ziArr[indexPath.row];
    cell.midLab.textColor = wBlackColor;
    cell.midLab.font = daFont;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        [self.navigationController pushViewController:[FujindailirenViewController new] animated:YES];
       
    }else if (indexPath.row==1)
    {
        BaoxianwangdianViewController * baoxian = [BaoxianwangdianViewController new];
        [self.navigationController pushViewController:baoxian animated:YES];
        
    }else
    {
       [self.navigationController pushViewController:[DingdianyiyuanViewController new] animated:YES];
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
