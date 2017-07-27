
//
//  requestPath.h
//  zhongxunLive
//
//  Created by mahaibo on 17/6/22.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#ifndef requestPath_h
#define requestPath_h


/*
 *  网址
 */

#define baseURL                 @"http://192.168.1.142/"            // baseurl


#define post_register           @"/MLY/api.php/Login/register"      //注册
#define get_yanzhengma          @"/MLY/api.php/Login/getVerify"     //获取验证码
#define post_login              @"/MLY/api.php/Login/login"         //登录
#define get_change_pwd          @"/MLY/api.php/Forget/userChange"   // 修改密码


#define get_Home_zhuye          @"MLY/api.php/Index/index"                  //首页主页
#define post_home_scenic_more   @"/MLY/api.php/Index/jingdianMore"          //首页景点推荐 更多
#define post_home_travel_more   @"/MLY/api.php/Index/chuxingMore"           //首页出行推荐 更多
#define post_home_food_more     @"/MLY/api.php/Index/minsuMore"             //首页餐饮民宿 更多



#define get_12menglist          @"MLY/api.php/Scenic/jingdianFirst"         //12盟列表
#define get_citylist            @"MLY/api.php/Scenic/jingdianSecond"        //12盟下区县列表
#define get_sceniclist          @"MLY/api.php/Scenic/jingdianList"          //区县下景点列表






#define get_shunFengChe_zhuye       @"/MLY/api.php/Trip/tripList"   // 顺风车主页
#define post_shunFengChe_shouCang   @"%ld"   // 顺风车收藏




#define post_shop_sovenir           @""      // 商城 纪念品
#define post_shop_art               @""      // 商城 纪念品
#define post_shop_food              @""      // 商城 纪念品


#define get_food_main               @""      // 餐饮民宿 首页


/*
 *    默认图片
 */

#define img_shunFengChe_default  [UIImage imageNamed:@"39"]     // 顺风车默认图片
#define img_canyinMinsu_default  [UIImage imageNamed:@"1"]      // 餐饮民宿默认图片
#define img_banner_default      [UIImage imageNamed:@"19"]      // 轮播默认


#endif /* requestPath_h */
