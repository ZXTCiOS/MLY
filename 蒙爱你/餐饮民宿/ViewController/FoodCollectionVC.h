//
//  FoodCollectionVC.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/10.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchViewController.h"
#import "Transition_Minsu.h"
#import "Transition_Food.h"

typedef NS_ENUM(NSUInteger, VCType) {
    VCTypeOfBed,
    VCTypeOfFood,
};


@interface FoodCollectionVC : UICollectionViewController



@property (nonatomic, assign) VCType type;

- (void)reloadDataWithStars:(NSString *) arr andPrice:(NSInteger) price;

@property (nonatomic, strong) NSIndexPath *currentIndex;

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout andType:(VCType)type pushSource:(PushSource) source;

- (instancetype)initWithSearchType:(SearchType)type Searchtext:(NSString *)text;


@end
