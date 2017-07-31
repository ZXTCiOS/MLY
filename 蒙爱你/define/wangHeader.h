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

#import <FORScrollViewEmptyAssistant/FORScrollViewEmptyAssistant.h>


//#define baseURL                 @"http://192.168.1.142"         // baseurl

#define sessionID  @"sessionID"

#define get_shop_sovenir           @""baseURL"/MLY/api.php/Good/goodList?user_id=%@&type=1?page=%@"      // 商城 纪念品
#define get_shop_art               @""baseURL"/MLY/api.php/Good/goodList?user_id=%@&type=2?page=%@"      // 商城 工艺品
#define get_shop_food              @""baseURL"/MLY/api.php/Good/goodList?user_id=%@&type=3?page=%@"      // 商城 特色食品


//登录

#define denglucaozuo @""baseURL"/MLY/api.php/Login/login"
//我的订单
#define get_myorder  @""baseURL"/MLY/api.php/User/myOrder?user_id=%@&api_token=%@&order_type=%@"

//详细订单
#define get_detalorder @""baseURL"/MLY/api.php/User/myOrderDetail?user_id=%@&api_token=%@&order_sn=%@"
//收藏
#define get_shoucang @""baseURL"/MLY/api.php/Index/myLike?user_id=%@&type=%@&page=%@"
//取消收藏
#define get_quxiaoshoucang @""baseURL"/MLY/api.php/Index/noLike?user_id=%@&recommend_id=%@"
//收货地址添加
#define post_addaddress @""baseURL"/MLY/api.php/Address/addressAdd"
//收货地址
#define get_address @""baseURL"/MLY/api.php/Address/addressLook?user_id=%@&api_token=%@&address_id=%@"

//修改收货地址
#define post_addressEdit @""baseURL"/MLY/api.php/Address/addressEdit"
//删除收货地址
#define post_addressDelete @""baseURL"/MLY/api.php/Address/del"

//确认订单

#define get_confirmOrder @""baseURL"/MLY/api.php/Order/confirmOrder?user_id=%@&api_token=%@&goods_type=%@"
//我的优惠券
#define get_discount   @""baseURL"/MLY/api.php/Index/discount?user_id=%@"
//确认下单
#define post_placeOrder  @""baseURL"/MLY/api.php/Order/placeOrder"
//用户个人信息查看
#define get_info @""baseURL"/MLY/api.php/User/detail?user_id=%@&api_token=%@"
#endif /* wangHeader_h */
