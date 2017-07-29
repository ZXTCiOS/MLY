//
//  FoodInfoVC.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/28.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodDataModel.h"
@interface FoodInfoVC : UIViewController


- (instancetype)initWithFoodModel:(FoodModel *) model home_id:(NSInteger) home_id;
@end
