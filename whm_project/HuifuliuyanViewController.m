//
//  HuifuliuyanViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HuifuliuyanViewController.h"
#import "WHreplymessage.h"
@interface HuifuliuyanViewController ()
@property(nonatomic,strong)WHreplymessage * rep;

@property(nonatomic,strong)NSMutableArray * dataArry;

//回复
@property(nonatomic,strong)NSString * StrID;
@property(nonatomic,strong)NSString * req_uid;
@property(nonatomic,strong)NSString * res_uid;
@property(nonatomic,strong)NSString * message_id;
@property(nonatomic,strong)NSString * city_name;
@property(nonatomic,strong)NSString * req_name;


@end

@implementation HuifuliuyanViewController
-(void)loadView
{
    self.rep = [[WHreplymessage alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view =_rep;
    
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的留言";
    [self.rep.delBut addTarget:self action:@selector(delButAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.rep.repBut addTarget:self action:@selector(repButAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

//删除留言回复
-(void)delButAction:(UIButton * )sender
{
    
}

-(void)repButAction:(UIButton *)sender
{
    
    
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
