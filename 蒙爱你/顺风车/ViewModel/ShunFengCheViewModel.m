//
//  ShunFengCheViewModel.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/6.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "ShunFengCheViewModel.h"

@implementation ShunFengCheViewModel



- (void)getDataWithMode:(RequestMode)mode SearchText:(NSString *)text handller:(void (^)(NSError *))handller{
    
    if (mode == RequestModeRefresh) {
        self.page = 1;
    }
    NSDictionary *dic;
    NSInteger user_id = [[NSUserDefaults standardUserDefaults] integerForKey:user_key_user_id];
    if ([userDefault integerForKey:user_key_user_id]) {
        dic = @{@"page":@(self.page), @"user_id": @(user_id), @"type": @(2), @"search": text};
    }
    dic = @{@"page":@(self.page), @"user_id": @(user_id), @"type": @(2), @"search": text};
    [DNNetworking getWithURLString:get_search_other parameters:dic success:^(id obj) {
        if (mode == RequestModeRefresh) {
            [self.datalist removeAllObjects];
        }
        NSArray *arr = [NSArray modelArrayWithClass:[HomeTravelModel class] json:[[obj valueForKey:@"data"] valueForKey:@"chuxing"]];
        [self.datalist addObjectsFromArray:arr];
        !handller ?: handller(nil);
    } failure:^(NSError *error) {
        !handller ?: handller(error);
    }];
    
}


- (void)getDataWithMode:(RequestMode)mode url:(NSString *)url handller:(void (^)(NSError *))handller{
    
    if (!mode) {
        self.page = 1;
    }
    
    [DNNetworking getWithURLString:[NSString stringWithFormat:url, self.page] success:^(id obj) {
        NSString *code = [NSString stringWithFormat:@"%@", [obj valueForKey:@"code"]];
        if ( [code isEqualToString:@"200"]) {
            ShunFengCheModel *model = [ShunFengCheModel parse:obj];
            if (mode == RequestModeRefresh) {
                [self.datalist removeAllObjects];
            }
            [self.datalist addObjectsFromArray:model.data];
            self.page++;
            !handller ?: handller(nil);
        } else {
            
        }
        
    } failure:^(NSError *error) {
        !handller ?: handller(error);
    }];
}

- (NSMutableArray<HomeTravelModel *> *)datalist{
    if (!_datalist) {
        _datalist = [[NSMutableArray<HomeTravelModel *> alloc] init];
    }
    return _datalist;
}


/*
- (void)postDataWithTokenandMode:(RequestMode)mode url:(NSString *)url handller:(void (^)(NSError *))handller{
    if (!mode) {
        self.page = 0;
    }
    
    
    NSDictionary *dic = @{user_key_token: [userDefault objectForKey:user_key_token], @"page": @(self.page), user_key_user_id: [userDefault objectForKey:user_key_user_id]};
    [DNNetworking postWithURLString:url parameters:dic success:^(id obj) {
        ShunFengCheModel *model = [ShunFengCheModel parse:obj];
        if (!model) {
            [self.datalist removeAllObjects];
        }
        [self.datalist addObjectsFromArray:model.data];
        self.page++;
        !handller ?: handller(nil);
    } failure:^(NSError *error) {
        !handller ?: handller(error);
    }];
}

*/

@end
