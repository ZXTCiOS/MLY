//
//  LiJiYuDingTVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/19.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "LiJiYuDingTVC.h"
#import "MSSCalendarViewController.h"
#import "MSSCalendarDefine.h"
#import "homereservationVC.h"

@interface LiJiYuDingTVC ()<MSSCalendarViewControllerDelegate>


@property (nonatomic, strong) MinsuBedModel *model;

@property (weak, nonatomic) IBOutlet UITextField *name;

@property (weak, nonatomic) IBOutlet UITextField *tele;


@property (weak, nonatomic) IBOutlet UILabel *count;

@property (weak, nonatomic) IBOutlet UILabel *date;

@property (nonatomic, assign) NSInteger number;

@property (nonatomic,assign)NSInteger startDate;

@property (nonatomic,assign)NSInteger endDate;


@property (nonatomic, strong) MSSCalendarViewController *datePicker;

@end

@implementation LiJiYuDingTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.number = 1;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 把要预定的民宿信息  传入此 VC
    [XDFactory addBackItemForVC:self];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = nil;
}

- (IBAction)jiaBtnClicked:(id)sender {
    self.number++;
    self.count.text = [NSString stringWithFormat:@"%ld", self.number];
    
}

- (IBAction)jianBtnClicked:(id)sender {
    
    if (self.number == 1) return;
    self.number--;
    self.count.text = [NSString stringWithFormat:@"%ld", self.number];
}

- (IBAction)yudingClicked:(id)sender {
    
    // 预定
    homereservationVC *homesvc = [[homereservationVC alloc] initWithMinsuBedEatModel:self.model];
    [self.navigationController pushViewController:homesvc animated:YES];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 2) {
        
        [self.navigationController presentViewController:self.datePicker animated:YES completion:nil];
    }
}


- (MSSCalendarViewController *)datePicker{
    if (!_datePicker) {
        _datePicker = [[MSSCalendarViewController alloc] init];
        _datePicker.limitMonth = 12;// 显示几个月的日历
        /*
         MSSCalendarViewControllerLastType 只显示当前月之前
         MSSCalendarViewControllerMiddleType 前后各显示一半
         MSSCalendarViewControllerNextType 只显示当前月之后
         */
        _datePicker.type = MSSCalendarViewControllerNextType;
        _datePicker.beforeTodayCanTouch = NO;// 今天之前的日期是否可以点击
        _datePicker.afterTodayCanTouch =  YES;// 今天之后的日期是否可以点击
        _datePicker.startDate = _startDate;// 选中开始时间
        _datePicker.endDate = _endDate;// 选中结束时间
        /*以下两个属性设为YES,计算中国农历非常耗性能（在5s加载15年以内的数据没有影响）*/
        _datePicker.showChineseHoliday = YES;// 是否展示农历节日
        _datePicker.showChineseCalendar = YES;// 是否展示农历
        _datePicker.showHolidayDifferentColor = YES;// 节假日是否显示不同的颜色
        _datePicker.showAlertView = YES;// 是否显示提示弹窗
        _datePicker.delegate = self;
        
    }
    return _datePicker;
}


- (void)calendarViewConfirmClickWithStartDate:(NSInteger)startDate endDate:(NSInteger)endDate
{
    _startDate = startDate;
    _endDate = endDate;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat: @"MM-dd"];
    NSString *startDateString = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:_startDate]];
    NSString *endDateString = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:_endDate]];
    self.date.text = [NSString stringWithFormat:@"%@ ~ %@",startDateString, endDateString];
    
}

- (instancetype)initWithBedEat:(BedOreEat)typt minsuBedModel:(MinsuBedModel *)bedeatModel{
    UIStoryboard *stb = [UIStoryboard storyboardWithName:@"BedDetailTVC" bundle:nil];
    self = [stb instantiateViewControllerWithIdentifier:@"lijiyuding"];
    if (self ) {
        self.model = bedeatModel;
    }
    return self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
