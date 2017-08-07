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
#import "strisNull.h"
#import "submitorderModel.h"
#import "submitorderVC.h"
#import "HZCalendarViewController.h"
#import "ScenicModel.h"



@interface LiJiYuDingTVC ()<MSSCalendarViewControllerDelegate>


@property (nonatomic, strong) id model;

@property (weak, nonatomic) IBOutlet UITextField *name;

@property (weak, nonatomic) IBOutlet UITextField *tele;


@property (weak, nonatomic) IBOutlet UILabel *count;

@property (weak, nonatomic) IBOutlet UILabel *date;

@property (nonatomic, assign) NSInteger number;

@property (nonatomic,assign)NSInteger startDate;

@property (nonatomic,assign)NSInteger endDate;

@property (nonatomic, strong) HZCalendarViewController *hzPicker;
@property (nonatomic, strong) MSSCalendarViewController *datePicker;
@property (nonatomic,strong) NSString *typestr;
@end

@implementation LiJiYuDingTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.number = 1;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.navigationController.navigationBar.hidden = NO;
    
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
    //1 bed, 2 eat, 3 ticket        typestr
    //1商品 2门票 3住宿 4餐饮 5 美食    goods_typestr
    
    submitorderVC *subvc = [[submitorderVC alloc] init];
    
    if ([self.typestr isEqualToString:@"1"]) {
        subvc.goods_typestr = @"3";
        
    } else if ([self.typestr isEqualToString:@"2"]) {
        subvc.goods_typestr = @"4";
    } else if ([self.typestr isEqualToString:@"3"]){
        [self submitTicketWithTicketModel:self.model];
        return;
    }
    
    NSString *bedeat_pic = [NSString stringWithFormat:@"%@",((MinsuBedModel *)self.model).bedeat_pic];
    NSString *bedeat_id = [NSString stringWithFormat:@"%ld",(long)((MinsuBedModel *)self.model).bedeat_id];
    NSString *bedeat_name = [NSString stringWithFormat:@"%@",((MinsuBedModel *)self.model).bedeat_name];
    NSString *bedeat_intro = [NSString stringWithFormat:@"%@",((MinsuBedModel *)self.model).bedeat_intro];
    NSString *bedeat_des = [NSString stringWithFormat:@"%@",((MinsuBedModel *)self.model).bedeat_des];
    NSString *bedeat_price = [NSString stringWithFormat:@"%ld",(long)((MinsuBedModel *)self.model).bedeat_price];

    NSString *namestr = @"";
    NSString *telephonestr  = @"";
    NSString *datastr = @"";
    NSString *contentstr = @"";
    if ([strisNull isNullToString:self.name.text]) {
        namestr = @"0";
    }
    else
    {
        namestr = self.name.text;
    }
    if ([strisNull isNullToString:self.tele.text]) {
        telephonestr = @"0";
    }
    else
    {
        telephonestr = self.tele.text;
    }
    if ([strisNull isNullToString:self.count.text]) {
        contentstr = @"0";
    }
    else
    {
        contentstr = self.count.text;
    }
    if ([strisNull isNullToString:self.date.text]) {
        datastr = @"0";
    }
    else
    {
        datastr = self.date.text;
    }

    
    
    subvc.orderDatasource = [NSMutableArray array];
    submitorderModel *smodel = [[submitorderModel alloc] init];
    smodel.orderimg = bedeat_pic;
    smodel.ordername = bedeat_name;
    smodel.orderinter = bedeat_intro;
    smodel.ordercontent = bedeat_des;
    smodel.goods_id = bedeat_id;
    smodel.orderprice = bedeat_price;
    smodel.ordernumber = contentstr;
    [subvc.orderDatasource addObject:smodel];
    subvc.yudingtime = datastr;
    subvc.yudingname = namestr;
    subvc.yudingphone = telephonestr;
    [self.navigationController pushViewController:subvc animated:YES];
}

- (void)submitTicketWithTicketModel:(tickets *) ticket{
    submitorderVC *subvc = [[submitorderVC alloc] init];
    subvc.goods_typestr = @"2";
    
    NSString *bedeat_id = [NSString stringWithFormat:@"%ld",(long)ticket.ticket_id];
    NSString *bedeat_name = [NSString stringWithFormat:@"%@",ticket.ticket_name];
    NSString *bedeat_intro = [NSString stringWithFormat:@"%@",ticket.ticket_intro];
    NSString *bedeat_price = [NSString stringWithFormat:@"%ld",(long)ticket.ticket_price];
    
    NSString *namestr = @"";
    NSString *telephonestr  = @"";
    NSString *datastr = @"";
    NSString *contentstr = @"";
    if ([strisNull isNullToString:self.name.text]) {
        namestr = @"0";
    }
    else
    {
        namestr = self.name.text;
    }
    if ([strisNull isNullToString:self.tele.text]) {
        telephonestr = @"0";
    }
    else
    {
        telephonestr = self.tele.text;
    }
    if ([strisNull isNullToString:self.count.text]) {
        contentstr = @"0";
    }
    else
    {
        contentstr = self.count.text;
    }
    if ([strisNull isNullToString:self.date.text]) {
        datastr = @"0";
    }
    else
    {
        datastr = self.date.text;
    }
    
    subvc.orderDatasource = [NSMutableArray array];
    submitorderModel *smodel = [[submitorderModel alloc] init];
    //smodel.orderimg = bedeat_pic;
    smodel.ordername = bedeat_name;
    smodel.orderinter = bedeat_intro;
    //smodel.ordercontent = bedeat_des;
    smodel.goods_id = bedeat_id;
    smodel.orderprice = bedeat_price;
    smodel.ordernumber = contentstr;
    [subvc.orderDatasource addObject:smodel];
    subvc.yudingtime = datastr;
    subvc.yudingname = namestr;
    subvc.yudingphone = telephonestr;
    [self.navigationController pushViewController:subvc animated:YES];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 2) {
        if ([self.typestr isEqualToString:@"3"]) {
            [self.navigationController presentViewController:self.hzPicker animated:YES completion:nil];
        } else {
            [self.navigationController presentViewController:self.datePicker animated:YES completion:nil];
        }
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

- (HZCalendarViewController *)hzPicker{
    if (!_hzPicker) {
        _hzPicker = [HZCalendarViewController getVcWithDayNumber:365 FromDateforString:nil Selectdate:nil selectBlock:^(HZCalenderDayModel *goDay, HZCalenderDayModel *backDay) {
            self.date.text = goDay.toString;
            [_hzPicker dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    return _hzPicker;
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

- (instancetype)initWithBedEat:(BedOreEat)typt minsuBedModel:(id)bedeatModel{
    UIStoryboard *stb = [UIStoryboard storyboardWithName:@"BedDetailTVC" bundle:nil];
    self = [stb instantiateViewControllerWithIdentifier:@"lijiyuding"];
    if (self ) {
        self.model = bedeatModel;
        if (typt==Bed) {
            self.typestr = @"1";
        }else if(typt == Eat)
        {
            self.typestr = @"2";
        }else {
            self.typestr = @"3";
        }
    }
    return self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
