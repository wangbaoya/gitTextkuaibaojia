//
//  DatePickerView.m
//  DatePickerStudy
//
//  Created by 张发行 on 16/9/5.
//  Copyright © 2016年 zhangfaxing. All rights reserved.
//

#import "DatePickerView.h"

@implementation DatePickerView


- (DatePickerView *)initWithCustomeHeight:(CGFloat)height xzhou:(NSInteger)x yzhou:(NSInteger)y
{
    self = [super initWithFrame:CGRectMake(x,y, SCREEN_WIDTH, height=height<200?200:height)];
    if (self)
    {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.05].CGColor;
        
        //创建取消 确定按钮
        UIButton *cannel = [UIButton buttonWithType:UIButtonTypeCustom];
        cannel.frame = CGRectMake(0, 0, 80, 40);
        [cannel setTitle:@"取消" forState:0];
        [cannel setTitleColor:[UIColor redColor] forState:0];
        cannel.tag = 1;
        [cannel addTarget:self action:@selector(cannelOrConfirm:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cannel];
        
        
        UIButton *confirm = [UIButton buttonWithType:UIButtonTypeCustom];
        confirm.frame = CGRectMake(SCREEN_WIDTH-80, 0, 80, 40);
        [confirm setTitle:@"确定" forState:0];
        [confirm setTitleColor:[UIColor greenColor] forState:0];
        confirm.tag = 2;
        [confirm addTarget:self action:@selector(cannelOrConfirm:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:confirm];
        
        // 创建datapikcer
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, height-40)];
        _datePicker.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        // 本地化
        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
        
        // 日期控件格式
//        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        _datePicker.datePickerMode = UIDatePickerModeDate;
        
        
       
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
          [formatter setDateFormat:@"YYYY-MM-dd"];
          NSDate * datenow = [NSDate date];
//             NSString *currentTimeString = [formatter stringFromDate:datenow];
        _datePicker.maximumDate = datenow;
        _datePicker.minimumDate = [formatter dateFromString:@"1917-01-01"];
        
//        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//        NSDate *currentDate = [NSDate date];
//        NSDateComponents *comps = [[NSDateComponents alloc] init];
//        [comps setYear:0];//设置最大时间为：当前时间推后十年
//        NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
//        [comps setYear:-100];//设置最小时间为：当前时间前推十年
//        NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
//        
//        [_datePicker setMaximumDate:maxDate];
//        [_datePicker setMinimumDate:minDate];
        
        
        [self addSubview:_datePicker];

    }
    return self;
}


//计算某个时间与此刻的时间间隔（天）
- (NSString *)dayIntervalFromNowtoDate:(NSString *)dateString
{
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd"];
    NSDate *d=[date dateFromString:dateString];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate *dat = [NSDate date];
    NSString *nowStr = [date stringFromDate:dat];
    NSDate *nowDate = [date dateFromString:nowStr];
    
    NSTimeInterval now=[nowDate timeIntervalSince1970]*1;
    
    NSString *timeString=@"";
    
    NSTimeInterval cha=now-late;
    
    timeString = [NSString stringWithFormat:@"%f", cha/86400];
    timeString = [timeString substringToIndex:timeString.length-7];
    
    if ([timeString intValue] < 0)
    {
        
        timeString = [NSString stringWithFormat:@"%d",-[timeString intValue]];
    }
    
    return timeString;
    
}

//选择确定或者取消
- (void)cannelOrConfirm:(UIButton *)sender
{
    if (sender.tag==2) {
        
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyy-MM-dd"];
        NSString *choseDateString = [dateformatter stringFromDate:_datePicker.date];
        
        //如果选择的日期是未来
        if ([[[NSDate date] laterDate:self.datePicker.date] isEqualToDate:self.datePicker.date])
        {
            NSLog(@"对不起，不能选择将来时！");
            
            [WBYRequest showMessage:@"对不起，不能选择将来时！"];
            return;
        }
        
        //计算出剩余多久生日
        //拿到生日中的 月&日 年份为今年 拼接起来 转化为时间 与今天相减
        NSArray *tempArr = [choseDateString componentsSeparatedByString:@"-"];
        
        NSDateFormatter *currentFormatter = [[NSDateFormatter alloc] init];
        [currentFormatter setDateFormat:@"yyyy"];
        NSString *currentYear = [currentFormatter stringFromDate:[NSDate date]];
        
        NSString *appendString = [NSString stringWithFormat:@"%@-%@-%@",currentYear,tempArr[1],tempArr[2]];
        
        
        NSDate *appendDate = [dateformatter dateFromString:appendString];
        
        //将此刻时间转换为与选择时间格式一致
        NSDate *now = [NSDate date];
        NSString *nowStr = [dateformatter stringFromDate:now];
        NSDate *nowDate = [dateformatter dateFromString:nowStr];
        
        
        //判断拼接后的时间与此刻时间对比
        if ([[nowDate earlierDate:appendDate] isEqualToDate:appendDate]) {
            //拼接后在当前时间之前 重新拼接 年份+1
            if (![nowDate isEqualToDate:appendDate]) {
                
                appendString = [NSString stringWithFormat:@"%d-%@-%@",[currentYear intValue]+1,tempArr[1],tempArr[2]];
            }
            
        }
        
        NSString *intercalStr = [self dayIntervalFromNowtoDate:appendString];
        self.confirmBlock(choseDateString,intercalStr);

        NSLog(@"intercalStr==%@",intercalStr);
        
    }
    self.cannelBlock();
}


@end
