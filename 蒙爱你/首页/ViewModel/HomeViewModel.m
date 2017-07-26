//
//  HomeViewModel.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/5.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "HomeViewModel.h"

@implementation HomeViewModel






- (void)GetRefreshHomeCompletionHandller:(void (^)(NSError *))handller{
    NSDictionary *dic;
    if ([userDefault valueForKey:@"user_id"]) {
        dic = @{@"user_id": [userDefault valueForKey:@"user_id"]};
    }
    
    [DNNetworking getWithURLString:get_Home_zhuye parameters:dic success:^(id obj) {
        HomeModel *model = [HomeModel parse:obj];
        [self.bannerList removeAllObjects];
        [self.scenicList removeAllObjects];
        [self.travelList removeAllObjects];
        [self.foodList removeAllObjects];
        
        self.scenicNum = 0;
        self.travelNum = 0;
        self.foodNum = 0;
        
        [self.bannerList addObjectsFromArray:model.data.lunbo];
        [self.scenicList addObjectsFromArray:model.data.jingdian];
        [self.foodList addObjectsFromArray:model.data.minsu];
        [self.travelList addObjectsFromArray:model.data.chuxing];
        
        !handller ?: handller(nil);
        
    } failure:^(NSError *error) {
        
        !handller ?: handller(error);
        
    }];
}

- (void)PostMoreType:(HomeMoreOfType)type completionHandller:(void (^)(NSError *))handller{
    NSString *url = nil;
    NSMutableDictionary *dic = nil;
    switch (type) {
        case HomeMoreOfTypeScenic:{
            url = post_home_scenic_more;
            [dic setValue:@(self.scenicNum) forKey:@"page"];
        }
            break;
        case HomeMoreOfTypeTravel:{
            url = post_home_travel_more;
            [dic setValue:@(self.travelNum) forKey:@"page"];
        }
            break;
        case HomeMoreOfTypeFood:{
            url = post_home_food_more;
            [dic setValue:@(self.foodNum) forKey:@"page"];
        }
            break;
        default:
            break;
    }
    
    NSInteger user_id = [userDefault integerForKey: user_key_user_id];
    if (user_id) {
        [dic setValue:@(user_id) forKey:@"user_id"];
    }
    
    [DNNetworking getWithURLString:url parameters:dic success:^(id obj) {
        switch (type) {
            case HomeMoreOfTypeScenic:{
                HomeModel *model = [HomeModel parse:obj];
                [self.scenicList addObjectsFromArray:model.data.jingdian];
                self.scenicNum++;
            }
                break;
            case HomeMoreOfTypeTravel:{
                HomeModel *model = [HomeModel parse:obj];
                [self.travelList addObjectsFromArray:model.data.chuxing];
                self.travelNum++;
            }
                break;
            case HomeMoreOfTypeFood:{
                HomeModel *model = [HomeModel parse:obj];
                [self.foodList addObjectsFromArray:model.data.minsu];
                self.foodNum++;
            }
                break;
            default:
                break;
        }
        !handller ?: handller(nil);
    } failure:^(NSError *error) {
        !handller ?: handller(error);
    }];
}






- (NSMutableArray<HomeBannerModel *> *)bannerList{
    if (!_bannerList) {
        _bannerList = [[NSMutableArray<HomeBannerModel *> alloc] init];
    }
    return _bannerList;
}


- (NSMutableArray<HomeScenicModel *> *)scenicList{
    if (!_scenicList) {
        _scenicList = [[NSMutableArray<HomeScenicModel *> alloc] init];
        self.scenicNum = 0;
    }
    return _scenicList;
}

- (NSMutableArray<HomeTravelModel *> *)travelList{
    if (!_travelList) {
        _travelList = [[NSMutableArray<HomeTravelModel *> alloc] init];
        self.travelNum = 0;
    }
    return _travelList;
}

- (NSMutableArray<HomeFoodModel *> *)foodList{
    if (!_foodList) {
        _foodList = [[NSMutableArray<HomeFoodModel *> alloc] init];
        self.foodNum = 0;
    }
    return _foodList;
}


@end
