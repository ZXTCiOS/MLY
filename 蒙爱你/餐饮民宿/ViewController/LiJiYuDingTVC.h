//
//  LiJiYuDingTVC.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/19.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MinsuDetailModel.h"


typedef NS_ENUM(NSUInteger, BedOreEat) {
    Bed,
    Eat,
};



@interface LiJiYuDingTVC : UITableViewController



- (instancetype)initWithBedEat:(BedOreEat) typt minsuBedModel:(MinsuBedModel *) bedeatModel;

@end
