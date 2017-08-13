//
//  HomeTravelModel.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/5.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeTravelModel : NSObject


@property (nonatomic, copy) NSString *is_shoucang;

@property (nonatomic, copy) NSString *trip_address;

@property (nonatomic, copy) NSString *trip_driver;

@property (nonatomic, assign) NSInteger trip_id;

@property (nonatomic, copy) NSString *trip_driver_pic;

@property (nonatomic, copy) NSString *trip_line;

@property (nonatomic, copy) NSString *trip_time;

@property (nonatomic, assign) NSInteger trip_people;

@property (nonatomic, copy) NSString *trip_pic;

@property (nonatomic, assign) NSInteger trip_phone;

@end
