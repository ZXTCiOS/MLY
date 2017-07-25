//
//  Scenic12Model.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/12.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <Foundation/Foundation.h>


@class ScenicAreaModel;
@interface Scenic12Model : NSObject

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) NSArray<ScenicAreaModel *> *data;

@end


@interface ScenicAreaModel : NSObject

@property (nonatomic, copy) NSString *area_des;

@property (nonatomic, copy) NSString *area_name;

@property (nonatomic, assign) NSInteger area_id;

@property (nonatomic, copy) NSString *area_pic;

@property (nonatomic, assign) BOOL is_shoucang;

@property (nonatomic, assign) double min_price;
@end
