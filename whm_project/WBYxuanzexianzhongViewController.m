//
//  WBYxuanzexianzhongViewController.m
//  whm_project
//
//  Created by apple on 17/2/6.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WBYxuanzexianzhongViewController.h"
#import "WBYxzxzTableViewCell.h"

@interface WBYxuanzexianzhongViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    NSMutableArray * allArray;
    NSInteger numindex;
    UIButton * delebtb;


}
@property(nonatomic,strong)UITableView * tableV;
@property(nonatomic,strong)UISearchBar * searchBar;

@end

@implementation WBYxuanzexianzhongViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    numindex =  1;

    allArray = [NSMutableArray array];
    [self quartData:@""];
    [self creatLeftTtem];
    [self setupUI];
   
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [_searchBar becomeFirstResponder];
    numindex = 1;
    
}
-(void)headerRereshing
{
    numindex = 1 ;
    _searchBar.text = @"";
    [self quartData:@""];
    [_tableV.mj_header endRefreshing];
    
}
//下拉
-(void)footerRefreshing
{
    numindex ++ ;
    _searchBar.text = @"";

    [self quartData:@""];
    [_tableV.mj_footer endRefreshing];
}

-(void)setupUI
{    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 38, 30);
    [button setTitle:@"搜索" forState:UIControlStateNormal];
    
    [button setTitleColor:SHENLANSEcolor forState:UIControlStateNormal];
    
    
    [button addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, wScreenW-100, 30)];
    UIColor *color =  self.navigationController.navigationBar.barTintColor;
    [titleView setBackgroundColor:color];
    
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.delegate = self;
    _searchBar.frame = CGRectMake(0, 0, wScreenW-100, 30);
    _searchBar.backgroundColor = wWhiteColor;
    [_searchBar.layer setBorderWidth:0.5];
    [_searchBar.layer setBorderColor:QIANLANSEcolor.CGColor];  //设置边框为白色
    [_searchBar changeLeftPlaceholder:@"   请输入搜索内容"];
    [titleView addSubview:_searchBar];
    
    
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
//    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = titleView;
    
    
    
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0,0, wScreenW, wScreenH - 64) style:UITableViewStylePlain];
    self.tableV.dataSource = self;
    self.tableV.delegate =self;
    
    self.tableV.rowHeight = HANGGAO;
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
   [self.tableV registerClass:[WBYxzxzTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    _tableV.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    _tableV.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];

    
    [self.view addSubview:self.tableV];

}



-(void)backButtonClick
{
    [_searchBar resignFirstResponder];
    if (_searchBar.text.length>=1)
    {
        [self quartData:_searchBar.text];
    }else
    {
        [WBYRequest showMessage:@"请输入搜索内容"];
    }
    
}


//数据请求
-(void)quartData:(NSString *)keyword
{
    WS(weakSelf);
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:keyword?keyword:@"" forKey:@"keyword"];
   
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)numindex] forKey:@"p"];
    [dic setObject:@"20" forKey:@"pagesize"];
    
    [WBYRequest wbyPostRequestDataUrl:@"has_rate_pros" addParameters:dic success:^(WBYReqModel *model)
     {
         [weakSelf.beijingDateView removeFromSuperview];
         if ([model.err isEqualToString:TURE])
         {
             if (numindex == 1)
             {
                 [allArray removeAllObjects];
             }
             [allArray addObjectsFromArray:model.data];
             
             if (allArray.count==0)
             {
                 [WBYRequest showMessage:@"没事有数据"];
                  [weakSelf wushuju];
             }
         }else{
             
             [WBYRequest showMessage:model.info];
         }
         
         [_tableV reloadData];
         
     } failure:^(NSError *error) {
         
     } isRefresh:NO];
    
 }


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return allArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBYxzxzTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [_searchBar resignFirstResponder];
    cell.backgroundColor = wWhiteColor;
    DataModel * model = allArray[indexPath.row];
    
    if ([model.is_main isEqualToString:@"1"])
    {
        cell.img.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e618", 20, SHENLANSEcolor)];
    }
    else if ([model.is_main isEqualToString:@"2"])
    {
        cell.img.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61e", 20, wRedColor)];
    }
    else
    {
        cell.img.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61a", 20,ZuoHeXianColour)];
    }
    
    cell.myLab.font = daFont;
    
    cell.myLab.text = model.short_name.length>1?model.short_name:model.name;
    cell.myLab.textColor = QIANZITIcolor;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataModel * model = allArray[indexPath.row];
    
    model?self.xianZhongModel(model):[WBYRequest showMessage:@"没有获取到数据"];    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [_searchBar resignFirstResponder];
    
    [self quartData:searchBar.text?searchBar.text:@""];
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
