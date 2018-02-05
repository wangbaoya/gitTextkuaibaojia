//
//  XuanXIngBie.m
//  搜索框
//
//  Created by apple on 17/6/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XuanXIngBie.h"


@interface XuanXIngBie ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat hanggao;
}
@property (nonatomic, strong) UIView *alertView;//弹框视图
@end


@implementation XuanXIngBie

+ (XuanXIngBie *)showWithTitle:(NSString *)title
                        titles:(NSArray *)titles
                   selectIndex:(SelectIndex)selectIndex
                   selectValue:(SelectValue)selectValue
               showCloseButton:(BOOL)showCloseButton {
    XuanXIngBie *alert = [[XuanXIngBie alloc] initWithTitle:title titles:titles selectIndex:selectIndex selectValue:selectValue showCloseButton:showCloseButton];
    return alert;
}

-(instancetype)initWithTitle:(NSString *)title titles:(NSArray *)titles selectIndex:(SelectIndex)selectIndex selectValue:(SelectValue)selectValue showCloseButton:(BOOL)showCloseButton
{
    
    if (self=[super init])
    {
        
        hanggao = 50;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];

        [self addSubview:self.alertView];
        _selectIndex = [selectIndex copy];
        _selectValue = [selectValue copy];
        _titles = titles;
        
        [self.alertView addSubview:self.selectTableView];
        
        [self initui];
        
        [self show];
    }
    
    
    return self;
}

-(void)initui
{
    
    self.alertView.frame = CGRectMake(0,(wScreenH-_titles.count*hanggao-30)/2, wScreenW,_titles.count*hanggao +30);
    
    self.alertView.backgroundColor = QIANZITIcolor;
    
    
 self.selectTableView.frame = CGRectMake(0, 0, _alertView.frame.size.width, _alertView.frame.size.height);
    
    
//    self.selectTableView.backgroundColor = [UIColor redColor];

}



- (void)show {
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [[UIApplication sharedApplication].keyWindow  addSubview:self];
    
    self.alertView.alpha = 0.0;
    [UIView animateWithDuration:0.05 animations:^{
        self.alertView.alpha = 1;
    }];
}



- (UIView *)alertView
{
    if (!_alertView) {
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = [UIColor whiteColor];
//        _alertView.layer.cornerRadius = 8;
//        _alertView.layer.masksToBounds = YES;
    }
    return _alertView;
}

- (UITableView *)selectTableView
{
    if (!_selectTableView) {
        _selectTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _selectTableView.delegate = self;
        _selectTableView.dataSource = self;
        _selectTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        [_selectTableView setLayoutMargins:UIEdgeInsetsZero];
    
        [_selectTableView setSeparatorInset:UIEdgeInsetsZero];
    
    }
    return _selectTableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titles.count;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel * mylab;
    
    
    if (!mylab)
    {
        mylab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
        mylab.font = Font(17);
        mylab.textColor = wBlackColor;
        mylab.textAlignment = 1;
        
        mylab.text = [NSString stringWithFormat:@"请选择性别"];
    }
    
    return mylab;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return hanggao;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectcell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"selectcell"];
    }
    
    cell.textLabel.text =[NSString stringWithFormat:@"%@",_titles[indexPath.row]] ;
    cell.textLabel.textAlignment = 1;
    cell.textLabel.font = Font(16);
    cell.textLabel.textColor = wBlackColor;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectIndex) {
        self.selectIndex(indexPath.row);
    }
    if (self.selectValue) {
        self.selectValue(_titles[indexPath.row]);
    }
    
    [self closeAction];
}


- (void)closeAction
{
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
    if (!CGRectContainsPoint([self.alertView frame], pt)) {
        [self closeAction];
    }
}





@end
