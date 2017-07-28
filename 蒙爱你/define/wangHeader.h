//
//  wangHeader.h
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/24.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#ifndef wangHeader_h
#define wangHeader_h
//屏幕宽度比
#define WIDTH_SCALE [UIScreen mainScreen].bounds.size.width / 375
//屏幕高度比
#define HEIGHT_SCALE [UIScreen mainScreen].bounds.size.height / 667

/*
 *  网址
 */

//#define baseURL                 @"http://192.168.1.142"         // baseurl

#define get_shop_sovenir           @""baseURL"/MLY/api.php/Good/goodList?user_id=%@&type=1?page=%@"      // 商城 纪念品
#define get_shop_art               @""baseURL"/MLY/api.php/Good/goodList?user_id=%@&type=2?page=%@"      // 商城 工艺品
#define get_shop_food              @""baseURL"/MLY/api.php/Good/goodList?user_id=%@&type=3?page=%@"      // 商城 特色食品

//我的订单
#define get_myorder  @""baseURL"/MLY/api.php/User/myOrder?user_id=%@&user_token=%@&order_type=%@"

//详细订单
#define get_detalorder @""baseURL"/MLY/api.php/User/myOrderDetail?user_id=%@&user_token=%@&order_sn=%@"
//
#define get_shoucang @""baseURL"/MLY/api.php/Index/myLike?user_id=%@&type=%@&page=%@"

#define get_quxiaoshoucang @""baseURL"/MLY/api.php/Index/noLike?user_id=%@&recommend_id=%@"

#endif /* wangHeader_h */
