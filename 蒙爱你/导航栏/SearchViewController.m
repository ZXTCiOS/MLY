//
//  SearchViewController.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/24.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "SearchViewController.h"
#import "ScenicTVC.h"
#import "FoodCollectionVC.h"
#import "ShunFengCheCVC.h"


@interface SearchViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchControllerDelegate>

@property (nonatomic, assign) SearchType type;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, strong) NSDictionary *list;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    self.searchController.searchBar.showsCancelButton = YES;
    for(id sousuo in [self.searchController.searchBar subviews])
    {
        for (id zz in [sousuo subviews])
        {
            if([zz isKindOfClass:[UIButton class]]){
                UIButton *btn = (UIButton *)zz;
                [btn setTitle:@"搜索" forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                self.searchController.searchBar.showsCancelButton = YES;
                [btn removeAllBlocksForControlEvents:UIControlEventTouchUpInside];
                [btn removeAllTargets];
                [btn bk_addEventHandler:^(id sender) {
                    [self searchInVC];
                } forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
    
    
    
}

- (void)searchInVC{
    switch (self.type) {
        case SearchTypeScenic:{
            [self searchJingdian];
        }
            break;
        case SearchTypeChuxing:{
            [self searchChuxing];
        }
            break;
        case SearchTypeMinsu:{
            [self searchMinsu];
        }
            break;
        case SearchTypeFood:{
            [self searchMeishi];
        }
            break;
        default:
            break;
    }
}




#pragma mark tableview   delegate, datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.searchController.searchBar.text isEqualToString:@""] ? 0 : 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.type == 0? 3: 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!self.list) return cell;
    NSString *count;
    NSString *name;
    switch (indexPath.row) {
        case 0:
            count = [NSString stringWithFormat:@"%@", self.list[@"jingdian"]];
            name = @"景点";
            break;
        case 1:
            count = [NSString stringWithFormat:@"%@", self.list[@"minsu"]];
            name = @"民宿";
            break;
        case 2:
            count = [NSString stringWithFormat:@"%@", self.list[@"chuxing"]];
            name = @" 出行";
            break;
        default:
            break;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@的搜索结果有%@个", name, count];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{//景点
            [self searchJingdian];
        }
            break;
        case 1:{//民宿
            [self  searchMinsu];
        }
            break;
        case 2:{//出行
            [self  searchChuxing];
        }
            break;
        default:
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    self.searchController.searchBar.hidden = NO;
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //[self.navigationController.navigationBar setHidden:NO];
    self.searchController.searchBar.hidden = YES;
}

#pragma mark searchVC resultUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *text = searchController.searchBar.text;
    if ([text isEqualToString:@""]) {
        [self.tableView reloadData];
        return;
    }
    if (self.type == 0) {
        self.searchController.searchBar.showsCancelButton = NO;
        [DNNetworking getWithURLString:get_home_search parameters:@{@"search": text} success:^(id obj) {
            
            NSString *code = [NSString stringWithFormat:@"%@", [obj valueForKey:@"code"]];
            if ([code isEqualToString:@"200"]) {
                self.list = [obj valueForKey:@"data"];
                [self.tableView reloadData];
            } else {
                NSString *message = [NSString stringWithFormat:@"%@", [obj valueForKey:@"message"]];
                [self.view showWarning:message];
            }
            
        } failure:^(NSError *error) {
            [self.view showWarning:@"网络错误"];
        }];
    }
    
}

- (void)searchJingdian{
    NSString *text = self.searchController.searchBar.text;
    [self.searchController.searchBar resignFirstResponder];
    [self.view endEditing:YES];
    ScenicTVC *vc = [[ScenicTVC alloc] initWithSearchType:SearchTypeScenic Searchtext: text];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)searchChuxing{
    NSString *text = self.searchController.searchBar.text;
    [self.searchController.searchBar resignFirstResponder];
    ShunFengCheCVC *vc = [[ShunFengCheCVC alloc] initWithSearchText:text searchType:SearchTypeChuxing];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)searchMinsu{
    NSString *text = self.searchController.searchBar.text;
    [self.searchController.searchBar resignFirstResponder];
    FoodCollectionVC *vc = [[FoodCollectionVC alloc] initWithSearchType:SearchTypeMinsu Searchtext:text];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)searchMeishi{
    NSString *text = self.searchController.searchBar.text;
    [self.searchController.searchBar resignFirstResponder];
    FoodCollectionVC *vc = [[FoodCollectionVC alloc] initWithSearchType:SearchTypeFood Searchtext:text];
    [self.navigationController pushViewController:vc animated:YES];
}




- (UISearchController *)searchController{
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.delegate = self;
        _searchController.searchResultsUpdater = self;
        _searchController.searchBar.placeholder = @"请输入搜索内容";
        _searchController.searchBar.frame = CGRectMake(_searchController.searchBar.frame.origin.x, _searchController.searchBar.frame.origin.y, _searchController.searchBar.frame.size.width, 44.0);
        self.tableView.tableHeaderView = _searchController.searchBar;
        _searchController.hidesNavigationBarDuringPresentation = NO;
        self.searchController.dimsBackgroundDuringPresentation = NO;
        self.searchController.obscuresBackgroundDuringPresentation = NO;
        
    }
    return _searchController;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)initWithSearchType:(SearchType)type{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}


@end
