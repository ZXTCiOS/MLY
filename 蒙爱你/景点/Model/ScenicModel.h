//
//  ScenicModel.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/12.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <Foundation/Foundation.h>


@class tickets, ScenicBannerModel, ScenicDetailModel;

@interface ScenicModel : NSObject

@property (nonatomic, copy) NSString *gonglue_href;

@property (nonatomic, strong) NSArray<tickets *> *jingdian_ticket;

@property (nonatomic, strong) NSArray<ScenicBannerModel *> *jingdian_lunbo;

@property (nonatomic, strong) ScenicDetailModel *jingdian_xiangqing;


@end


@interface tickets : NSObject

@property (nonatomic, copy) NSString *ticket_name;

@property (nonatomic, assign) double ticket_price;

@property (nonatomic, assign) NSInteger ticket_id;

@property (nonatomic, copy) NSString *ticket_intro;

@property (nonatomic, copy) NSString *must_know;


@end


@interface ScenicBannerModel : NSObject

@property (nonatomic, copy) NSString *image_url;

@end

@interface ScenicDetailModel : NSObject

@property (nonatomic, assign) NSInteger scenic_id;

@property (nonatomic, copy) NSString *scenic_intro;

@property (nonatomic, copy) NSString *scenic_name;

@property (nonatomic, copy) NSString *scenic_pic;

@property (nonatomic, copy) NSString *scenic_address;

@end






