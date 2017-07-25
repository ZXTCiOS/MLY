//
//  ScenicListModel.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/24.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ScenicelEmentModel;

@interface ScenicListModel : NSObject

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) NSArray<ScenicelEmentModel *> *data;

@end


@interface ScenicelEmentModel : NSObject

@property (nonatomic, copy) NSString *scenic_intro;

@property (nonatomic, copy) NSString *scenic_name;

@property (nonatomic, assign) NSInteger scenic_id;

@property (nonatomic, copy) NSString *scenic_pic;

@property (nonatomic, assign) BOOL is_shoucang;

@property (nonatomic, assign) double min_price;
@end
