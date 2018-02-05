
//
//  LishiSousuoViewController.m
//  com.fastprotecthome.iphoneformal
//
//  Created by apple on 17/5/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "LishiSousuoViewController.h"
#import "PlayVcEverLike.h"
#import "LishiTableViewCell.h"

@interface LishiSousuoViewController ()<UISearchBarDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UISearchBar * _searchBar;
    UIImageView * xiaoImg;
    UILabel * xiaolab;
    UIScrollView * myScroll;
    UIView * bigView;
    
    CGFloat aaa;
    UITableView * myTab;
    UIView * cView;
    
    NSArray * allArr;
    
    NSInteger index;
    
    NSArray * remensousuoArr;
    
    NSArray * resouArr;
    NSArray * fenleiArr;

}
@end

@implementation LishiSousuoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = wWhiteColor;
    index = 0;

    allArr = [NSArray array];
    remensousuoArr = [NSArray array];
    resouArr = [NSArray array];
    fenleiArr = [NSArray array];
    
    [self requesFenleiData];
    [self requestremenxianzhongData];
    [self requestresouguanjianziData];
    [self creatupview];
}

-(void)creatupview
{
    CGFloat ww = (wScreenW-100-20)/3;
    
    UIView * myview = [[UIView alloc] initWithFrame:CGRectMake(0, 20, wScreenW, 30)];
    
    [self.view addSubview:myview];
    
    NSArray * strArr = @[@"找险",@"热搜",@"分类"];
    for (NSInteger i=0; i<strArr.count; i++)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(60+ww * (i%3),0, ww,30);
       
        btn.tag = 5858 + i;
        [btn addTarget:self action:@selector(jinru:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:strArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:wBlackColor forState:UIControlStateNormal];
        [btn setTitleColor:QIANLANSEcolor forState:UIControlStateSelected];
        btn.titleLabel.font = Font(16);
        if (i==0)
        {
            btn.selected = YES;
        }
        [myview addSubview:btn];
    }
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(myview.frame), wScreenW, 35)];
    UIColor *color =  self.navigationController.navigationBar.barTintColor;
    [titleView setBackgroundColor:color];
    
    [self.view addSubview:titleView];
    
    
    UIButton * mybutton =[UIButton buttonWithType:UIButtonTypeCustom];
    mybutton.frame = CGRectMake(16, 5+5.5, 19, 19);
    
    [mybutton setBackgroundImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e60e", 25, wBlackColor)] forState:UIControlStateNormal];
    
    [mybutton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    
    [titleView addSubview:mybutton];
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(wScreenW-38-10,5, 38, 30);
    [button setTitle:@"搜索" forState:UIControlStateNormal];
    button.titleLabel.font = Font(15);
    [button setTitleColor:SHENLANSEcolor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(sousuoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:button];
    
    
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.delegate = self;
    _searchBar.frame = CGRectMake(60, 5, wScreenW-100-20, 30);
    _searchBar.backgroundColor = wWhiteColor;
    [_searchBar.layer setBorderWidth:0.3];
    [_searchBar.layer setBorderColor:QIANLANSEcolor.CGColor];  //设置边框为白色
    [_searchBar changeLeftPlaceholder:@" 请输入搜索内容"];
    [titleView addSubview:_searchBar];
    _searchBar.barTintColor = wWhiteColor;
   
    
    UIButton * myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    myBtn.frame = CGRectMake(wScreenW-60-30,5, 30, 30);
    
    [myBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e60c", 20,QIANLANSEcolor)] forState:UIControlStateNormal];
    myBtn.tag = 12345;
 //[myBtn addTarget:self action:@selector(onClickMyBtn) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:myBtn];
    
    
    
    UILabel * aLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(myBtn.frame) - 6 , 5+5, 1, 20)];
    aLab.backgroundColor = FENGEXIANcolor;
    
    [titleView addSubview:aLab];

    UITextField *searchField=[_searchBar valueForKey:@"_searchField"];
    searchField.borderStyle = UITextBorderStyleNone;
    searchField.backgroundColor = wWhiteColor;
    
    for (UIView * view in _searchBar.subviews)
    {
        for (id subview in view.subviews)
        {
            if ([subview isKindOfClass:[UITextField class]])
            {
                UITextField *textField = (UITextField *)subview;
                textField.clipsToBounds = NO;
                textField.leftView = nil;
            }
        }
    }
  
    xiaoImg = [[UIImageView alloc] initWithFrame:CGRectMake(60+ww/2-6.5,0, 13, 5)];
    xiaoImg.image = [UIImage imageNamed:@"sanjiao"];
    [titleView addSubview:xiaoImg];
    
     xiaolab = [[UILabel alloc] initWithFrame:CGRectMake(60+ww/2-6.5, 5, 13, 3)];
    xiaolab.backgroundColor = wWhiteColor;
    
    [titleView addSubview: xiaolab];
    
    
    [self creatbigView];
    
 }


-(void)creatbigView
{
    myScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0,85, wScreenW, wScreenH-85)];
    myScroll.bounces = NO;
    myScroll.delegate = self;
    myScroll.contentSize = CGSizeMake(wScreenW*3, wScreenH-85);
    //    myScroll.scrollEnabled = NO;
    myScroll.showsVerticalScrollIndicator = NO;
    myScroll.pagingEnabled = YES;
    
    myScroll.backgroundColor = JIANGEcolor;
    [self.view addSubview:myScroll];
    
    
//    if (remensousuoArr.count>=1)
//    {
//        
//        [self creatMyview:remensousuoArr];
//   
//    }
    
    [self creattab:0];
    
}

-(void)creattab:(NSUInteger)abcd
{
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(wScreenW*abcd,0, wScreenW, wScreenH - 85) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    myTab.separatorColor = FENGEXIANcolor;
    myTab.backgroundColor = JIANGEcolor;
    myTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [myTab registerClass:[LishiTableViewCell class] forCellReuseIdentifier:@"cell"];
    [myTab setSeparatorInset:UIEdgeInsetsZero];
    [myTab setLayoutMargins:UIEdgeInsetsZero];
    
    [myScroll addSubview:myTab];
    
}




-(void)creatMyview:(NSArray *)tarr
{
    
    bigView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, wScreenW, wScreenH-85)];
    bigView.backgroundColor = wWhiteColor;
    [myScroll addSubview:bigView];
    
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 40)];
    lab.text = [NSString stringWithFormat:@"  热门"];
    lab.font = ZHONGZITI;
    lab.textColor = wBlackColor;
    
    [bigView addSubview:lab];
    
    UIView * aView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lab.frame), wScreenW, 0.5)];
    aView.backgroundColor = FENGEXIANcolor;
    [bigView addSubview:aView];
    
    float butX = 15;
    float butY = CGRectGetMaxY(aView.frame)+10;
    for(int i = 0; i < tarr.count; i++)
    {
        
        DataModel * mod = tarr[i];
        //宽度自适应
        NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
        
        CGRect frame_W = [mod.name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
        
        if (butX+frame_W.size.width+20>wScreenW-15)
        {
            butX = 15;
            butY += 55;
        }
        
        UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(butX, butY, frame_W.size.width+20, 40)];
        [but setTitle:mod.name forState:UIControlStateNormal];
        [but setTitleColor:wBlackColor forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:13];
        but.layer.borderColor = FENGEXIANcolor.CGColor;
        but.layer.borderWidth = 0.5;
        
        [bigView addSubview:but];
        
        butX = CGRectGetMaxX(but.frame)+10;
        if (i==tarr.count-1)
        {
            NSLog(@"=rrr==%lf",butY+40);
            aaa = butY+40;
        }
        
        
    }

//    CGRect rect = bigView.frame;
//    rect.size.height = aaa + 20;
//    bigView.backgroundColor = wRedColor;
//    bigView.frame = rect;
    
    [self lishijilv];
  }



-(void)lishijilv
{
    UIView * bView = [[UIView alloc] initWithFrame:CGRectMake(0, aaa+15, wScreenW, 10)];
    bView.backgroundColor = JIANGEcolor;
    [bigView addSubview:bView];
    
    
    UILabel * onelab = [[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(bView.frame), wScreenW-100, 40)];
    onelab.text = [NSString stringWithFormat:@"  历史记录"];
    onelab.font = ZHONGZITI;
    onelab.textColor = wBlackColor;
    [bigView addSubview:onelab];
    
    UIButton * qingchuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    qingchuBtn.frame = CGRectMake(wScreenW-60, CGRectGetMaxY(bView.frame), 50, 40);
    [qingchuBtn setTitle:@"清空" forState:UIControlStateNormal];
    
    [qingchuBtn setTitleColor:QIANZITIcolor forState:UIControlStateNormal];
    
    [qingchuBtn addTarget:self action:@selector(dianjiqingkong) forControlEvents:UIControlEventTouchUpInside];
    
    [bigView addSubview:qingchuBtn];
    
     cView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(onelab.frame), wScreenW, 0.5)];
    cView.backgroundColor = FENGEXIANcolor;
    [bigView addSubview:cView];
    
    
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(cView.frame), wScreenW, wScreenH -CGRectGetMaxY(cView.frame)) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    myTab.separatorColor = FENGEXIANcolor;
    myTab.backgroundColor = JIANGEcolor;
    myTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [myTab registerClass:[LishiTableViewCell class] forCellReuseIdentifier:@"cell"];
    [myTab setSeparatorInset:UIEdgeInsetsZero];
    [myTab setLayoutMargins:UIEdgeInsetsZero];
    
    [bigView addSubview:myTab];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return  aaa + 20;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (index==0)
    {
        return 2;
        
    }else if (index==1)
    {
        return resouArr.count;
    }else
    {
        return fenleiArr.count;
    }
  
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * touView;
    UILabel * lab;
    UIButton * qingchuBtn;
    
    if (!touView)
    {
        touView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 50)];
        touView.backgroundColor = JIANGEcolor;
        
        
    lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, wScreenW, 40)];
        lab.font = ZHONGZITI;
        lab.textColor = wBlackColor;
        lab.backgroundColor = wWhiteColor;
        [touView addSubview:lab];
        
        
        qingchuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        qingchuBtn.frame = CGRectMake(wScreenW-60, 10, 50, 40);
        [qingchuBtn setTitle:@"清空" forState:UIControlStateNormal];
        qingchuBtn.hidden = YES;
        [qingchuBtn setTitleColor:QIANZITIcolor forState:UIControlStateNormal];
        qingchuBtn.backgroundColor = wWhiteColor;
        [qingchuBtn addTarget:self action:@selector(dianjiqingkong) forControlEvents:UIControlEventTouchUpInside];
        [touView addSubview:qingchuBtn];
    }
    
    if (index==0)
    {
        if (section==0)
        {
            lab.text = [NSString stringWithFormat:@"  热门"];

        }else
        {
            lab.text = [NSString stringWithFormat:@"  历史记录"];
            qingchuBtn.hidden = NO;
            
        }
        
    }else if (index==1)
    {
       
        if (resouArr.count>=1)
        {
            DataModel * mod = resouArr[section];
            lab.text =  [NSString stringWithFormat:@"  %@",mod.name];
        }
    }else
    {
        if (resouArr.count>=1)
        {
            DataModel * mod = fenleiArr[section];
            lab.text =  [NSString stringWithFormat:@"  %@",mod.name];
        }
        
    }
    return touView;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LishiTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;    
    
    
    if (index==0)
    {
        if (indexPath.section==0)
        {
            
            if (remensousuoArr.count>=1)
            {
                 [self zidonghuan:remensousuoArr myCell:cell onee:0 indes:indexPath];               
            }
         }else
        {
            if (allArr.count>=1)
            {
                   [self zidonghuan:allArr myCell:cell onee:6 indes:indexPath];
              
            }
        }
    }else if (index==1)
    {
        if (resouArr.count>=1)
        {
            DataModel * mod = resouArr[indexPath.section];
             [self zidonghuan:mod.words myCell:cell onee:1 indes:indexPath];
            
            
            
         }
          }else if(index==2)
    {
        if (fenleiArr.count>=1)
        {
            DataModel * mod = fenleiArr[indexPath.section];
            [self zidonghuan:mod.child myCell:cell onee:2 indes:indexPath];

            
        }
    }
    
    return cell;
}




-(void)zidonghuan:(NSArray*)tarr myCell:(LishiTableViewCell *)cell onee:(NSInteger)abc indes:(NSIndexPath *)path
{
    for (NSInteger i=0; i<50; i++)
    {
        UIButton * abtn =[cell viewWithTag:60*path.section + 500 + i];
        
        [abtn removeFromSuperview];
    }

    [cell.abtn removeFromSuperview];
    
    float butX = 15;
    float butY = 10;
    for(int i = 0; i < tarr.count; i++)
    {
        //宽度自适应
        NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
        
        CGRect frame_W;
        
        if (abc==0)
        {
            DataModel * mod = tarr[i];
            
            frame_W = [mod.name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
            
        }else if (abc==1)
        {
            WwordsModel * mod = tarr[i];
            
            frame_W = [mod.name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
            
            
        }else if (abc==2)
        {
            childModel * mod = tarr[i];
            
            frame_W = [mod.name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
            
        }else if(abc==6)
        {
           frame_W = [tarr[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
            
        }
        
        if (butX+frame_W.size.width+20>wScreenW-15)
        {
            butX = 15;
            butY += 55;
        }
        
        cell.abtn = [[UIButton alloc]initWithFrame:CGRectMake(butX, butY, frame_W.size.width+20, 40)];
        
        
        if (abc==0)
        {
//            DataModel * mod = tarr[i];

//            [cell.abtn setTitle:mod.name forState:UIControlStateNormal];
            
        }else if (abc==1)
        {
//            WwordsModel * mod = tarr[i];
//            [cell.abtn setTitle:mod.name forState:UIControlStateNormal];
            
        }else if (abc==2)
        {
//            childModel * mod = tarr[i];
            
//            [cell.abtn setTitle:mod.name forState:UIControlStateNormal];
        }else if(abc==6)
        {
//            [cell.abtn setTitle:tarr[i] forState:UIControlStateNormal];
        }
        
        [cell.abtn setTitleColor:wBlackColor forState:UIControlStateNormal];
        cell.abtn.titleLabel.font = [UIFont systemFontOfSize:13];
        cell.abtn.layer.borderColor = FENGEXIANcolor.CGColor;
        cell.abtn.layer.borderWidth = 0.5;
        
        cell.abtn.tag = 60*path.section + 500 + i;
        
        
        cell.abtn.hidden = YES;
        [cell.myView addSubview:cell.abtn];
        
        butX = CGRectGetMaxX(cell.abtn.frame)+10;
        if (i==tarr.count-1)
        {
            NSLog(@"=rrr==%lf",butY+40);
            aaa = butY + 40;
        }
        
    }
    CGRect  rect = cell.myView.frame;
    rect.size.height = aaa + 20;
    cell.myView.frame = rect;
    
}



#pragma mark==滑动视图代理

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView==myScroll)
    {
        index = scrollView.contentOffset.x/wScreenW;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView==myScroll)
    {
        UIButton * btn = [self.view viewWithTag:5858 + index];
        
        for (NSInteger i =0; i<3; i++)
        {
            UIButton * aBtn = [self.view viewWithTag:5858+i];
            aBtn.selected = NO;
        }
        btn.selected = YES;
        xiaoImg.center = CGPointMake(btn.center.x, btn.center.y+2.5-15);
        xiaolab.center = CGPointMake(btn.center.x, btn.center.y+2.5-11);
        [myTab removeFromSuperview];

        [self creattab:index];
     }
    
}


-(void)creatbtn:(NSArray *)tarr mycell:(LishiTableViewCell*)cell
{
    CGFloat bbb = 0.0 ;
    float butX = 15;
    float butY = 10;
 
    for (NSInteger i=0; i<50; i++)
    {
        UIButton * abtn =[cell.myView viewWithTag:1234+i];
        
        [abtn removeFromSuperview];
    }
    
    
    
    for(int i = 0; i < tarr.count; i++)
    {
        //宽度自适应
        NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
        
        CGRect frame_W = [tarr[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
        
        if (butX+frame_W.size.width+20>wScreenW-15)
        {
            butX = 15;
            butY += 55;
        }
        
     UIButton * but = [[UIButton alloc]initWithFrame:CGRectMake(butX, butY, frame_W.size.width+20, 40)];
        
        but.tag = 1234 + i;
        [but setTitle:tarr[i] forState:UIControlStateNormal];
        [but setTitleColor:wBlackColor forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:13];
        but.layer.borderColor = FENGEXIANcolor.CGColor;
        but.layer.borderWidth = 0.5;
        
        [cell.myView addSubview:but];
        
        butX = CGRectGetMaxX(but.frame)+10;
        
                if (i==tarr.count-1)
                {
                    NSLog(@"=rrr==%lf",butY+40);
                    
                    bbb = butY+40;
                }
        
    }
    
}


-(void)dianjiqingkong
{
    
    [PlayVcEverLike clearVids];
    
    allArr = [PlayVcEverLike getVids];
    
    [myTab reloadData];
     
}

//找险
-(void)requestremenxianzhongData
{
//    WS(weakSelf);
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setObject:[NSString stringWithFormat:@""] forKey:@"p"];
    [dic setObject:@"" forKey:@"pagesize"];
    
    [WBYRequest wbyPostRequestDataUrl:@"hot_keys" addParameters:dic success:^(WBYReqModel *model)
     {
         if ([model.err isEqualToString:TURE])
         {
             remensousuoArr = model.data;

//             [weakSelf creatupview];
         }else
         {
             [WBYRequest showMessage:model.err];
         }
         
         [myTab reloadData];
     } failure:^(NSError *error) {
         
     } isRefresh:NO];
    
}


//热搜

-(void)requestresouguanjianziData
{
//    WS(weakSelf);
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setObject:[NSString stringWithFormat:@""] forKey:@"p"];
    [dic setObject:@"" forKey:@"pagesize"];
    
    [WBYRequest wbyPostRequestDataUrl:@"cate_keys" addParameters:dic success:^(WBYReqModel *model)
     {
         if ([model.err isEqualToString:TURE])
         {
             resouArr = model.data;
             
         }else
         {
             [WBYRequest showMessage:model.err];
         }
         [myTab reloadData];

     } failure:^(NSError *error) {
         
     } isRefresh:NO];
    
}
//分类

-(void)requesFenleiData
{
//    WS(weakSelf);
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
//    [dic setObject:[NSString stringWithFormat:@""] forKey:@"p"];
//    [dic setObject:@"" forKey:@"pagesize"];
    
    [WBYRequest wbyPostRequestDataUrl:@"cates" addParameters:dic success:^(WBYReqModel *model)
     {
         if ([model.err isEqualToString:TURE])
         {
             fenleiArr = model.data;
             
         }else
         {
             [WBYRequest showMessage:model.err];
         }
         
         [myTab reloadData];
     } failure:^(NSError *error) {
         
     } isRefresh:NO];
    
}







-(void)jinru:(UIButton *)btn
{
    btn.selected = !btn.selected;
    for (NSInteger i =0; i<3; i++)
    {
        UIButton * aBtn = [self.view viewWithTag:5858+i];
        aBtn.selected = NO;
    }
    btn.selected = YES;
    xiaoImg.center = CGPointMake(btn.center.x, btn.center.y+2.5-15);
    xiaolab.center = CGPointMake(btn.center.x, btn.center.y+2.5-11);
    myScroll.contentOffset = CGPointMake(wScreenW*(btn.tag-5858), 0);
    
//    myTab.frame = CGRectMake(wScreenW * (btn.tag-5858),CGRectGetMaxY(cView.frame), wScreenW, wScreenH -CGRectGetMaxY(cView.frame));
//    
//    [myTab reloadData];
    [myTab removeFromSuperview];
    
    [self creattab:btn.tag-5858];

}



#pragma mark==搜索
-(void)sousuoButtonClick
{
    [_searchBar resignFirstResponder];
    
    [self searchByKeyword:_searchBar.text?_searchBar.text:@""];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_searchBar resignFirstResponder];
    
    [self searchByKeyword:_searchBar.text?_searchBar.text:@""];
    
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    UIButton * btn = [[[UIApplication sharedApplication].delegate window] viewWithTag:12345];
    if (searchText.length>0)
    {
        btn.hidden = YES;
    }else
    {
        btn.hidden = NO;
    }
}
-(void)searchByKeyword:(NSString *)keyWord
{
    [PlayVcEverLike writeToFileDocumentPathByVid:keyWord];
    allArr = [PlayVcEverLike getVids];
    [myTab reloadData];
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    allArr = [PlayVcEverLike getVids];

    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
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
