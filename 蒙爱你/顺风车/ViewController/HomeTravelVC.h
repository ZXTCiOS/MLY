//
//  HomeTravelVC.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/5.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeTravelModel.h"
#import "Transition_Travel.h"

@interface HomeTravelVC : UIViewController


@property (weak, nonatomic) IBOutlet UIImageView *imageV_car;


- (instancetype)initWithHomeTravelModel:(HomeTravelModel *) model pushSource:(PushSource) source;



@end
