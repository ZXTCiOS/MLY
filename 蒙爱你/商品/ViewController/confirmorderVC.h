//
//  confirmorderVC.h
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/31.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface confirmorderVC : UIViewController
@property (nonatomic,strong) NSString *goods_typestr;
//1商品 2门票 3住宿 4餐饮 5 美食
@property (nonatomic,strong) NSDictionary *addressdit;
@property (nonatomic,strong) NSDictionary *discountdit;
@property (nonatomic,strong) NSMutableArray *orderDatasource;

@property (nonatomic,strong) NSString *ordersn;
@property (nonatomic,strong) NSString *yudingtime;
@property (nonatomic,strong) NSString *mingsunamestr;
@end
