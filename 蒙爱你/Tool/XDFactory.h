//
//  XDFactory.h
//  zhongxunLive
//
//  Created by mahaibo on 17/6/26.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDFactory : NSObject

//自动为传入的参数拼装上返回按钮
+ (void)addBackItemForVC:(UIViewController *)vc;

//自动为控制器添加右上角的搜索按钮UI
+ (void)addSearchItemForVC:(UIViewController *)vc clickedHandler:(void(^)())handler;





@end
