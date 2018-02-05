//
//  AAdailirendituViewController.m
//  whm_project
//
//  Created by apple on 17/4/17.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "AAdailirendituViewController.h"
#import "YWPointAnnotation.h"
#import "YWRoundAnnotationView.h"
#import "AAwbyZiDingYiView.h"
#import "WeizhanViewController.h"

@interface AAdailirendituViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    BMKMapView * _mapView;
    BMKLocationService * _locService;
    NSArray * allArray;
    UIView * downView;
    NSMutableDictionary * alldic;
    CGFloat juliDistance;
    NSString * oldCity;
    NSString * myUid;
}
@end

@implementation AAdailirendituViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"位置";
    
    allArray = [NSArray array];
    alldic = [NSMutableDictionary dictionary];
    [self creatrequest:CHENGSHI];
    juliDistance = 50;

    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, wScreenW,wScreenH-64)];
    [_mapView setZoomLevel:13.0f];
    _mapView.delegate = self;
    _mapView.zoomEnabled=YES;
    //罗盘态
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    
    _mapView.isSelectedAnnotationViewFront = YES;
    _mapView.showMapScaleBar = YES;
    [self.view addSubview:_mapView];
    
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    [self creatLeftTtem];
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    
    [_locService stopUserLocationService];
    
}

- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
//    for (NSInteger i=0; i < 200; i++)
//    {
//        UILabel * lab = [self.view viewWithTag:1000+i];
//        lab.textColor = ZTCOlor;
//    }
    juliDistance = mapView.visibleMapRect.size.width/2000;

    [downView removeFromSuperview];
}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    
    WS(weakSelf);
    
    BMKCoordinateRegion region;
    CLLocationCoordinate2D centerCoordinate = mapView.region.center;
    region.center= centerCoordinate;
    
    CLGeocoder * geocoder = [[CLGeocoder alloc] init];

    CLLocation *location = [[CLLocation alloc]initWithLatitude:centerCoordinate.latitude longitude:centerCoordinate.longitude];
    [geocoder reverseGeocodeLocation: location completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count > 0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
             
             [_locService stopUserLocationService];
             
                 if (![oldCity isEqualToString:placemark.locality])
                 {
                     NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
                     [_mapView removeAnnotations:array];
                     [weakSelf creatrequest:placemark.locality?placemark.locality:CHENGSHI];
                 }
             
             oldCity = placemark.locality;
         }
     }];
 }


-(void)creatrequest:(NSString*)chengshi
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
   
    [dic setObject:chengshi forKey:@"cityn"];
    
    [dic setObject:[NSString stringWithFormat:@"%lf",juliDistance] forKey:@"distance"];
    [dic setObject:@"1" forKey:@"p"];
    [dic setObject:@"50" forKey:@"pagesize"];
    
    
    WS(weakSelf);
    [WBYRequest wbyPostRequestDataUrl:@"near_agent" addParameters:dic success:^(WBYReqModel *model)
     {
         if ([model.err isEqualToString:TURE])
         {
             allArray = model.data;
             [weakSelf zhanshidatouzhen];
         }else
         {
             [WBYRequest showMessage:model.info];
         }
    } failure:^(NSError *error) {
         
     } isRefresh:NO];
}

-(void)zhanshidatouzhen
{
    for (DataModel * mod in allArray)
    {
        NSArray * arr = [mod.point componentsSeparatedByString:@","];
        
        YWPointAnnotation * item = [[YWPointAnnotation alloc] init];
        
        CLLocationCoordinate2D pt;
        pt.longitude = [[arr firstObject] floatValue];
        pt.latitude = [[arr lastObject] floatValue];
        item.coordinate = pt;
        
        item.title = mod.name;
        
        [alldic setObject:mod.avatar?mod.avatar:@"" forKey:@"avatar"];
        [alldic setObject:mod.name forKey:@"biaoti"];
        
        [alldic setObject:mod.uid?mod.uid:@"" forKey:@"uid"];

        [alldic setObject:mod.oname?mod.oname:@"暂无" forKey:@"dizhi"];
        NSString * myjuli;
        if ([mod.dist floatValue]<1000)
        {
            myjuli = [NSString stringWithFormat:@"%.2fM",[mod.dist floatValue]];
        }else
        {
            myjuli = [NSString stringWithFormat:@"%.2fKM",[mod.dist floatValue]/1000];
        }
        [alldic setObject:[NSString stringWithFormat:@"%@",myjuli] forKey:@"juli"];
        [alldic setObject:mod.mobile?mod.mobile:@"" forKey:@"mobile"];
        [alldic setObject:mod.point?mod.point:@"" forKey:@"point"];

        item.titlelable =[self dictionaryToJson:alldic];
        [_mapView addAnnotation:item];
    }
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[YWPointAnnotation class]])
    {
        AAwbyZiDingYiView * newAnnotationView =(AAwbyZiDingYiView*)[_mapView dequeueReusableAnnotationViewWithIdentifier:@"myAnnotation"];
        if (newAnnotationView==nil)
        {
            newAnnotationView=[[AAwbyZiDingYiView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        }
        
        YWPointAnnotation* aawannotation=(YWPointAnnotation*)annotation;
        
        newAnnotationView.titleText  = [NSString stringWithFormat:@"%@",aawannotation.title];

        newAnnotationView.mytittle = aawannotation.titlelable;
        for (NSInteger i=0; i < mapView.annotations.count; i++)
        {
            newAnnotationView.titleLable.tag = 1000 + i;
        }
        
        newAnnotationView.canShowCallout = NO;
        newAnnotationView.draggable = NO;
        
        return newAnnotationView;
        
    }
    return nil;

    
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    
    if ([view isKindOfClass:[AAwbyZiDingYiView class]]){
        [downView removeFromSuperview];
        
        AAwbyZiDingYiView * cusView = (AAwbyZiDingYiView *)view;
        
        for (NSInteger i=0; i < 200; i++)
        {
            UILabel * lab = [self.view viewWithTag:1000+i];
            lab.textColor = ZTCOlor;
        }
        
        cusView.titleLable.textColor = wRedColor;
        
        CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //设置抖动幅度
        shake.fromValue = [NSNumber numberWithFloat:+0.1];
        shake.toValue = [NSNumber numberWithFloat:-0.1];
        shake.duration = 0.1;
        shake.autoreverses = YES; //是否重复
        shake.repeatCount = 4;
        
        [cusView.titleLable.layer addAnimation:shake forKey:nil];
        
        NSDictionary * dic = [self dictionaryWithJsonString:cusView.mytittle];
        
        DataModel * model = [[DataModel alloc] initWithDictionary:dic error:nil];
        CGFloat hh = 80;
        CGFloat hh1 = 10;
        CGFloat hh2 = hh - hh1 * 2;
        CGFloat lithhh =(hh-20)/3;
        
        NSArray * arr = [model.point componentsSeparatedByString:@","] ;
        CLLocationCoordinate2D coor;
        coor.latitude = [[arr lastObject] floatValue];
        coor.longitude = [[arr firstObject] floatValue];
        
        [mapView setCenterCoordinate:coor animated:YES];
        
        downView = [[UIView alloc] initWithFrame:CGRectMake(0, wScreenH-80-64, wScreenW, 80)];
        
        [self.view addSubview:downView];
        
        [UIView animateWithDuration:0.6 animations:^{
            
            downView.frame =CGRectMake(0, wScreenH-64-80, wScreenW, 80);
            
        }];
        
        NSLog(@"===%@",model.uid);

        myUid = model.uid;
        
        UIButton * upView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 80)];
        
        upView.backgroundColor = wWhiteColor;
        
        [upView addTarget:self action:@selector(jinruxiangqing) forControlEvents:UIControlEventTouchUpInside];
        
        [downView addSubview:upView];
        
        
        
        UIButton * imgBut = [UIButton buttonWithType:UIButtonTypeCustom];
        imgBut.frame = CGRectMake(hh1, hh1, hh2, hh2);
        imgBut.layer.masksToBounds = YES;
        imgBut.layer.cornerRadius = hh2/2;
        
        [imgBut sd_setImageWithURL:[NSURL URLWithString:model.avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"city"]];
        [upView addSubview:imgBut];
        
        UILabel * titLaber = [[UILabel alloc] init];
        titLaber.frame = CGRectMake(CGRectGetMaxX(imgBut.frame)+10, hh1,wScreenW-20-hh2, lithhh);
        titLaber.font = ZT14;
        titLaber.text = model.biaoti;
        
        [upView addSubview:titLaber];
        
        UILabel * addressLaber = [[UILabel alloc]init];
        addressLaber.frame = CGRectMake(CGRectGetMinX(titLaber.frame), CGRectGetMaxY(titLaber.frame), CGRectGetWidth(titLaber.frame), lithhh);
        addressLaber.textColor = QIANZITIcolor;
        addressLaber.font = ZT12;
        addressLaber.text = model.dizhi;
        [upView addSubview:addressLaber];
        
        
        UIImageView * mapImg = [[UIImageView alloc]init];
        mapImg.frame = CGRectMake(CGRectGetMinX(addressLaber.frame), CGRectGetMaxY(addressLaber.frame)+4, lithhh-8, lithhh-8);
 mapImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e60f", 25, HUITUColor)];        [upView addSubview:mapImg];
        
        UILabel * mapLaber = [[UILabel alloc] init];
        mapLaber.frame = CGRectMake(CGRectGetMaxX(mapImg.frame)+5, CGRectGetMaxY(addressLaber.frame),70, lithhh);
        mapLaber.textColor = QIANZITIcolor;
        mapLaber.font = ZT12;
        mapLaber.text = model.juli;
        [upView addSubview:mapLaber];
        
        UIImageView * telImg =  [[UIImageView alloc] init];
        telImg.frame = CGRectMake(CGRectGetMaxX(mapLaber.frame)+10, CGRectGetMinY(mapImg.frame), CGRectGetWidth(mapImg.frame), CGRectGetHeight(mapImg.frame));
        
telImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e628",25,DianhuaColor)];
        
        [upView addSubview:telImg];
        
        
        UILabel * myLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(telImg.frame)+5, CGRectGetMaxY(addressLaber.frame),150,lithhh)];
        myLab.font = ZT12;
        myLab.text = model.mobile;
        myLab.textColor = DianhuaColor;
        [upView addSubview:myLab];
        
    }
    
   }


-(void)jinruxiangqing
{
     
    WeizhanViewController * weizhan = [WeizhanViewController new];
    weizhan.agentId = myUid;
    
    [self.navigationController pushViewController:weizhan animated:YES];
    
    
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
