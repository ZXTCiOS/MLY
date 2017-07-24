//
//  NSString+myUrl.m
//  zhongxunLive
//
//  Created by mahaibo on 17/6/21.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "NSString+myUrl.h"

@implementation NSString (myUrl)

- (NSURL *)xd_URL{
    //http://  https://
    if ([self containsString:@"http://"] || [self containsString:@"https://"]) {
        return [NSURL URLWithString:self];
    }
    return [NSURL fileURLWithPath:self];
}

@end
