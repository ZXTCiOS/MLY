//
//  WKWedViewController.h
//  zhongxunLive
//
//  Created by mahaibo on 17/6/27.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKWedViewController : UIViewController


@property (nonatomic, copy) NSString *titl;

@property (nonatomic, strong) NSURL *url;



- (instancetype)initWithTitle:(NSString *)title Url:(NSURL *)url;

@end
