//
//  ScenicTVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/11.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "ScenicTVC.h"
#import "ScenicCell.h"
#import "ScenicViewModel.h"
#import "ScenicVC.h"

@interface ScenicTVC ()
@property (nonatomic, strong) ScenicViewModel *viewmodel;

@property (nonatomic, assign) NSInteger area_id;

@end

@implementation ScenicTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MJWeakSelf
    [self.tableView addHeaderRefresh:^{
        [weakSelf.viewmodel getDataWithRequestMode:RequestModeRefresh withID:weakSelf.area_id handller:^(NSError *error) {
            if (!error) {
                
                [weakSelf.tableView reloadData];
                [weakSelf.tableView endHeaderRefresh];
            } else {
                [weakSelf.tableView showWarning:@"网络错误"];
                [weakSelf.tableView endHeaderRefresh];
            }
        }];
    }];
    [self.tableView addFooterRefresh:^{
        [weakSelf.viewmodel getDataWithRequestMode:RequestModeMore withID:weakSelf.area_id handller:^(NSError *error) {
            if (!error) {
                
                [weakSelf.tableView reloadData];
                [weakSelf.tableView endFooterRefresh];
            } else {
                [weakSelf.tableView showWarning:@"网络错误"];
                [weakSelf.tableView endFooterRefresh];
            }
        }];
    }];
    [self.tableView beginHeaderRefresh];
    
    
    [XDFactory addBackItemForVC:self];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"ScenicCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.viewmodel.datalist.count ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.viewmodel.datalist.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScenicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    ScenicelEmentModel *model = self.viewmodel.datalist[indexPath.row];
    [cell.imageV sd_setImageWithURL:model.scenic_pic.xd_URL placeholderImage:[UIImage imageNamed:@"15"]];
    cell.name.text = model.scenic_name;
    cell.detail.text = model.scenic_intro;
    cell.price.text = [NSString stringWithFormat:@"¥%0.2f起", model.min_price];
    cell.isLike = model.is_shoucang;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ScenicVC *vc = [[ScenicVC alloc] initWithScenic_id:self.viewmodel.datalist[indexPath.row].scenic_id];
    
    [self.navigationController pushViewController:vc animated:YES];
}







- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}

- (ScenicViewModel *)viewmodel{
    if (!_viewmodel) {
        _viewmodel = [[ScenicViewModel alloc] init];
    }
    return _viewmodel;
}

- (instancetype)initWithArea_id:(NSInteger)area_id area_name:(NSString *)area_name{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.area_id = area_id;
        self.title = area_name;
    }
    return self;
}

@end
