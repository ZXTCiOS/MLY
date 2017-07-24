//
//  HomeFoodModel.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/5.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeFoodModel : NSObject

@property (nonatomic, copy) NSString *home_pic;

@property (nonatomic, copy) NSString *home_name;

@property (nonatomic, copy) NSString *detail;

@property (nonatomic, assign) NSInteger home_star;

@property (nonatomic, assign) BOOL is_shoucang;

@property (nonatomic, assign) NSInteger tele;

@property (nonatomic, assign) NSInteger home_id;

@end
