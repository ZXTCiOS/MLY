//
//  AppDelegate.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/4.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarController.h"
#import <MLTransition.h>
#import <AFNetworking.h>


// 三方登录, 分享
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentMessageObject.h>
#import <TencentOpenAPI/TencentApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/QQApiInterface.h>


//runime防止崩溃系统
#import "AvoidCrash.h"
#import "NSArray+AvoidCrash.h"

@interface AppDelegate ()<WXApiDelegate,QQApiInterfaceDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    // 从微信开放平台获取
    NSString *APPID = @"wx6b7c06a04f9f1f04";
    // 向微信注册
    [WXApi registerApp:APPID];
    

    
    
    [self configInfo];
//    //启动防止崩溃功能
//    [AvoidCrash becomeEffective];
//    
//    //监听通知:AvoidCrashNotification, 获取AvoidCrash捕获的崩溃日志的详细信息
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealwithCrashMessage:) name:AvoidCrashNotification object:nil];
    
    return YES;
}



-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:self];
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    
    if ([url.scheme isEqualToString:@"wx6b7c06a04f9f1f04"]) {
        return [WXApi handleOpenURL:url delegate:self];
    }else if ([url.scheme isEqualToString:[NSString stringWithFormat:@"tencent%@",@"1106124714"]]) {
        return [QQApiInterface handleOpenURL:url delegate:self];
    }else {
        return YES;
    }
    

    
   // return [WXApi handleOpenURL:url delegate:self];
}
#pragma mark -- QQApiInterfaceDelegate
// 处理来自QQ的请求，调用sendResp
- (void)onReq:(QQBaseReq *)req {
    
}

// 处理来自QQ的响应，调用sendReq
- (void)onResp:(QQBaseReq *)resp {
    switch (resp.type)
    {
        case ESENDMESSAGETOQQRESPTYPE:
        {
            SendMessageToQQResp* sendResp = (SendMessageToQQResp*)resp;
            if ([sendResp.result isEqualToString:@"0"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功" message:@"QQ分享成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"失败" message:@"QQ分享失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            break;
        }
        default:
        {
            break;
        }
    }
}
// 处理QQ在线状态的回调
- (void)isOnlineResponse:(NSDictionary *)response {
    
}


#pragma mark WXApiDelegate 微信分享的相关回调

//// onReq是微信终端向第三方程序发起请求，要求第三方程序响应。第三方程序响应完后必须调用sendRsp返回。在调用sendRsp返回时，会切回到微信终端程序界面
//- (void)onReq:(BaseReq *)req
//{
//    NSLog(@"onReq是微信终端向第三方程序发起请求，要求第三方程序响应。第三方程序响应完后必须调用sendRsp返回。在调用sendRsp返回时，会切回到微信终端程序界面");
//}
//
//// 如果第三方程序向微信发送了sendReq的请求，那么onResp会被回调。sendReq请求调用后，会切到微信终端程序界面
//- (void)onResp:(BaseResp *)resp
//{
//    NSLog(@"回调处理");
//    
//    // 处理 分享请求 回调
//    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
//        switch (resp.errCode) {
//            case WXSuccess:
//            {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                                message:@"分享成功!"
//                                                               delegate:self
//                                                      cancelButtonTitle:@"OK"
//                                                      otherButtonTitles:nil, nil];
//                [alert show];
//            }
//                break;
//                
//            default:
//            {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                                message:@"分享失败!"
//                                                               delegate:self
//                                                      cancelButtonTitle:@"OK"
//                                                      otherButtonTitles:nil, nil];
//                [alert show];
//            }
//                break;
//        }
//    }
//}



- (void)configInfo{
    
    [UIImageView appearance].clipsToBounds = YES;
    [MLTransition validatePanBackWithMLTransitionGestureRecognizerType:MLTransitionGestureRecognizerTypeScreenEdgePan];
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    if ([userDefault valueForKey:user_key_user_id]) {
        _window.rootViewController = [[TabBarController alloc] init];
        _window.backgroundColor = [UIColor whiteColor];
        [_window makeKeyAndVisible];
    }
    
    
}






- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)dealwithCrashMessage:(NSNotification *)note {
    //不论在哪个线程中导致的crash，这里都是在主线程
    
    //注意:所有的信息都在userInfo中
    //你可以在这里收集相应的崩溃信息进行相应的处理(比如传到自己服务器)
    NSLog(@"\n\n在AppDelegate中 方法:dealwithCrashMessage打印\n\n\n\n\n%@\n\n\n\n",note.userInfo);
}


@end
