//
//  FoodDataModel.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/28.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <Foundation/Foundation.h>


@class FoodDetailModel, FoodHeadModel, FoodModel;
@interface FoodDataModel : NSObject

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, strong) FoodDetailModel *data;

@property (nonatomic, copy) NSString *message;

@end

@interface FoodDetailModel : NSObject

@property (nonatomic, strong) NSArray<FoodModel *> *food;

@property (nonatomic, strong) FoodHeadModel *home;

@end

@interface FoodModel : NSObject

@property (nonatomic, copy) NSString *bedeat_des;
@property (nonatomic, copy) NSString *bedeat_intro;
@property (nonatomic, copy) NSString *bedeat_name;
@property (nonatomic, copy) NSString *bedeat_pic;
@property (nonatomic, assign) float bedeat_price;
@property (nonatomic, assign) NSInteger bedeat_id;

@property (nonatomic, assign) NSInteger bedeat_count;

@property (nonatomic, assign) BOOL isselected;
@property (nonatomic, assign) NSInteger cart_id;
@end
@interface FoodHeadModel : NSObject

@property (nonatomic, copy) NSString *home_address;
@property (nonatomic, copy) NSString *home_description;
@property (nonatomic, assign) NSInteger home_id;
@property (nonatomic, copy) NSString *home_name;
@property (nonatomic, copy) NSString *home_phone;
@property (nonatomic, copy) NSString *home_pic;
@property (nonatomic, assign) NSInteger home_star;

@end





