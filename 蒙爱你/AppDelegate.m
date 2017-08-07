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
    NSString *APPID = WEIXIAPPID;
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
    
    if ([url.scheme isEqualToString:WEIXIAPPID]) {
        return [WXApi handleOpenURL:url delegate:self];
    }else if ([url.scheme isEqualToString:[NSString stringWithFormat:@"tencent%@",QQShareAPPID]]) {
        return [TencentOAuth HandleOpenURL:url];
    }else {
        return YES;
    }
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if ([url.scheme isEqualToString:WEIXIAPPID]) {
        return [WXApi handleOpenURL:url delegate:self];
    }else if ([url.scheme isEqualToString:[NSString stringWithFormat:@"tencent%@",QQShareAPPID]]) {
       return  [QQApiInterface handleOpenURL:url delegate:self];
    }else {
        return YES;
    }
    return YES;
}

-(void)onResp:(id)resp
{
    if ([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        SendMessageToWXResp *WxResp = (SendMessageToWXResp *)resp;
        
        NSString *str ;//= [NSString stringWithFormat:@"%d",resp.errCode];
        if(WxResp.errCode==0)
        {
            str=@"分享成功!";
        }
        else{
            str=@"分享失败!";
        }
        
        //初始化UIAlertController
        UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:@"结果反馈" message:str preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        [alertCtl addAction:alertAction];
        //初始化UIWindows
        UIWindow *aW = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        aW.rootViewController = [[UIViewController alloc]init];
        aW.windowLevel = UIWindowLevelAlert + 1;
        [aW makeKeyAndVisible];
        [aW.rootViewController presentViewController:alertCtl animated:YES completion:nil];
        
        
    }
    if ([resp isKindOfClass:[SendMessageToQQResp class]]) {
        
        SendMessageToQQResp * QQResp = (SendMessageToQQResp *)resp;
        if (QQResp.type==ESENDMESSAGETOQQRESPTYPE&&[QQResp.result integerValue]==0)
        {

            
            //初始化UIAlertController
            UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:@"成功" message:@"QQ分享成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
            [alertCtl addAction:alertAction];
            //初始化UIWindows
            UIWindow *aW = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
            aW.rootViewController = [[UIViewController alloc]init];
            aW.windowLevel = UIWindowLevelAlert + 1;
            [aW makeKeyAndVisible];
            [aW.rootViewController presentViewController:alertCtl animated:YES completion:nil];

        }
        else
        {
            //初始化UIAlertController
            UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:@"失败" message:@"QQ分享失败" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
            [alertCtl addAction:alertAction];
            //初始化UIWindows
            UIWindow *aW = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
            aW.rootViewController = [[UIViewController alloc]init];
            aW.windowLevel = UIWindowLevelAlert + 1;
            [aW makeKeyAndVisible];
            [aW.rootViewController presentViewController:alertCtl animated:YES completion:nil];

        }
        
    }
    
}


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
