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
#import "Transition_Scenic.h"   
#import "MBProgressHUD+XMG.h"
@interface ScenicTVC ()<UINavigationControllerDelegate,mycellticketVdelegate>
@property (nonatomic, strong) ScenicViewModel *viewmodel;

@property (nonatomic, assign) NSInteger area_id;

@property (nonatomic, copy) NSString *searchtext;
@property (nonatomic, assign) SearchType type;

@end

@implementation ScenicTVC

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        Transition_Scenic *t = [ Transition_Scenic TransitionWithTransitionType:TransitionTypePush pushsource:PushSourceList];
        return t;
    }
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MJWeakSelf
    [self.tableView addHeaderRefresh:^{
        [weakSelf HeadRefresh];
    }];
    [self.tableView addFooterRefresh:^{
        [weakSelf FoodRefresh];
    }];
    [self.tableView beginHeaderRefresh];
    
    
    [XDFactory addBackItemForVC:self];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"ScenicCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}

- (void)HeadRefresh{
    if (self.type == SearchTypeScenic) {
        [self.viewmodel getDataWithSearchText:self.searchtext RequestMode:RequestModeRefresh handller:^(NSError *error) {
            if (!error) {
                
                [self.tableView reloadData];
                [self.tableView endHeaderRefresh];
            } else {
                [self.tableView showWarning:@"网络错误"];
                [self.tableView endHeaderRefresh];
            }
        }];
    } else {
        [self.viewmodel getDataWithRequestMode:RequestModeRefresh withID:self.area_id handller:^(NSError *error) {
            if (!error) {
                
                [self.tableView reloadData];
                [self.tableView endHeaderRefresh];
            } else {
                [self.tableView showWarning:@"网络错误"];
                [self.tableView endHeaderRefresh];
            }
        }];
    }
}

- (void)FoodRefresh{
    if (self.type == SearchTypeScenic) {
        [self.viewmodel getDataWithSearchText:self.searchtext RequestMode:RequestModeMore handller:^(NSError *error) {
            if (!error) {
                
                [self.tableView reloadData];
                [self.tableView endFooterRefresh];
            } else {
                [self.tableView showWarning:@"网络错误"];
                [self.tableView endFooterRefresh];
            }
        }];
    } else {
        [self.viewmodel getDataWithRequestMode:RequestModeMore withID:self.area_id handller:^(NSError *error) {
            if (!error) {
                
                [self.tableView reloadData];
                [self.tableView endFooterRefresh];
            } else {
                [self.tableView showWarning:@"网络错误"];
                [self.tableView endFooterRefresh];
            }
        }];
    }
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
    if (model.is_shoucang) {
        cell.shoucangImg.image = [UIImage imageNamed:@"sc-s"];
    }
    else
    {
        cell.shoucangImg.image = [UIImage imageNamed:@"sc-ns"];
    }
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.currentIndex = indexPath;
    ScenicVC *vc = [[ScenicVC alloc] initWithScenic_id:self.viewmodel.datalist[indexPath.row].scenic_id pushsource:PushSourceList];
    [vc.imageV sd_setImageWithURL:self.viewmodel.datalist[indexPath.row].scenic_pic.xd_URL];
    vc.image_url = self.viewmodel.datalist[indexPath.row].scenic_pic;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}


-(void)myTabVClickticket:(UITableViewCell *)cell
{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    ScenicelEmentModel *model = self.viewmodel.datalist[index.row];
    NSString *userid = [userDefault objectForKey:user_key_user_id];
    NSString *type = @"1";
    NSString *isstr = [NSString stringWithFormat:@"%ld",(long)model.scenic_id];
    NSString *is_shoucang  = @"";
    if (model.is_shoucang==1) {
        is_shoucang = @"0";
    }else
    {
        is_shoucang = @"1";
    }
    NSString *urlstr = [NSString stringWithFormat:get_recommend,userid,isstr,type,is_shoucang];
    
    [DNNetworking getWithURLString:urlstr success:^(id obj) {
        if ([[obj objectForKey:@"code"]intValue]==200) {
            [self.tableView.mj_header beginRefreshing];
            [MBProgressHUD showSuccess:@"操作成功"];
        }
        else
        {
            NSString *hud = [obj objectForKey:@"message"];
            [MBProgressHUD showSuccess:hud];
        }
    } failure:^(NSError *error) {
        
    }];

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

- (instancetype)initWithSearchType:(SearchType)type Searchtext:(NSString *)text{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.searchtext = text;
        self.type = type;
    }
    return self;
}




@end
