//
//  ShouHuoDiZhiTVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/7.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "ShouHuoDiZhiTVC.h"
#import "ShouHuoDiZhiCell.h"
#import "NewAddressCell.h"
#import "AddAddressTVC.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "EditSHDZVC.h"


@interface ShouHuoDiZhiTVC ()

@end

@implementation ShouHuoDiZhiTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouHuoDiZhiCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[NewAddressCell class] forCellReuseIdentifier:@"new"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section ? 1 : 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section) {
        NewAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"new" forIndexPath:indexPath];
        return cell;
    }
    
    ShouHuoDiZhiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.nameL.text = @"啦啊啊啊啊";
    cell.tele.text = @"0216543521";
    [cell.isDefault setBackgroundImage:[UIImage imageNamed:@"dd-fkcg"] forState:UIControlStateNormal];
    cell.addressL.text = @"l 类似大幅度开发工具数量的看法法律手段会计法发斯蒂芬斯蒂芬;lfkjsd";
    cell.edit = ^(){
        UIStoryboard *stb = [UIStoryboard storyboardWithName:@"SHDZ" bundle:nil];
        EditSHDZVC *vc = [stb instantiateViewControllerWithIdentifier:@"edit"];
        [self.navigationController pushViewController:vc animated:YES];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section) {
        return 45;
    }
    return [tableView fd_heightForCellWithIdentifier:@"cell" configuration:^(ShouHuoDiZhiCell *cell) {
        cell.nameL.text = @"啦啊啊啊啊";
        cell.tele.text = @"0216543521";
        [cell.isDefault setImage:[UIImage imageNamed:@"dd-fkcg"] forState:UIControlStateNormal];
        cell.addressL.text = @"l 类似大幅度开发工具数量的看法法律手段会计法发斯蒂芬斯蒂芬;lfkjsd";
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section) {
        
        UIStoryboard *st = [UIStoryboard storyboardWithName:@"SHDZ" bundle:nil];
        AddAddressTVC *vc = [st instantiateViewControllerWithIdentifier:@"add"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
    
    
    
    
}




@end
