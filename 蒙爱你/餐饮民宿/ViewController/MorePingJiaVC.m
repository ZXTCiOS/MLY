//
//  MorePingJiaVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/29.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "MorePingJiaVC.h"

@interface MorePingJiaVC ()
@property (nonatomic, assign) NSInteger minsu_id;



@end

@implementation MorePingJiaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self net];
    
}

- (void)net{
    [DNNetworking getWithURLString:get_more_judge parameters:@{@"minsu_id": @(self.minsu_id)} success:^(id obj) {
        
    } failure:^(NSError *error) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}







- (instancetype)initWithMinsu_id:(NSInteger)minsu_id{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.minsu_id = minsu_id;
    }
    return self;
}




@end
