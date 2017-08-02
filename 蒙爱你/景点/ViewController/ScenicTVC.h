//
//  ScenicTVC.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/11.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchViewController.h"


@interface ScenicTVC : UITableViewController

@property (nonatomic, assign) NSInteger city_id;

@property (nonatomic, strong) NSIndexPath *currentIndex;

- (instancetype)initWithArea_id:(NSInteger) area_id area_name:(NSString *)area_name;

- (instancetype)initWithSearchType:(SearchType) type Searchtext:(NSString*) text;

@end
