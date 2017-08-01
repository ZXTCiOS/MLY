//
//  ZXTC_Transition.m
//  蒙爱你
//
//  Created by mahaibo on 17/8/1.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "ZXTC_Transition.h"


@interface ZXTC_Transition ()

@property (nonatomic, assign) TransitionType type;

@end

@implementation ZXTC_Transition


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1.5;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (self.type) {
        case TransitionTypePush:
            [self PushAnimation:transitionContext];
            break;
        case TransitionTypePop:
            [self PopAnimation:transitionContext];
        default:
            break;
    }
}

- (void)PushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
}
- (void)PopAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
}


+ (instancetype)TransitionWithTransitionType:(TransitionType) type{
    ZXTC_Transition *t = [[self alloc] init];
    t.type = type;
    return t;
}

- (instancetype)initWithTransitionType:(TransitionType) type{
    ZXTC_Transition *t = [super init];
    t.type = type;
    return t;
}


@end
