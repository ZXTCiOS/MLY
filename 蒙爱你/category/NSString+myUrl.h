//
//  NSString+myUrl.h
//  zhongxunLive
//
//  Created by mahaibo on 17/6/21.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (myUrl)

/** 增加了逻辑判断, 对于文件路径 和 网络路径进行不同的处理  */
@property (nonatomic, readonly) NSURL *xd_URL;

@end
