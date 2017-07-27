//
//  MinsuListModel.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/21.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeFoodModel.h"

@interface MinsuListModel : NSObject

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, strong) NSArray<HomeFoodModel *> *data;

@property (nonatomic, copy) NSString *message;


@end
