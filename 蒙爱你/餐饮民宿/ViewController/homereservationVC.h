//
//  homereservationVC.h
//  蒙爱你
//
//  Created by 王俊钢 on 2017/8/2.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MinsuDetailModel.h"

@interface homereservationVC : UIViewController
@property (nonatomic,strong) NSString *namestr;
@property (nonatomic,strong) NSString *telephonestr;
@property (nonatomic,strong) NSString *contentstr;
@property (nonatomic,strong) NSString *datastr;




- (instancetype)initWithMinsuBedEatModel:(MinsuBedModel *) model;

@end
