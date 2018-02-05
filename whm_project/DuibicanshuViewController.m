//
//  DuibicanshuViewController.m
//  whm_project
//
//  Created by apple on 17/3/10.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "DuibicanshuViewController.h"
//#import "WHageduibiViewController.h"
//#import "WBYcanshuuuuTableViewCell.h"
//#import "DuibiwebPageViewController.h"
#import "NianlingViewController.h"
#import "DuibiwebPageViewController.h"
@interface DuibicanshuViewController ()<UITextFieldDelegate>
{
    UITapGestureRecognizer *tapGesture1;
    UITapGestureRecognizer *tapGesture2;
    UITableView * myTab;
    NSArray * allArr;
    NSString * onePid;
    NSString * twoPid;
    
    NSArray * imgArr;
    NSArray * midArr;
}

@property(nonatomic,strong)UILabel * StrSex;
@property(nonatomic,strong)UILabel * StrAge;
@property(nonatomic,strong)UITextField * planText;
@property(nonatomic,strong)UIButton * recomBut;


@end

@implementation DuibicanshuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"对比参数";
    allArr = [NSArray array];
    [self creatLeftTtem];
    [self creatview];
}

-(void)creatview
{
    UILabel * headLaber = [[UILabel alloc]init];
    headLaber.frame = CGRectMake(0, 5, wScreenW, 30);
    headLaber.text = @"   请先选择性别、投保年龄,填写计划保费,点击\"为我推荐\"。";
    headLaber.textColor =UIColorFromHex(0xC4C4C4);
    headLaber.backgroundColor = UIColorFromHex(0xF5F7F9);
    headLaber.font = ZT12;
    [self.view addSubview:headLaber];
 
    UIImageView * SexImg = [[UIImageView alloc]init];
    SexImg.frame = CGRectMake(10, 45, 30, 30);
    SexImg.image = [UIImage imageNamed:@"whselectsex"];
    [self.view addSubview:SexImg];
    
    UILabel * sexLaber = [[UILabel alloc] init];
    sexLaber.frame = CGRectMake(CGRectGetMaxX(SexImg.frame)+10,40, 50, 40);
    sexLaber.font = daFont;
    sexLaber.text = @"性别";
    sexLaber.textColor = UIColorFromHex(0x666666);
    [self.view addSubview:sexLaber];

    
    self.StrSex = [[UILabel alloc]init];
    self.StrSex.frame = CGRectMake(CGRectGetMaxX(sexLaber.frame), CGRectGetMinY(sexLaber.frame), wScreenW  - 20-50 - 20-30-5, 40);
    self.StrSex.font = daFont;
    self.StrSex.textAlignment = NSTextAlignmentRight;
     self.StrSex.text = @"男";
    //性别手势
    tapGesture1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sexOnClick:)];
    self.StrSex.userInteractionEnabled = YES;
    tapGesture1.numberOfTapsRequired = 1;
    tapGesture1.numberOfTouchesRequired = 1;
    [self.StrSex addGestureRecognizer:tapGesture1];
    [self.view addSubview:self.StrSex];
    
    UILabel * line1 = [[UILabel alloc]init];
    line1.frame = CGRectMake(10, CGRectGetMaxY(self.StrSex.frame), wScreenW - 20, 1);
    line1.backgroundColor = UIColorFromHex(0xF5F7F9);
    [self.view addSubview:line1];
    UIImageView * jianImg = [[UIImageView alloc]init];
    jianImg.frame = CGRectMake(wScreenW - 22,CGRectGetMinY(sexLaber.frame)+13, 14, 14);
    jianImg.image = [UIImage imageNamed:@"p_arrowleft"];
    [self.view addSubview:jianImg];
    
    UIImageView * ageImg = [[UIImageView alloc]init];
    ageImg.frame = CGRectMake(10, CGRectGetMaxY(line1.frame)+5, CGRectGetWidth(SexImg.frame), CGRectGetHeight(SexImg.frame));
    ageImg.image = [UIImage imageNamed:@"test_year"];
    [self.view addSubview:ageImg];
    
    UILabel * ageLaber = [[UILabel alloc]init];
    ageLaber.frame = CGRectMake(CGRectGetMinX(sexLaber.frame),CGRectGetMinY(line1.frame), 90, CGRectGetHeight(sexLaber.frame));
    ageLaber.text = @"投保年龄";
    ageLaber.textColor = UIColorFromHex(0x666666);
    ageLaber.font = daFont;
    [self.view addSubview:ageLaber];
    
    self.StrAge = [[UILabel alloc]init];
    self.StrAge.frame = CGRectMake(CGRectGetMaxX(ageLaber.frame),CGRectGetMaxY(line1.frame),wScreenW- 20-90 - 20-30-5, CGRectGetHeight(sexLaber.frame));
    self.StrAge.font = daFont;
     self.StrAge.text = @"0";
    self.StrAge.textAlignment = NSTextAlignmentRight;
    
    tapGesture2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ageOnClick:)];
    self.StrAge.userInteractionEnabled = YES;
    tapGesture2.numberOfTapsRequired = 1;
    tapGesture2.numberOfTouchesRequired = 1;
    [self.StrAge addGestureRecognizer:tapGesture2];
    
    [self.view addSubview:_StrAge];
     
    UIImageView * jianImg2 = [[UIImageView alloc]init];
    jianImg2.frame = CGRectMake(wScreenW-22,CGRectGetMaxY(line1.frame)+13, 14, 14);
    jianImg2.image = [UIImage imageNamed:@"p_arrowleft"];
    [self.view addSubview:jianImg2];
    
    
    
    UILabel * line2 = [[UILabel alloc]init];
    line2.frame = CGRectMake(10, CGRectGetMaxY(self.StrAge.frame), CGRectGetWidth(line1.frame), 1);
    line2.backgroundColor = UIColorFromHex(0xF5F7F9);
    [self.view addSubview:line2];
    
    
    UIImageView * dateImg = [[UIImageView alloc]init];
    dateImg.frame = CGRectMake(10, CGRectGetMaxY(line2.frame)+5, 30, 30);
    dateImg.image = [UIImage imageNamed:@"test_date"];
    [self.view addSubview:dateImg];
    
    self.planText = [[UITextField alloc] init];
    self.planText.frame = CGRectMake(CGRectGetMaxX(dateImg.frame)+10, CGRectGetMaxY(line2.frame), wScreenW - 50, 40);
    self.planText.borderStyle = UITextBorderStyleNone;
    self.planText.font = zhongFont;
    self.planText.placeholder = @"请输入您的计划保费";
    self.planText.delegate = self;
    self.planText.textColor = UIColorFromHex(0x666666);
    self.planText.keyboardType = UIKeyboardTypeNumberPad;
    self.planText.clearButtonMode = UITextFieldViewModeAlways;
    
    [self.planText addTarget:self action:@selector(gaibain) forControlEvents:UIControlEventEditingChanged];
    
    [self.view addSubview:_planText];
    
    UILabel * line3 = [[UILabel alloc]init];
    line3.frame = CGRectMake(0, CGRectGetMaxY(self.planText.frame), wScreenW, 10);
    line3.backgroundColor = UIColorFromHex(0xF5F7F9);
    [self.view addSubview:line3];
    
    UIView * midView = [[UIView alloc]init];
    midView.frame = CGRectMake(0, CGRectGetMaxY(line3.frame), wScreenW , 50);
    midView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:midView];
    
    UILabel * remLaber =[[UILabel alloc]init];
    remLaber .frame = CGRectMake(wScreenW * 0.35, 13, 25, 25);
    remLaber.tag = 9090;
    remLaber.layer.masksToBounds = YES;
    remLaber.layer.cornerRadius = 25/2;
    remLaber.textColor = [UIColor whiteColor];
    remLaber.text = @"荐";
    remLaber.textAlignment = NSTextAlignmentCenter;
    remLaber.font = Font(18);
    remLaber.backgroundColor = QIANZITIcolor;
    
    
    [midView addSubview:remLaber];
    
    self.recomBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.recomBut.frame = CGRectMake(CGRectGetMaxX(remLaber.frame)+5, 5, wScreenW * 0.3-20, 40);
    [self.recomBut setTitle:@"为我推荐" forState:(UIControlStateNormal)];
    self.recomBut.enabled = NO;
    self.recomBut.titleLabel.font = Font(18);
    
    self.recomBut.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [self.recomBut addTarget:self action:@selector(tuijian) forControlEvents:UIControlEventTouchUpInside];
    [self.recomBut setTintColor:UIColorFromHex(0x4367FF)];

    [midView addSubview:_recomBut];
    
}
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    
    self.recomBut.enabled = NO;
        return YES;
    
}
//性别选择
-(void)sexOnClick:(UITapGestureRecognizer *)sender
{
    
    [XuanXIngBie showWithTitle:@"选择性别" titles:@[@"男",@"女"] selectIndex:^(NSInteger selectIndex)
     {
         
     } selectValue:^(NSString *selectValue) {
         
        self.StrSex.text = selectValue;
         
     } showCloseButton:YES];
    
    
    
    
}
//年龄选择
-(void)ageOnClick:(UITapGestureRecognizer *)sender{
    
    
    WS(weakSelf);
    
    NianlingViewController * nianling = [NianlingViewController new];
    nianling.getAge = ^(NSString * age)
    {
        weakSelf.StrAge.text = age;
        
    };
    
    
    [self.navigationController pushViewController:nianling animated:YES];
    
 
}



-(void)gaibain
{
    UILabel * lab = [self.view viewWithTag:9090];
    
    if (self.planText.text.length>=1)
    {
        self.recomBut.enabled=YES;
        lab.backgroundColor = UIColorFromHex(0x4367FF);
    }else
    {
        self.recomBut.enabled=NO;
        lab.backgroundColor = QIANZITIcolor;
        
    }
  
    
    
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSMutableString * futureString = [NSMutableString stringWithString:textField.text];
    [futureString  insertString:string atIndex:range.location];
    
    if ([futureString length] > 1)
    {
        if (![WBYRequest isFloatPrice:futureString])
        {
            [WBYRequest showMessage:@"输入数据过大"];
            return NO;
        }
    }
    return YES;
    
  }

-(void)tuijian
{
    [self requestData];

    [self.view endEditing:YES];
}

-(void)requestData
{
    if (self.planText.text)
    {
        NSString * xingbie;
        NSString * str = [NSString stringWithFormat:@"%@,%@",_myid,_theid];
        
        
        
        if ([self.StrSex.text isEqualToString:@"男"])
        {
            xingbie=@"1";
        }else
        {
            xingbie=@"0";
        }
        
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        
        [dic setObject:str forKey:@"pids"];
        [dic setObject:self.planText.text forKey:@"rate"];
        [dic setObject:self.StrAge.text forKey:@"age"];
        
        if ([self.StrSex.text isEqualToString:@"男"])
        {
            [dic setObject:@"1" forKey:@"gender"];
        }else
        {
            [dic setObject:@"0" forKey:@"gender"];
        }
        
        WS(weakSelf);
        [WBYRequest wbyPostRequestDataUrl:@"compare_rate" addParameters:dic success:^(WBYReqModel *model)
         {
             
             if ([model.err isEqualToString:TURE])
             {
                 allArr=model.data;
                 DataModel * data = [model.data firstObject];
                 [weakSelf kaishiduibi:data.ids?data.ids:@""];
                 
             }else
             {
                 [WBYRequest showMessage:model.info];
                 
             }
             
         } failure:^(NSError *error) {
             
         } isRefresh:YES];
        
        
    }else
    {
        [WBYRequest showMessage:@"请输入保费"];
        return;
    }
    
    
    
}



-(void)kaishiduibi:(NSString*)str
{
    
//    https://www.kuaibao365.com/product/app_compare/580,584
    
    NSString * mystr = [NSString stringWithFormat:@"https://www.kuaibao365.com/product/app_compare/%@",str];
    DuibiwebPageViewController * duibi = [DuibiwebPageViewController new];
    duibi.str = mystr;
    
    [self.navigationController pushViewController:duibi animated:YES];
    
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
