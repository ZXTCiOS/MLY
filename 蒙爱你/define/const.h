
//
//  const.h
//  zhongxunLive
//
//  Created by mahaibo on 17/6/22.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#ifndef const_h
#define const_h

//屏幕 宽 高
#define kScreenW ([UIScreen mainScreen].bounds.size.width)
#define kScreenH ([UIScreen mainScreen].bounds.size.height)


//RGBA Color
#define krgb(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define SizeScale (kScreenW != 414 ? 1 : 1.2)
#define kFont(value) [UIFont systemFontOfSize:value * SizeScale]

/********* 去掉Cell分割线的左边距   *************/
#define kRemoveLeftSeparator(cell) \
cell.separatorInset = UIEdgeInsetsZero;\
cell.layoutMargins = UIEdgeInsetsZero;\
cell.preservesSuperviewLayoutMargins = NO;\

#define weak(T) __weak typeOf(T) weakT = T


#define userDefault [NSUserDefaults standardUserDefaults]



#define check_user_id \
if (![userDefault valueForKey:user_key_user_id]) {\
UIStoryboard *stb = [UIStoryboard storyboardWithName:@"main" bundle:nil]\
loginVC *vc = [stb instantiateInitialViewController];\
[self.navigationController presentViewController:vc animated:YES completion:nil];\
}\
NSString *user_id = [userDefault valueForKey:user_key_user_id];\



#define PresentLoginVC \
UIStoryboard *stb = [UIStoryboard storyboardWithName:@"main" bundle:nil];\
loginVC *vc = [stb instantiateInitialViewController];\
[self.navigationController presentViewController:vc animated:YES completion:nil];\


#define kget_userID NSString *user_id = [userDefault valueForKey:user_key_user_id];
#define kget_token  NSString *token = [userDefault valueForKey:user_key_token];

/*
 *  debug ?  release?
 */

#define isDebug YES

/*
 *  NSUserDefaults    KEY
 */

#define user_key_token  @"token"
#define user_key_tele  @"tele"
#define user_key_user_id  @"user_id"
#define user_key_icon  @"icon"
#define user_key_token  @"token"
#define user_key_token  @"token"
#define user_key_token  @"token"
#define user_key_token  @"token"
#define user_key_token  @"token"






#define kefudianhua @"10086"       //  客服电话



#endif /* const_h */


