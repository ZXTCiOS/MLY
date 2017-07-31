//
//  MorePingJiaVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/29.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "MorePingJiaVC.h"
#import "PingJiaModel.h"
#import "PingJiaCell.h"

@interface MorePingJiaVC ()
@property (nonatomic, assign) NSInteger minsu_id;

@property (nonatomic, strong) NSMutableArray<PingJiaModel *> *datalist;
@property (nonatomic, strong) UILabel *total;
@end

@implementation MorePingJiaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺评价";
    [self net];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PingJiaCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    [XDFactory addBackItemForVC:self];
}

- (void)net{
    [DNNetworking getWithURLString:get_more_judge parameters:@{@"minsu_id": @(self.minsu_id)} success:^(id obj) {
        
        NSString *code = [NSString stringWithFormat:@"%@", [obj valueForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSArray *arr = [NSArray modelArrayWithClass:[PingJiaModel class] json:[obj valueForKey:@"data"]];
            [self.datalist addObjectsFromArray:arr];
            [self.tableView reloadData];
        } else {
            [self.view showWarning:[obj valueForKey:@"message"]];
        }
        
    } failure:^(NSError *error) {
        [self.view showWarning:@"网络错误"];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datalist.count ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PingJiaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    PingJiaModel *model = self.datalist[indexPath.row];
    [cell.imgV sd_setImageWithURL:model.user_pickture.xd_URL placeholderImage:[UIImage imageNamed:@"1"]];
    cell.nameL.text = model.user_nickname;
    cell.descL.text = model.eval_content;
    cell.starV.star = model.eval_star;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:model.eval_time];
    NSString *d = [dateFormatter stringFromDate:date];
    cell.timeL.text = d;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.total = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 40)];
    self.total.font = [UIFont systemFontOfSize:14];
    self.total.textColor = krgb(223, 8, 66, 1);
    self.total.textAlignment = NSTextAlignmentCenter;
    self.total.text = [NSString stringWithFormat:@"共%lu条评价", (unsigned long)self.datalist.count];
    return self.total;
}

- (NSMutableArray<PingJiaModel *> *)datalist{
    if (!_datalist) {
        _datalist = [NSMutableArray<PingJiaModel *> array];
    }
    return _datalist;
}


- (instancetype)initWithMinsu_id:(NSInteger)minsu_id{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.minsu_id = minsu_id;
    }
    return self;
}




@end
