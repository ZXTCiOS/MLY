//
//  LiJiYuDingTVC.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/19.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BedOreEat) {
    Bed,
    Eat,
};

@interface LiJiYuDingTVC : UITableViewController



- (instancetype)initWithBedEat:(BedOreEat) typt room_id:(NSInteger) room_id bedeat_id:(NSInteger) eadbed_id;

@end
