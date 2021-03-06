//
//  myOrderModel.h
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/26.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface myOrderModel : NSObject
@property (nonatomic,strong) NSString *orderimgstr;
@property (nonatomic,strong) NSString *namestr;
@property (nonatomic,strong) NSString *pricestr;
@property (nonatomic,strong) NSString *contentstr;
@property (nonatomic,strong) NSString *goods_description;
@property (nonatomic,strong) NSString *goods_id;
@property (nonatomic,strong) NSString *numstr;
@property (nonatomic,strong) NSString *totalpricestr;
@property (nonatomic,strong) NSString *preferentialstr;
@property (nonatomic,strong) NSString *orderidstr;
@property (nonatomic,strong) NSString *ordersn;

@property (nonatomic,strong) NSString *addressid;
@property (nonatomic,strong) NSString *discount_id;

@property (nonatomic,strong) NSString *discountprice;

@property (nonatomic,strong) NSString *ordertype;

@property (nonatomic,strong) NSString *goods_type;
//退款原因
@property (nonatomic,strong) NSString *refundstr;

@property (nonatomic,strong) NSString *home_id;

@end
