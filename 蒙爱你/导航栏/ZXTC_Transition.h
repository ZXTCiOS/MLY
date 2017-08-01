//
//  ZXTC_Transition.h
//  蒙爱你
//
//  Created by mahaibo on 17/8/1.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, TransitionType) {
    TransitionTypePush,
    TransitionTypePop,
};

typedef NS_ENUM(NSUInteger, UIViewControllerType) {
    UIViewControllerTypeScenic,
    UIViewControllerTypeTravel,
    UIViewControllerTypeMinsu,
};

@interface ZXTC_Transition : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) UIViewControllerType vctype;

+ (instancetype)TransitionWithTransitionType:(TransitionType) type;

- (instancetype)initWithTransitionType:(TransitionType) type;



@end
