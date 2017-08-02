//
//  FoodListCVC.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/27.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodListHeaderView.h"
#import "Transition_Food.h"

@interface FoodListCVC : UICollectionViewController


@property (nonatomic, strong) FoodListHeaderView *imgV;

- (instancetype)initWithShop_ID:(NSInteger) shop_id pushSource:(PushSource) source;


@end
