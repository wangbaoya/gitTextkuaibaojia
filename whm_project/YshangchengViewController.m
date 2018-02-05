//
//  YshangchengViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/6/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "YshangchengViewController.h"
#import "LoginViewController.h"
#import "ShangchengOneTableViewCell.h"
#import "ShangchengTwoTableViewCell.h"
#import "ShangchengdetileViewController.h"
#import "zhonganViewController.h"
@interface YshangchengViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * myTab;
    NSArray * oneData;
    NSMutableArray * twoData;

    NSArray * textArr;
    NSArray * urlArr;
    NSInteger numindex;

}

@end

@implementation YshangchengViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"商城";
    oneData = [NSArray array];
    twoData = [NSMutableArray array];
//    [self creatLeftTtem];
    
    [self requestdata:YES];
    [self requestdata:NO];
    
    numindex=1;
    [self creatui];

}

-(void)creatui
{
    
//    UIView * midView = [[UIView alloc] initWithFrame:CGRectMake(0,0, wScreenW, 75+7.5+7.5+40)];
//    midView.backgroundColor = JIANGEcolor;
//    
//        [self.view addSubview:midView];
//
    
    
//   NSArray * imgArr = @[@"\U0000e604",@"\U0000e60b",@"\U0000e601",@"\U0000e600"];
    
     NSArray * imgArr = @[@"yiwaixian",@"lvyouxian",@"shaoerxian",@"quanbu"];
    
//    textArr = @[@"意外险",@"旅游险",@"少儿险",@"全部"];
    
    textArr = @[@"车险",@"意外无忧",@"疾病无忧",@"医疗无忧"];

    
    urlArr = @[@"https://ztg.zhongan.com/promote/entrance/promoteEntrance.do?redirectType=h5&promotionCode=INST170644411037&productCode=PRD160596095002&promoteCategory=single_product&token=",@"https://ztg.zhongan.com/promote/showcase/landingH5.htm?promoteType=2&promotionCode=INST170506544009&redirectType=h5",@"https://ztg.zhongan.com/promote/showcase/landingH5.htm?promoteType=2&promotionCode=INST170537965011&redirectType=h5",@"https://ztg.zhongan.com/promote/showcase/landingH5.htm?promoteType=2&promotionCode=INST170503665010&redirectType=h5"];
    
//    NSArray * coloArr = @[wWhiteColor,wWhiteColor,wWhiteColor,wWhiteColor];
    
    CGFloat ww = wScreenW/4;

    
    UIView * fiveBtnview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 75)];
    fiveBtnview.backgroundColor = SHENLANSEcolor;
//    [midView addSubview:fiveBtnview];
    
    for (NSInteger i=0; i<imgArr.count; i++)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(ww * (i%imgArr.count),0, ww, 75*0.65);
        [btn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        btn.tag = 5858 + i;
        [btn addTarget:self action:@selector(jinru:) forControlEvents:UIControlEventTouchUpInside];
        [fiveBtnview addSubview:btn];
    }
    
    for (NSInteger i=0; i<textArr.count; i++)
    {
        UILabel * aLab = [UILabel new];
        aLab.frame =  CGRectMake(ww * (i%textArr.count),75*0.65-10, ww, 75*0.35+5);
        aLab.font = ZT14;
        aLab.textAlignment = 1;
        aLab.text = textArr[i];
        aLab.textColor = wWhiteColor;
        [fiveBtnview addSubview:aLab];
    }
    
    
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, wScreenW, wScreenH-64-49) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    myTab.separatorColor = FENGEXIANcolor;
    myTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [myTab registerClass:[ShangchengOneTableViewCell class] forCellReuseIdentifier:@"onecell"];
    [myTab registerClass:[ShangchengTwoTableViewCell class] forCellReuseIdentifier:@"twocell"];
    
    myTab.tableHeaderView = fiveBtnview;
    [myTab setSeparatorInset:UIEdgeInsetsZero];
    [myTab setLayoutMargins:UIEdgeInsetsZero];
    
    
    myTab.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    myTab.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
    

    [self.view addSubview:myTab];
    
    
}
#pragma mark===加载

-(void)headerRereshing
{
    numindex = 1 ;
    
    [self requestdata:NO];
    [myTab.mj_header endRefreshing];
    
}
//下拉
-(void)footerRefreshing
{
    numindex ++ ;
    
    [self requestdata:NO];
    [myTab.mj_footer endRefreshing];
    
}

#pragma mark----代理事件
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return oneData.count;
    }else
    {
        return twoData.count;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section

{
    
    UIView * downView;
    UIButton * remenLab;
    
    if (!downView)
    {
        downView = [[UIView alloc] initWithFrame:CGRectMake(0,5, wScreenW, 45)];
        downView.backgroundColor = wWhiteColor;
        
         remenLab = [UIButton buttonWithType:UIButtonTypeCustom];
        remenLab.frame = CGRectMake(0, 0, 90, 50);
       
        
        remenLab.titleLabel.font = Font(18);
        [remenLab setTitleColor:RGBwithColor(64, 64, 64) forState:UIControlStateNormal];
        [remenLab addTarget:self action:@selector(remen) forControlEvents:UIControlEventTouchUpInside];
        
        [downView addSubview:remenLab];
        
        
        remenLab.center = CGPointMake(self.view.center.x,50/2+8);
        
        UILabel * llab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW/2-45-70, 50/2+8, 70, 1)];
        llab.backgroundColor = FENGEXIANcolor;
        [downView addSubview:llab];
        
        UILabel * rlab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW/2+45, 50/2+8, 70, 1)];
        rlab.backgroundColor = FENGEXIANcolor;
        [downView addSubview:rlab];
   
    }
    if (section==0)
    {
        [remenLab setTitle:@"新品上市" forState:UIControlStateNormal];

    }else
    {
        UILabel * rlab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 10)];
        rlab.backgroundColor = JIANGEcolor;
        [downView addSubview:rlab];
    [remenLab setTitle:@"热销产品" forState:UIControlStateNormal];
 
    }
  
    return downView;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0)
    {
        return 80;
    }else
    {
        return (wScreenW-20)/2+70;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return 50;
    }else
    {
        return 50;
    }

    
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        
        ShangchengOneTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"onecell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        DataModel * model = oneData[indexPath.row];
        AttrsModel * aModel = [model.attrs firstObject];
        AttrsModel * bModel = [model.attrs lastObject];
        
        cell.midLab.text = [NSString stringWithFormat:@"%@:%@  %@:%@",aModel.name,aModel.val,bModel.name,bModel.val];
        
        cell.upLab.text = model.name?model.name:@"快保家";
        if (model.price.length>=1)
        {
        cell.downLab.text = [NSString stringWithFormat:@"￥%@ 起",model.price?model.price:@""];
        }else
        {
            cell.downLab.text = [NSString stringWithFormat:@"暂无"];
        }
        
        [cell.myImg sd_setImageWithURL:[NSURL URLWithString:model.header_img] placeholderImage:[UIImage imageNamed:@"shangcheng"]];
        
        return cell;
    }else
    {
        ShangchengTwoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"twocell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        DataModel * model = twoData[indexPath.row];

        AttrsModel * aModel = [model.attrs firstObject];
        AttrsModel * bModel = [model.attrs lastObject];
        
        cell.downLab.text = [NSString stringWithFormat:@"%@:%@  %@:%@",aModel.name,aModel.val,bModel.name,bModel.val];
        cell.upLab.text = model.name?model.name:@"快保家";;
        
        if (model.price.length>=1)
        {
            cell.midLab.text = [NSString stringWithFormat:@"￥%@ 起",model.price];
        }else
        {
          cell.midLab.text = [NSString stringWithFormat:@"暂无"];
        }
        
        [cell.myImg sd_setImageWithURL:[NSURL URLWithString:model.header_img] placeholderImage:[UIImage imageNamed:@"shangcheng"]];
        return cell;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ShangchengdetileViewController * shangcheng = [ShangchengdetileViewController new];
    if (indexPath.section==0)
    {
        DataModel * model = oneData[indexPath.row];
        shangcheng.myId = model.id;
    }else
    {
        DataModel * model = twoData[indexPath.row];
        shangcheng.myId = model.id;
    }
    
    [self.navigationController pushViewController:shangcheng animated:YES];
    
}



-(void)jinru:(UIButton*)btn
{
//    zhonganViewController * zhongan = [zhonganViewController new];
//    zhongan.str = urlArr[btn.tag-5858];
//    zhongan.tittle = textArr[btn.tag-5858];
//    [self.navigationController pushViewController:zhongan animated:YES];
}

-(void)remen
{
    
    
}

-(void)requestdata:(BOOL)isxinpin
{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setObject:@"0" forKey:@"yun_id"];
    
    if (isxinpin==YES)
    {
        [dic setObject:@"1" forKey:@"new_sort"];
        
        [dic setObject:@"2" forKey:@"pagesize"];
        
    }else
    {
        [dic setObject:@"1" forKey:@"rec_sort"];
        
         [dic setObject:[NSString stringWithFormat:@"%ld",numindex] forKey:@"p"];
        [dic setObject:@"10" forKey:@"pagesize"];
        
    }
//    WS(weakSelf);
    [WBYRequest wbyPostRequestDataUrl:@"get_tpl" addParameters:dic success:^(WBYReqModel *model)
    {
      
            if (isxinpin==YES)
            {
                if ([model.err isEqualToString:TURE])
                {
                oneData = model.data;
                }
            }else
            {
                if ([model.err isEqualToString:TURE])
                {
                    
                if (numindex==1)
                {
                    [twoData removeAllObjects];
                }
                
                [twoData addObjectsFromArray:model.data];
                
                }else if ([model.err isEqualToString:@"1400"])
                {
                    
                    [WBYRequest showMessage:model.info];
                }
            }
    
        
        [myTab reloadData];
    } failure:^(NSError *error)
    {
        
    } isRefresh:NO];
    
}




@end
