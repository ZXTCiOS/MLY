//
//  ShopViewModel.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/10.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "ShopViewModel.h"


@interface ShopViewModel ()

@property (nonatomic, assign) ShopType type;

@property (nonatomic, assign) NSInteger page;

@end

@implementation ShopViewModel


- (NSURL *)imageURLatIndexPath:(NSIndexPath *)indexpath{
    return self.datalist[indexpath.row].goods_img.xd_URL;
}
- (NSString *)nameAtIndexPath:(NSIndexPath *)indexpath{
    return self.datalist[indexpath.row].goods_name;
}
- (NSString *)detailAtIndexPath:(NSIndexPath *)indexpath{
    return self.datalist[indexpath.row].goods_detail;
}
- (NSString *)descriptionAtIndexPath:(NSIndexPath *)indexpath{
    return self.datalist[indexpath.row].goods_description;
}
- (NSString *)discountAtIndexPath:(NSIndexPath *)indexpath{
    NSInteger lowprice = self.datalist[indexpath.row].goods_lowprice;
    NSInteger lownum = self.datalist[indexpath.row].goods_lownum;
    NSInteger price = self.datalist[indexpath.row].goods_price;
    return [NSString stringWithFormat:@"单价%ld, 满%ld件批发价%ld", price, lownum, lowprice];
}
- (BOOL)isStoredAtIndexPath:(NSIndexPath *)indexpath{
    return self.datalist[indexpath.row].isStored;
}
- (NSString *)priceAtIndexPath:(NSIndexPath *)indexpath{
    return [NSString stringWithFormat:@"¥%ld", self.datalist[indexpath.row].goods_price];
}







- (void)getDataWithRequestMode:(RequestMode)mode handler:(void (^)(NSError *))handler{
    if (mode == RequestModeRefresh) {
        self.page = 0;
    }
    
    NSString *path = nil;
    switch (self.type) {
        case ShopTypeSovenir:
            path = post_shop_sovenir;
            break;
        case ShopTypeArt:
            path = post_shop_art;
            break;
        case ShopTypeFood:
            path = post_shop_food;
            break;
        default:
            break;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([userDefault objectForKey:user_key_user_id]) {
        [dic setObject:[userDefault objectForKey:user_key_user_id] forKey:user_key_user_id];
    }
    
    [dic setObject:@(self.page) forKey:@"page"];
    [DNNetworking getWithURLString:path parameters:dic success:^(id obj) {
        
        
        
        
        
        !handler ?: handler(nil);
    } failure:^(NSError *error) {
        !handler ?: handler(error);
    }];
    
}


- (NSMutableArray<ShopGoodsModel *> *)datalist{
    if (!_datalist) {
        _datalist = [NSMutableArray<ShopGoodsModel *> array];
    }
    return _datalist;
}

- (instancetype)initWithShopType:(ShopType)type{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

@end
