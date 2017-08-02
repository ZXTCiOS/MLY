//
//  Transition_Food.h
//  蒙爱你
//
//  Created by mahaibo on 17/8/1.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXTC_Transition.h"

@interface Transition_Food : NSObject<UIViewControllerAnimatedTransitioning>


+ (instancetype)TransitionWithTransitionType:(TransitionType) type;

- (instancetype)initWithTransitionType:(TransitionType) type;
@end
