//
//  MinsuDetailModel.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/21.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MinsuDataModel, MinsuArtModel, MinsuBedModel, MinsuEvaluate, MinsuHomeModel;
@interface MinsuDetailModel : NSObject

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, strong) MinsuDataModel *data;

@property (nonatomic, copy) NSString *message;

@end

@interface MinsuDataModel : NSObject

@property (nonatomic, strong) NSArray<MinsuArtModel *> *art;

@property (nonatomic, strong) NSArray<MinsuBedModel *> *eat;

@property (nonatomic, strong) NSArray<MinsuBedModel *> *bed;

@property (nonatomic, strong) MinsuEvaluate *eval;

@property (nonatomic, strong) MinsuHomeModel *home;

@end

@interface MinsuBedModel : NSObject

@property (nonatomic, assign) NSInteger bedeat_id;

@property (nonatomic, copy) NSString *bedeat_name;

@property (nonatomic, copy) NSString *bedeat_pic;

@property (nonatomic, copy) NSString *bedeat_intro;

@property (nonatomic, copy) NSString *bedeat_des;

@property (nonatomic, assign) NSInteger *bedeat_price;

@end

@interface MinsuArtModel : NSObject

@property (nonatomic, copy) NSString *art_logo;

@property (nonatomic, copy) NSString *art_name;

@end



@interface MinsuHomeModel : NSObject

@property (nonatomic, copy) NSString *home_address;

@property (nonatomic, copy) NSString *home_art;

@property (nonatomic, copy) NSString *home_description;

@property (nonatomic, assign) NSInteger home_id;

@property (nonatomic, copy) NSString *home_intro;

@property (nonatomic, copy) NSString *home_name;

@property (nonatomic, copy) NSString *home_pic;

@property (nonatomic, assign) NSInteger home_phone;

@property (nonatomic, assign) NSInteger home_star;

@property (nonatomic, assign) NSInteger min_price;


@end

@interface MinsuEvaluate : NSObject

@property (nonatomic, copy) NSString *user_pickture;

@property (nonatomic, copy) NSString *user_nickname;

@property (nonatomic, assign) NSInteger eval_star;

@property (nonatomic, copy) NSString *eval_content;

@property (nonatomic, assign) NSInteger eval_time;


@end


