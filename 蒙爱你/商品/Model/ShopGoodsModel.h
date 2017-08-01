//
//  ShopGoodsModel.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/10.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopGoodsModel : NSObject

@property (nonatomic, copy) NSString *goods_img;

@property (nonatomic, copy) NSString *goods_name;

@property (nonatomic, copy) NSString *goods_detail;

@property (nonatomic, assign) NSInteger goods_id;

@property (nonatomic, assign) NSInteger goods_price;

@property (nonatomic, assign) NSInteger goods_lownum;

@property (nonatomic, assign) NSInteger goods_lowprice;

@property (nonatomic, copy) NSString *goods_description;

@property (nonatomic, assign) NSInteger goods_type;

@property (nonatomic, assign) NSInteger time;

@property (nonatomic, assign) BOOL isStored;

@property (nonatomic,strong) NSString *is_shoucang;
@end
