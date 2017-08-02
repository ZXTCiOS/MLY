//
//  Transition_Food.m
//  蒙爱你
//
//  Created by mahaibo on 17/8/1.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "Transition_Food.h"
#import "FoodListCVC.h"
#import "FoodandBedPageVC.h"
#import "FoodAndHotelCell.h"

@interface Transition_Food ()

@property (nonatomic, assign) TransitionType type;


@end
@implementation Transition_Food


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
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
    
    
    FoodListCVC *toVC = (FoodListCVC *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    FoodandBedPageVC *fromVC = (FoodandBedPageVC *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    FoodCollectionVC *vc = (FoodCollectionVC *)fromVC.childViewControllers.lastObject;
    FoodAndHotelCell *cell = (FoodAndHotelCell *)[vc.collectionView cellForItemAtIndexPath:vc.currentIndex];
    UIImageView *snapShotView = [[UIImageView alloc] initWithImage:cell.imgV.image];
    snapShotView.frame = [cell.imgV convertRect:cell.imgV.frame toView:container];
    cell.imgV.hidden = YES;
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    toVC.imgV.imgV.hidden = YES;
    [container addSubview:toVC.view];
    [container addSubview: snapShotView];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        snapShotView.frame = CGRectMake(0, 64, kScreenW, kScreenW);
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        snapShotView.hidden = YES;
        toVC.imgV.imgV.hidden = NO;
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
    
}


- (void)PopAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIView *container = [transitionContext containerView];
    FoodListCVC *fromVC = (FoodListCVC *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    FoodandBedPageVC *toVC = (FoodandBedPageVC *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    FoodCollectionVC *vc = (FoodCollectionVC *)toVC.childViewControllers.lastObject;
    FoodAndHotelCell *cell = (FoodAndHotelCell *)[vc.collectionView cellForItemAtIndexPath:vc.currentIndex];
    
    UIImageView *snapView = [[UIImageView alloc] initWithImage:fromVC.imgV.imgV.image];
    snapView.frame = [fromVC.imgV.imgV convertRect:fromVC.imgV.imgV.frame toView:container];
    cell.imgV.hidden = YES;
    fromVC.imgV.imgV.hidden = YES;
    snapView.hidden = NO;
    [container insertSubview:toVC.view atIndex:0];
    [container addSubview:snapView];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        snapView.frame = [cell.imgV convertRect:cell.imgV.frame toView:container];
        fromVC.view.alpha = 0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            snapView.hidden = YES;
            fromVC.imgV.imgV.hidden = NO;
        } else {
            cell.imgV.hidden = NO;
            [snapView removeFromSuperview];
        }
    }];
    
}












+ (instancetype)TransitionWithTransitionType:(TransitionType) type{
    Transition_Food *t = [[Transition_Food alloc] init];
    t.type = type;
    return t;
}

- (instancetype)initWithTransitionType:(TransitionType) type{
    Transition_Food *t = [super init];
    t.type = type;
    return t;
}

@end
