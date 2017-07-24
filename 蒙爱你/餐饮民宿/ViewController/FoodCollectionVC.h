//
//  FoodCollectionVC.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/10.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, VCType) {
    VCTypeOfBed,
    VCTypeOfFood,
};


@interface FoodCollectionVC : UICollectionViewController



@property (nonatomic, assign) VCType type;

- (void)reloadDataWithStars:(NSArray *) arr andPrice:(NSInteger) price;


- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout andType:(VCType)type;


@end
