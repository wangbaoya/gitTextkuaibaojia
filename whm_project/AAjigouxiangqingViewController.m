//
//  AAjigouxiangqingViewController.m
//  whm_project
//
//  Created by apple on 17/4/12.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "AAjigouxiangqingViewController.h"
#import <MapKit/MapKit.h>
#import "AAyiyuanxiangqingTableViewCell.h"
#import "AAtwoTableViewCell.h"
#import "AAyiyuanthreeTableViewCell.h"


@interface AAjigouxiangqingViewController ()<UITableViewDelegate,UITableViewDataSource,BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    UITableView * myTab;
    NSArray * lArr;
    NSArray * rArr;
    
}

@property(nonatomic,strong)UIButton * imgBut;
@property(nonatomic,strong)UILabel * titLaber;
@property(nonatomic,strong)UILabel * addressLaber;
@property(nonatomic,strong)UIImageView * mapImg;
@property(nonatomic,strong)UILabel * mapLaber;
@property(nonatomic,strong)UIImageView * telImg;
@property(nonatomic,strong)UIButton * telBut;


@end

@implementation AAjigouxiangqingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"保险网点";

    lArr = @[@"机构简称",@"设立时间",@"负 责 人",@"机构类型",@"中资外资",@"注 册 地",@"状      态"];
    rArr = @[_myDataModel.shortn?_myDataModel.shortn:@"暂无信息",_myDataModel.b_date?_myDataModel.b_date:@"暂无信息",_myDataModel.prin.length>=1?_myDataModel.prin:@"暂无信息",_myDataModel.cate.length>=1?_myDataModel.cate:@"暂无信息",_myDataModel.ctype?_myDataModel.ctype:@"暂无信息",_myDataModel.r_addr.length>=1?_myDataModel.r_addr:@"暂无信息",_myDataModel.cond.length>=1?_myDataModel.cond:@"暂无信息"];
    
    [self creatLeftTtem];
    [self creatUI];
}

-(void)creatUI
{
    
    CGFloat hh = 90;
    CGFloat hh1 = 10;
    CGFloat hh2 = hh - hh1 * 2;
    
    CGFloat lithhh =(hh-20)/3;
    
    UIView * upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 90)];
    
    _imgBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _imgBut.frame = CGRectMake(hh1, hh1, hh2, hh2);
    _imgBut.layer.masksToBounds = YES;
    _imgBut.layer.cornerRadius = hh2/2;
    
    [_imgBut sd_setImageWithURL:[NSURL URLWithString:_myDataModel.logo] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"city"]];
    
    
    [upView addSubview:self.imgBut];
    
    self.titLaber = [[UILabel alloc] init];
    self.titLaber.frame = CGRectMake(CGRectGetMaxX(self.imgBut.frame)+10, 0,wScreenW-20-hh2, lithhh+10+5);
    self.titLaber.font = zhongFont;
    self.titLaber.textColor = wBlackColor;
    self.titLaber.numberOfLines=0;
    
    self.titLaber.text = _myDataModel.shortn.length > 1?_myDataModel.shortn:@"暂无公司";
    
    [upView addSubview:_titLaber];
    
    self.addressLaber = [[UILabel alloc]init];
    self.addressLaber.frame = CGRectMake(CGRectGetMinX(self.titLaber.frame), CGRectGetMaxY(self.titLaber.frame), CGRectGetWidth(self.titLaber.frame), lithhh-5);
    self.addressLaber.textColor = QIANZITIcolor;
    self.addressLaber.font = xiaoFont;
    self.addressLaber.text =  _myDataModel.addr.length>=1?_myDataModel.addr:@"暂无地址";
    
    [upView addSubview:_addressLaber];
    
    
    self.mapImg = [[UIImageView alloc]init];
    self.mapImg.frame = CGRectMake(CGRectGetMinX(self.addressLaber.frame), CGRectGetMaxY(self.addressLaber.frame)+4, lithhh-8, lithhh-8);
self.mapImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e60f", 25, Wqingse)];
    [upView addSubview:_mapImg];
    
    self.mapLaber = [[UILabel alloc]init];
    self.mapLaber.frame = CGRectMake(CGRectGetMaxX(self.mapImg.frame)+5, CGRectGetMaxY(self.addressLaber.frame),70, lithhh);
    self.mapLaber.textColor = QIANZITIcolor;
    self.mapLaber.font = xiaoFont;
    
    if (_gongsimingzi==666)
    {
        _mapLaber.text = _myDataModel.dist;
    }else
    {
        if ([_myDataModel.dist floatValue]<1000)
        {
            _mapLaber.text = [NSString stringWithFormat:@"%ldM",(long)[_myDataModel.dist integerValue]];
        }else
        {
            _mapLaber.text = [NSString stringWithFormat:@"%.2lfKM",[_myDataModel.dist floatValue]/1000];
        }
        
    }
    
    
    _mapLaber.textColor = Wqingse;
    [upView addSubview:_mapLaber];
    
    self.telImg =  [[UIImageView alloc]init];
    self.telImg.frame = CGRectMake(CGRectGetMaxX(self.mapLaber.frame)+10, CGRectGetMinY(self.mapImg.frame), CGRectGetWidth(self.mapImg.frame), CGRectGetHeight(self.mapImg.frame));
 self.telImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e628",25,DianhuaColor)];
    
    [upView addSubview:_telImg];
    
    self.telBut = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.telBut.frame = CGRectMake(CGRectGetMaxX(self.telImg.frame)+5, CGRectGetMaxY(self.addressLaber.frame),150 ,lithhh);
    [self.telBut setTitleColor:DianhuaColor forState:UIControlStateNormal];
    self.telBut.titleLabel.font = xiaoFont;
    self.telBut.titleLabel.textAlignment = NSTextAlignmentLeft;
    NSString * tttel =_myDataModel.tel.length>5?_myDataModel.tel:@"暂无电话";
    [_telBut setTitle:tttel forState:UIControlStateNormal];
    
    _telBut.contentHorizontalAlignment = 1;
    
    [upView addSubview:_telBut];
    
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, wScreenW, wScreenH - 64-49) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    myTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    myTab.tableHeaderView = upView;
    [myTab registerClass:[AAyiyuanxiangqingTableViewCell class] forCellReuseIdentifier:@"cell"];
    [myTab registerClass:[AAtwoTableViewCell class] forCellReuseIdentifier:@"twocell"];
    [myTab registerClass:[AAyiyuanthreeTableViewCell class] forCellReuseIdentifier:@"threecell"];
    
    myTab.tableFooterView = [[UIView alloc] init];
    [myTab setSeparatorInset:UIEdgeInsetsZero];
    [myTab setLayoutMargins:UIEdgeInsetsZero];
    
    [self.view addSubview:myTab];
    
    UIView * mydownView = [[UIView alloc] initWithFrame:CGRectMake(0, wScreenH-49-64, wScreenW, 49)];
    [self.view addSubview:mydownView];
    
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 0.5)];
    lab.backgroundColor = wGrayColor2;
    lab.alpha =0.3;
    [mydownView addSubview:lab];
    
    UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW/2,0,0.5, 49)];
    lab1.backgroundColor = wGrayColor2;
    lab1.alpha=0.3;
    [mydownView addSubview:lab1];
    
    CGFloat wwww = (wScreenW/2-40+16)/2;
    UIButton * myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    myBtn.frame = CGRectMake(0, 0, wScreenW/2, 40);
    [myBtn addTarget:self action:@selector(duibi:) forControlEvents:UIControlEventTouchUpInside];
    myBtn.tag=200;
    [myBtn setImage:[UIImage imageNamed:@"tel"] forState:UIControlStateNormal];
    
    [myBtn setImageEdgeInsets:UIEdgeInsetsMake(8, wwww, 8, wwww)];
    [mydownView addSubview:myBtn];
    
    UILabel * myLab = [[UILabel alloc] initWithFrame:CGRectMake(0,37, wScreenW/2, 9)];
    myLab.font = ZT12;
    myLab.textColor = wGrayColor2;
    
    myLab.textAlignment=1;
    myLab.text = @"电话";
    [mydownView addSubview:myLab];
    
//    myLab.center = CGPointMake(myBtn.center.x,CGRectGetMaxY(myBtn.frame)+8);
    
    UIButton * myBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    myBtn1.frame = CGRectMake( wScreenW/2 ,0, wScreenW/2, 40);
    [myBtn1 addTarget:self action:@selector(duibi:) forControlEvents:UIControlEventTouchUpInside];
    myBtn1.tag=300;
    [myBtn1 setImageEdgeInsets:UIEdgeInsetsMake(8, wwww, 8, wwww)];

    [myBtn1 setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e63e", 25, wRedColor)] forState:UIControlStateNormal];
    
    [mydownView addSubview:myBtn1];
    
    UILabel * myLab1 = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW/2,37, wScreenW/2, 9)];
    myLab1.font = ZT12;
    myLab1.textColor = wGrayColor2;
    myLab1.textAlignment=1;
    myLab1.text = @"导航";
    [mydownView addSubview:myLab1];
    
//    myLab1.center = CGPointMake(myBtn1.center.x,CGRectGetMaxY(myBtn1.frame)+8);
    
    
    
}

-(void)duibi:(UIButton*)btn
{
    if (btn.tag==200)
    {
//        if ([WBYRequest isMobileNumber:self.myDataModel.tel])
//        {
//            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你确定要拨打电话吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//            [view show];
//            
//        }else
//        {
//            [WBYRequest showMessage:@"暂无电话"];
//            return;
//        }
        
        [self callPhone:_myDataModel.tel];
    }else
    {
        if (_myDataModel.point.length<1)
        {
            [WBYRequest showMessage:@"地址不详无法导航"];
        }else
        {
            NSArray * arr = [_myDataModel.point componentsSeparatedByString:@","] ;
            CLLocationCoordinate2D coor;
            coor.latitude = [[arr lastObject] floatValue];
            coor.longitude = [[arr firstObject] floatValue];
            MKMapItem *currentLocation =[MKMapItem mapItemForCurrentLocation];
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coor addressDictionary:nil]];
            toLocation.name = _myDataModel.name;
            [MKMapItem openMapsWithItems:@[currentLocation,toLocation] launchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey:[NSNumber numberWithBool:YES]}];
        }
    }
}

//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 )
    {
        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",self.myDataModel.tel];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return lArr.count;
    }else
    {
        return 1;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        AAyiyuanxiangqingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lLab.text = lArr[indexPath.row];
        cell.rLab.text = rArr[indexPath.row];
        
        return cell;
    }else
    {
        
        NSArray * arr = [_myDataModel.point componentsSeparatedByString:@","] ;
        
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude = [[arr lastObject] floatValue];
        coor.longitude = [[arr firstObject] floatValue];
        
        annotation.coordinate = coor;
        annotation.title = _myDataModel.addr;
        
        
        AAtwoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"twocell" forIndexPath:indexPath];
        cell.aLab.textColor = wBlackColor;
        cell.aLab.text = @"位置及周边";
        cell.myView.delegate = self;
        cell.myView.zoomLevel = 17.f;
        cell.myView.zoomEnabled=YES;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.myView addAnnotation:annotation];
        [cell.myView setCenterCoordinate:coor];
        
        return cell;
   
      }
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        return 49;
    }else
    {
        return 260;
    }
   }

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view =[UIView new];
    view.backgroundColor = wBaseColor;
    view.alpha = 0.6;
    view.frame = CGRectMake(0, 0, wScreenW, 10);
    return view;
    
}


#pragma markk===地图

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]])
    {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        //        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        //        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        
        [newAnnotationView setSelected:YES animated:NO];
        return newAnnotationView;
    }
    return nil;
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
