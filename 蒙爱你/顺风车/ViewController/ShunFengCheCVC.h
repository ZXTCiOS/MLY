//
//  ShunFengCheCVC.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/6.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchViewController.h"

@interface ShunFengCheCVC : UICollectionViewController


@property (nonatomic, strong) NSIndexPath *currentIndex;


- (instancetype)initWithSearchText:(NSString *) text searchType:(SearchType) searchType;

@end
