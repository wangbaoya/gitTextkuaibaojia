//
//  AAwangdianViewController.m
//  whm_project
//
//  Created by apple on 17/4/27.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "AAwangdianViewController.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import "YWRoundAnnotationView.h"
#import "YWPointAnnotation.h"
#import <BaiduMapAPI_Utils/BMKGeometry.h>
#import "AAwbyZiDingYiView.h"
#import "AAjigouxiangqingViewController.h"


@interface AAwangdianViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    NSMutableArray * bigArray;
    BMKMapView * _mapView;
    BMKLocationService * _locService;
    NSString * chengshiStr;
    NSString * oldCity;
    
    CLLocationCoordinate2D oldCenterCoordinate;
    
    UIView * downView;
    
    BOOL isQingqiu;
    CGFloat juliDistance;

    
    DataModel * mymodel;

}


@end

@implementation AAwangdianViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"位置";
    [self creatLeftTtem];
    [self creatmapview];
    bigArray = [NSMutableArray array];
    chengshiStr = CHENGSHI;
    
    [self requestdata:CHENGSHI];
    isQingqiu = YES;
    juliDistance = 10;
    [self creatLeftTtem];
    
}
-(void)creatmapview
{
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, wScreenW,wScreenH-64)];
    [_mapView setZoomLevel:12.0f];
    _mapView.delegate = self;
    _mapView.zoomEnabled=YES;
    //罗盘态
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    _mapView.mapType = BMKMapTypeStandard;
    _mapView.isSelectedAnnotationViewFront = YES;
    _mapView.showMapScaleBar = YES;
    
    [self.view addSubview:_mapView];
    
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    
    [_locService stopUserLocationService];
    
}
- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    for (NSInteger i=0; i < 200; i++)
    {
        UILabel * lab = [self.view viewWithTag:1000+i];
        lab.textColor = ZTCOlor;
    }

    [downView removeFromSuperview];
    
}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    WS(weakSelf);
    NSLog(@"====%lf", mapView.visibleMapRect.size.width);
    
    juliDistance = mapView.visibleMapRect.size.width/2000;
   
    NSLog(@"====%lf", juliDistance);
    

    BMKCoordinateRegion region;
    CLLocationCoordinate2D centerCoordinate = mapView.region.center;
    region.center= centerCoordinate;
    
    CLGeocoder * geocoder = [[CLGeocoder alloc] init];
    
    BMKMapPoint point1 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(oldCenterCoordinate.latitude,oldCenterCoordinate.longitude));
    BMKMapPoint point2 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(centerCoordinate.latitude,centerCoordinate.longitude));
    
    CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
    
    //    [downView removeFromSuperview];
    CLLocation *location = [[CLLocation alloc]initWithLatitude:centerCoordinate.latitude longitude:centerCoordinate.longitude];
    
    oldCenterCoordinate = centerCoordinate;
    
    if (distance>10000)
    {
        isQingqiu = YES;
    }
    
    [geocoder reverseGeocodeLocation: location completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count > 0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
             chengshiStr = placemark.locality;
             
             [_locService stopUserLocationService];
             
             if(mapView.zoomLevel<13)
             {
                 isQingqiu = YES;
                 
                 if (distance<10||![oldCity isEqualToString:placemark.locality])
                 {
                     NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
                     [_mapView removeAnnotations:array];
                     [weakSelf requestdata:placemark.locality];
                 }
                 
             } else
             {
                 if (isQingqiu==YES)
                 {
                     if (distance>5000||distance<10)
                     {
                         NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
                         [_mapView removeAnnotations:array];
                         [weakSelf requestcountyStr:[NSString stringWithFormat:@"%lf",centerCoordinate.latitude]lon:[NSString stringWithFormat:@"%lf",centerCoordinate.longitude]];
                     }
                 }
             }
              oldCity = placemark.locality;
         }
     }];
}





-(void)requestdata:(NSString*)str
{
    WS(weakSelf);
    
    [bigArray removeAllObjects];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setObject:str?str:@"" forKey:@"cityn"];
    
    [WBYRequest wbyPostRequestDataUrl:@"org_count" addParameters:dic success:^(WBYReqModel *model) {
        
        if ([model.err isEqualToString:TURE])
        {
            [bigArray addObjectsFromArray:model.data];
            [weakSelf addPoint];
        }else
        {
            [WBYRequest showMessage:model.info];
        }
        
    } failure:^(NSError *error) {
        
    } isRefresh:YES];
    
    
}

-(void)addPoint
{
    for (DataModel * mod in bigArray)
    {
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        //        coor = _mapView.centerCoordinate;
        coor.longitude = [mod.lng floatValue];
        coor.latitude = [mod.lat floatValue];
        annotation.coordinate = coor;
        annotation.title=mod.name;
        annotation.subtitle = mod.mycount;
        [_mapView addAnnotation:annotation];
        
    }
}

-(void)requestcountyStr:(NSString *)lat lon:(NSString *)longgggg
{
    WS(weakSelf);
    [bigArray removeAllObjects];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:longgggg forKey:@"lng"];
    
    [dic setObject:lat forKey:@"lat"];
    [dic setObject:[NSString stringWithFormat:@"%lf",juliDistance] forKey:@"distance"];
    //公司类型
    
    [dic setObject:@"" forKey:@"type"];
    [dic setObject:@"" forKey:@"cate"];
    [dic setObject:@"" forKey:@"keyword"];
    
    [dic setObject:@"" forKey:@"prov"];
    [dic setObject:@"" forKey:@"city"];
    [dic setObject:@"" forKey:@"county"];
    [dic setObject:@"1" forKey:@"p"];
    [dic setObject:@"50" forKey:@"pagesize"];
    
    [WBYRequest wbyPostRequestDataUrl:@"near_org" addParameters:dic success:^(WBYReqModel *model)
     {
         if ([model.err isEqualToString:TURE])
         {
             [bigArray addObjectsFromArray:model.data];
             [weakSelf addsecond];
             
         }else
         {
             [WBYRequest showMessage:model.info];
         }
         
     } failure:^(NSError *error) {
         
     } isRefresh:NO];
    
}

-(void)addsecond
{
    for (DataModel * mod in bigArray)
    {
        
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        YWPointAnnotation * item = [[YWPointAnnotation alloc] init];
        
        NSArray * arr = [mod.point componentsSeparatedByString:@","] ;
        CLLocationCoordinate2D coor;
        coor.latitude = [[arr lastObject] floatValue];
        coor.longitude = [[arr firstObject] floatValue];
        item.coordinate = coor;
        item.title = mod.shortn;
        
        [dic setObject:mod.shortn?mod.shortn:@"暂无" forKey:@"shortn"];
        [dic setObject:mod.logo?mod.logo:@"" forKey:@"logo"];
        [dic setObject:mod.addr?mod.addr:@"暂无" forKey:@"addr"];
        [dic setObject:mod.tel?mod.tel:@"暂无" forKey:@"tel"];
        [dic setObject:mod.point?mod.point:@"暂无" forKey:@"point"];

        [dic setObject:mod.b_date?mod.b_date:@"暂无" forKey:@"b_date"];
        [dic setObject:mod.prin?mod.prin:@"暂无" forKey:@"prin"];
        [dic setObject:mod.cate?mod.cate:@"暂无" forKey:@"cate"];
        [dic setObject:mod.ctype?mod.ctype:@"暂无" forKey:@"ctype"];
        [dic setObject:mod.r_addr?mod.r_addr:@"暂无" forKey:@"r_addr"];
        [dic setObject:mod.cond?mod.cond:@"暂无" forKey:@"cond"];
        
        
        NSString * myjuli;
        if ([mod.dist floatValue]<1000)
        {
            myjuli = [NSString stringWithFormat:@"%.2fM",[mod.dist floatValue]];
        }else
        {
            myjuli = [NSString stringWithFormat:@"%.2fKM",[mod.dist floatValue]/1000];
        }
        [dic setObject:[NSString stringWithFormat:@"%@",myjuli] forKey:@"dist"];
        
       
        
        item.titlelable =[self dictionaryToJson:dic];
        
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
        // newAnnotationView.calloutView.backgroundColor = [UIColor redColor];
        
        YWPointAnnotation* Newannotation=(YWPointAnnotation*)annotation;
        
        newAnnotationView.titleText=[NSString stringWithFormat:@"%@",Newannotation.title];
        
        newAnnotationView.mytittle = Newannotation.titlelable;
        
        for (NSInteger i=0; i < mapView.annotations.count; i++)
        {
            newAnnotationView.titleLable.tag = 1000 + i;
            
        }
        
        newAnnotationView.canShowCallout = NO;
        newAnnotationView.draggable = NO;
        
        return newAnnotationView;
        
    }else if ([annotation  isKindOfClass:[ BMKPointAnnotation class]])
    {
        
        YWRoundAnnotationView *newAnnotationView =(YWRoundAnnotationView*)[_mapView dequeueReusableAnnotationViewWithIdentifier:@"RoundmyAnnotation"];
        
        if (newAnnotationView==nil)
        {
            newAnnotationView=[[ YWRoundAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"RoundmyAnnotation"];
        }
        
        BMKPointAnnotation* Newannotation=(BMKPointAnnotation*)annotation;
        newAnnotationView.titleText=[NSString stringWithFormat:@"%@",Newannotation.title];
        
        newAnnotationView.countText=Newannotation.subtitle;
        newAnnotationView.canShowCallout = NO;
        newAnnotationView.draggable = YES;
        
        return newAnnotationView;
        
    }
    return nil;
    
}


- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    [downView removeFromSuperview];
    
    if ([view isKindOfClass:[YWRoundAnnotationView class]])//点击圆形标注
    {
        _mapView.zoomLevel = 15;
        
    }
    else if ([view isKindOfClass:[AAwbyZiDingYiView class]])
    {
        isQingqiu = NO;
        
        AAwbyZiDingYiView * cusView = (AAwbyZiDingYiView *)view;
        
        NSDictionary * dic = [self dictionaryWithJsonString:cusView.mytittle];
        
        DataModel * model = [[DataModel alloc] initWithDictionary:dic error:nil];
        mymodel = model;

        NSArray * arr = [model.point componentsSeparatedByString:@","] ;
        CLLocationCoordinate2D coor;
        coor.latitude = [[arr lastObject] floatValue];
        coor.longitude = [[arr firstObject] floatValue];
        [mapView setCenterCoordinate:coor animated:YES];
        

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
       
        NSLog(@"===%@",cusView.mytittle);
        CGFloat hh = 80;
        CGFloat hh1 = 10;
        CGFloat hh2 = hh - hh1 * 2;
        CGFloat lithhh =(hh-20)/3;
        
        downView = [[UIView alloc] initWithFrame:CGRectMake(0, wScreenH-64, wScreenW, 80)];
        downView.userInteractionEnabled = YES;
        [self.view addSubview:downView];
        [UIView animateWithDuration:0.6 animations:^{
            
            downView.frame =CGRectMake(0, wScreenH-64-80, wScreenW, 80);
            
        }];
        
        
        NSLog(@"===%@",model.id);
        
        
        UIButton * upView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 80)];
        upView.backgroundColor = wWhiteColor;
        [upView addTarget:self action:@selector(jinruxiangqing) forControlEvents:UIControlEventTouchUpInside];
        [downView addSubview:upView];
        
        UIButton * imgBut = [UIButton buttonWithType:UIButtonTypeCustom];
        imgBut.frame = CGRectMake(hh1, hh1, hh2, hh2);
        imgBut.layer.masksToBounds = YES;
        imgBut.layer.cornerRadius = hh2/2;
        
        [imgBut sd_setImageWithURL:[NSURL URLWithString:model.logo] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"city"]];
        [upView addSubview:imgBut];
        
        UILabel * titLaber = [[UILabel alloc] init];
        titLaber.frame = CGRectMake(CGRectGetMaxX(imgBut.frame)+10, hh1,wScreenW-20-hh2, lithhh);
        titLaber.font = ZT14;
        titLaber.text = model.shortn;
        titLaber.textColor = wBlackColor;
        [upView addSubview:titLaber];
        
        UILabel * addressLaber = [[UILabel alloc]init];
        addressLaber.frame = CGRectMake(CGRectGetMinX(titLaber.frame), CGRectGetMaxY(titLaber.frame), CGRectGetWidth(titLaber.frame), lithhh);
        addressLaber.textColor = QIANZITIcolor;
        addressLaber.font = ZT12;
        addressLaber.text = model.addr;
        [upView addSubview:addressLaber];
        
        
        UIImageView * mapImg = [[UIImageView alloc]init];
        mapImg.frame = CGRectMake(CGRectGetMinX(addressLaber.frame), CGRectGetMaxY(addressLaber.frame)+4, lithhh-8, lithhh-8);
       mapImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e60f", 25, HUITUColor)];
        
        [upView addSubview:mapImg];
        
        UILabel * mapLaber = [[UILabel alloc] init];
        mapLaber.frame = CGRectMake(CGRectGetMaxX(mapImg.frame)+5, CGRectGetMaxY(addressLaber.frame),70, lithhh);
        mapLaber.textColor = QIANZITIcolor;
        mapLaber.font = ZT12;
        mapLaber.text = model.dist;
        [upView addSubview:mapLaber];
        
        UIImageView * telImg =  [[UIImageView alloc] init];
        telImg.frame = CGRectMake(CGRectGetMaxX(mapLaber.frame)+10, CGRectGetMinY(mapImg.frame), CGRectGetWidth(mapImg.frame), CGRectGetHeight(mapImg.frame));
   telImg.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e628",25,DianhuaColor)];
        [upView addSubview:telImg];
        
        
        UILabel * myLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(telImg.frame)+5, CGRectGetMaxY(addressLaber.frame),150,lithhh)];
        myLab.font = ZT12;
        myLab.text = model.tel;
        myLab.textColor = DianhuaColor;
        [upView addSubview:myLab];
        
    }
    
    
    
}

-(void)jinruxiangqing
{
    
//    WS(weakSelf);
//    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    [dic setObject:myid?myid:@"" forKey:@"org_id"];
//
//    [WBYRequest wbyPostRequestDataUrl:@"get_org_detail" addParameters:dic success:^(WBYReqModel *model)
//     {
//         if ([model.err isEqualToString:TURE])
//         {
             AAjigouxiangqingViewController * jigou = [AAjigouxiangqingViewController new];
             jigou.myDataModel = mymodel;
            jigou.gongsimingzi = 666;
             [self.navigationController pushViewController:jigou animated:YES];
//         }
//         
//     } failure:^(NSError *error){
//         
//     } isRefresh:YES];
//    
//
//    
    
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
