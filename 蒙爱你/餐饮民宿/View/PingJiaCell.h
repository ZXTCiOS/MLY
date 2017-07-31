//
//  PingJiaCell.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/31.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTKStarView.h"


@interface PingJiaCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@property (weak, nonatomic) IBOutlet UILabel *nameL;

@property (weak, nonatomic) IBOutlet UILabel *timeL;


@property (weak, nonatomic) IBOutlet UILabel *descL;


@property (nonatomic, strong) WTKStarView *starV;


@end
