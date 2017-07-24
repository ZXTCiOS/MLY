//
//  ShopViewModel.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/10.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopGoodsModel.h"


typedef NS_ENUM(NSUInteger, ShopType) {
    ShopTypeSovenir, // 纪念品
    ShopTypeArt,    // 艺术品
    ShopTypeFood,    // 食品
};


typedef NS_ENUM(NSUInteger, RequestMode) {
    RequestModeRefresh,
    RequestModeMore,
};

@interface ShopViewModel : NSObject


@property (nonatomic, strong) NSMutableArray<ShopGoodsModel *> *datalist;


- (NSURL *)imageURLatIndexPath:(NSIndexPath *)indexpath;
- (NSString *)nameAtIndexPath:(NSIndexPath *)indexpath;
- (NSString *)detailAtIndexPath:(NSIndexPath *)indexpath;
- (NSString *)descriptionAtIndexPath:(NSIndexPath *)indexpath;
- (NSString *)discountAtIndexPath:(NSIndexPath *)indexpath;
- (BOOL)isStoredAtIndexPath:(NSIndexPath *)indexpath;
- (NSString *)priceAtIndexPath:(NSIndexPath *)indexpath;



- (void)getDataWithRequestMode:(RequestMode) mode handler:(void(^)(NSError *error)) handler;

- (instancetype)initWithShopType:(ShopType) type;


@end
