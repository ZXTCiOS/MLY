//
//  ShunFengCheModel.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/6.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeTravelModel.h"

@interface ShunFengCheModel : NSObject

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, strong) NSArray<HomeTravelModel *> *data;

@property (nonatomic, copy) NSString *message;


@end
