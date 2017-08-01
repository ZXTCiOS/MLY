//
//  HomePageTVC.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/4.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScenicSpotAdviseCell.h"
#import "TravelAdviseCell.h"
#import "FoodAndHotelCell.h"
#import "HomeTableCell.h"




@interface HomePageTVC : UIViewController
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSIndexPath *currentIndex;
@end
