//
//  ScenicTVC.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/11.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScenicTVC : UITableViewController

@property (nonatomic, assign) NSInteger city_id;

- (instancetype)initWithArea_id:(NSInteger) area_id area_name:(NSString *)area_name;


@end
