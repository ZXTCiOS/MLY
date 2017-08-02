//
//  Transition_Scenic.h
//  蒙爱你
//
//  Created by mahaibo on 17/8/1.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXTC_Transition.h"




@interface Transition_Scenic : NSObject<UIViewControllerAnimatedTransitioning>


+ (instancetype)TransitionWithTransitionType:(TransitionType) type pushsource:(PushSource) source;

- (instancetype)initWithTransitionType:(TransitionType) type pushsource:(PushSource) source;


@end
