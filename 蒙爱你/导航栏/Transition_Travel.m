//
//  Transition_Travel.m
//  蒙爱你
//
//  Created by mahaibo on 17/8/1.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "Transition_Travel.h"
#import "HomePageTVC.h"
#import "HomeTravelVC.h"
#import "ShunFengCheCVC.h"

@interface Transition_Travel ()

@property (nonatomic, assign) TransitionType type;
@property (nonatomic, assign) PushSource source;

@end

@implementation Transition_Travel
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
    
    HomeTravelVC *toVC = (HomeTravelVC *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *container = [transitionContext containerView];
    
    if (self.source == PushSourceHome) {
        HomePageTVC *fromVC = (HomePageTVC *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        HomeTableCell *Tcell = [fromVC.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        TravelAdviseCell *cell = (TravelAdviseCell *)[Tcell.collectV cellForItemAtIndexPath:[NSIndexPath indexPathForRow:fromVC.currentIndex.row inSection:0]];
        UIImageView *snapShotView = [[UIImageView alloc] initWithImage:cell.imageV.image];
        snapShotView.frame = [cell.imageV convertRect:cell.imageV.frame toView:container];
        cell.imageV.hidden = YES;
        toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
        toVC.view.alpha = 0;
        toVC.imageV_car.hidden = YES;
        [container addSubview:toVC.view];
        [container addSubview: snapShotView];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            snapShotView.frame = [toVC.imageV_car convertRect:toVC.imageV_car.frame toView:toVC.view];
            //snapShotView.frame = CGRectMake(0, 0, kScreenW, kScreenW);
            toVC.view.alpha = 1;
        } completion:^(BOOL finished) {
            snapShotView.hidden = YES;
            toVC.imageV_car.hidden = NO;
            [snapShotView removeFromSuperview];
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    } else {
        ShunFengCheCVC *fromVC = (ShunFengCheCVC *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        TravelAdviseCell *cell = (TravelAdviseCell *)[fromVC.collectionView cellForItemAtIndexPath:fromVC.currentIndex];
        UIImageView *snapShotView = [[UIImageView alloc] initWithImage:cell.imageV.image];
        snapShotView.frame = [cell.imageV convertRect:cell.imageV.frame toView:container];
        cell.imageV.hidden = YES;
        HomeTravelVC *toVC = (HomeTravelVC *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
        toVC.view.alpha = 0;
        toVC.imageV_car.hidden = YES;
        [container addSubview:toVC.view];
        [container addSubview: snapShotView];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            snapShotView.frame = [toVC.imageV_car convertRect:toVC.imageV_car.frame toView:toVC.view];
            //snapShotView.frame = CGRectMake(0, 0, kScreenW, kScreenW / 3 * 2);
            toVC.view.alpha = 1;
        } completion:^(BOOL finished) {
            snapShotView.hidden = YES;
            toVC.imageV_car.hidden = NO;
            [snapShotView removeFromSuperview];
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    }
}


- (void)PopAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    HomeTravelVC *fromVC = (HomeTravelVC *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    if (self.source == PushSourceHome) {
        HomePageTVC *toVC = (HomePageTVC *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        HomeTableCell *Tcell = [toVC.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        TravelAdviseCell *cell = (TravelAdviseCell *)[Tcell.collectV cellForItemAtIndexPath:[NSIndexPath indexPathForRow:toVC.currentIndex.row inSection:0]];
        
        UIImageView *snapView = [[UIImageView alloc] initWithImage:fromVC.imageV_car.image];
        snapView.frame = [fromVC.imageV_car convertRect:fromVC.imageV_car.frame toView:container];
        cell.imageV.hidden = YES;
        fromVC.imageV_car.hidden = YES;
        snapView.hidden = NO;
        [container insertSubview:toVC.view atIndex:0];
        [container addSubview:snapView];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            snapView.frame = [cell.imageV convertRect:cell.imageV.frame toView:container];
            fromVC.view.alpha = 0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {
                snapView.hidden = YES;
                fromVC.imageV_car.hidden = NO;
            } else {
                cell.imageV.hidden = NO;
                [snapView removeFromSuperview];
            }
        }];
    } else {
        ShunFengCheCVC *toVC = (ShunFengCheCVC *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        TravelAdviseCell *cell = (TravelAdviseCell *)[toVC.collectionView cellForItemAtIndexPath:toVC.currentIndex];
        //UIView *snapView = container.subviews.lastObject;
        UIImageView *snapView = [[UIImageView alloc] initWithImage:fromVC.imageV_car.image];
        snapView.frame = [fromVC.imageV_car convertRect:fromVC.imageV_car.frame toView:container];
        cell.imageV.hidden = YES;
        fromVC.imageV_car.hidden = YES;
        snapView.hidden = NO;
        [container insertSubview:toVC.view atIndex:0];
        [container addSubview:snapView];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            snapView.frame = [cell.imageV convertRect:cell.imageV.frame toView:container];
            fromVC.view.alpha = 0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {
                snapView.hidden = YES;
                fromVC.imageV_car.hidden = NO;
            } else {
                cell.imageV.hidden = NO;
                [snapView removeFromSuperview];
            }
        }];
    }
}

+ (instancetype)TransitionWithTransitionType:(TransitionType)type pushsource:(PushSource)source{
    return [[Transition_Travel alloc] initWithTransitionType:type pushsource:source];
}

- (instancetype)initWithTransitionType:(TransitionType)type pushsource:(PushSource)source{
    Transition_Travel *scen = [super init];
    self.type = type;
    self.source = source;
    return scen;
}
@end
