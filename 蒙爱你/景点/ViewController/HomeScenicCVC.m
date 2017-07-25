//
//  HomeScenicCVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/5.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "HomeScenicCVC.h"
#import "Home12Cell.h"
#import "HomeCityCVC.h"
#import "Scenic12Model.h"


@interface HomeScenicCVC ()

@property (nonatomic, strong) NSMutableArray<ScenicAreaModel *> *datalist;


@end

@implementation HomeScenicCVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [DNNetworking getWithURLString:get_12menglist success:^(id obj) {
        
        NSString *code = [obj valueForKey:@"code"];
        if (code.integerValue == 200) {
            Scenic12Model *model = [Scenic12Model parse:obj];
            [self.datalist addObjectsFromArray:model.data];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [self.view showWarning:@"网络错误"];
    }];
    
    self.title = @"12盟市";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"Home12Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [XDFactory addBackItemForVC:self];
    [self headerV];
}

- (void)headerV{
    UIImageView *imgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"12ms"]];
    imgv.contentMode = UIViewContentModeLeft;
    imgv.frame = CGRectMake(10, 0, kScreenW-10, 80);
    self.tableView.tableHeaderView = imgv;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datalist.count ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datalist.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreenW * 0.6 + 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Home12Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell.imgV sd_setImageWithURL:self.datalist[indexPath.row].area_pic.xd_URL placeholderImage:[UIImage imageNamed:@"7"]];
    cell.name.text = self.datalist[indexPath.row].area_name;
    cell.desc.text = self.datalist[indexPath.row].area_des;
    return cell;
}

#pragma mark <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(25, 25, 10, 25);
    CGFloat width = (kScreenW - 70) / 3.0;
    layout.itemSize = CGSizeMake(width, width *4 / 3);
    
    HomeCityCVC *vc = [[HomeCityCVC alloc] initWithCollectionViewLayout:layout meng_id:self.datalist[indexPath.row].area_id meng_name:self.datalist[indexPath.row].area_name];
    [self.navigationController pushViewController:vc animated:YES];
    
    NSLog(@"%ld", indexPath.row);
    
}

- (NSMutableArray<ScenicAreaModel *> *)datalist{
    if (!_datalist) {
        _datalist = [NSMutableArray<ScenicAreaModel *> array];
    }
    return _datalist;
}



@end
