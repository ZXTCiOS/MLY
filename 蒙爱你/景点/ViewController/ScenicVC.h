//
//  ScenicVC.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/12.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScenicModel.h"
#import "Transition_Scenic.h"

@interface ScenicVC : UITableViewController


@property (weak, nonatomic) IBOutlet UIImageView *imageV;

- initWithScenic_id:(NSInteger) scenic_id pushsource:(PushSource) source;

@end
