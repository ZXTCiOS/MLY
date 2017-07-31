//
//  submitorderVC.h
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/29.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface submitorderVC : UIViewController
@property (nonatomic,strong) NSString *goods_typestr;
//1商品 2门票 3住宿 4餐饮 5 美食

@property (nonatomic,strong) NSMutableArray *orderDatasource;
@end
