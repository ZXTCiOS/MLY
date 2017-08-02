//
//  Transition_Minsu.m
//  蒙爱你
//
//  Created by mahaibo on 17/8/1.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "Transition_Minsu.h"

#import "HomePageTVC.h"
#import "BedDetailTVC.h"
#import "FoodandBedPageVC.h"


@interface Transition_Minsu ()

@property (nonatomic, assign) TransitionType type;
@property (nonatomic, assign) PushSource source;

@end

@implementation Transition_Minsu
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
    
    BedDetailTVC *toVC = (BedDetailTVC *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    if (self.source == PushSourceHome) {
        
        HomePageTVC *fromVC = (HomePageTVC *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        HomeTableCell *Tcell = [fromVC.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
        FoodAndHotelCell *cell = (FoodAndHotelCell *)[Tcell.collectV cellForItemAtIndexPath:[NSIndexPath indexPathForRow:fromVC.currentIndex.row inSection:0]];
        UIImageView *snapShotView = [[UIImageView alloc] initWithImage:cell.imgV.image];
        snapShotView.frame = [cell.imgV convertRect:cell.imgV.frame toView:container];
        cell.imgV.hidden = YES;
        toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
        toVC.view.alpha = 0;
        toVC.imgV.hidden = YES;
        [container addSubview:toVC.view];
        [container addSubview: snapShotView];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            //snapShotView.frame = [toVC.imgV convertRect:toVC.imgV.frame fromView:toVC.view];
            snapShotView.frame = CGRectMake(0, 0, kScreenW, kScreenW);
            toVC.view.alpha = 1;
        } completion:^(BOOL finished) {
            snapShotView.hidden = YES;
            toVC.imgV.hidden = NO;
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    } else {
        FoodandBedPageVC *fromVC = (FoodandBedPageVC *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        FoodCollectionVC *vc = (FoodCollectionVC *)fromVC.childViewControllers.firstObject;
        FoodAndHotelCell *cell = (FoodAndHotelCell *)[vc.collectionView cellForItemAtIndexPath:vc.currentIndex];
        UIImageView *snapShotView = [[UIImageView alloc] initWithImage:cell.imgV.image];
        snapShotView.frame = [cell.imgV convertRect:cell.imgV.frame toView:container];
        cell.imgV.hidden = YES;
        toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
        toVC.view.alpha = 0;
        toVC.imgV.hidden = YES;
        [container addSubview:toVC.view];
        [container addSubview: snapShotView];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            //snapShotView.frame = [toVC.imgV convertRect:toVC.imgV.frame fromView:toVC.view];
            snapShotView.frame = CGRectMake(0, 0, kScreenW, kScreenW);
            toVC.view.alpha = 1;
        } completion:^(BOOL finished) {
            snapShotView.hidden = YES;
            toVC.imgV.hidden = NO;
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    }
}


- (void)PopAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIView *container = [transitionContext containerView];
    BedDetailTVC *fromVC = (BedDetailTVC *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (self.source == PushSourceHome) {
        HomePageTVC *toVC = (HomePageTVC *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        HomeTableCell *Tcell = [toVC.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
        FoodAndHotelCell *cell = (FoodAndHotelCell *)[Tcell.collectV cellForItemAtIndexPath:[NSIndexPath indexPathForRow:toVC.currentIndex.row inSection:0]];
        UIView *snapView = container.subviews.lastObject;
        //UIImageView *snapView = [[UIImageView alloc] initWithImage:fromVC.imgV.image];
        //snapView.frame = [fromVC.imgV convertRect:fromVC.imgV.frame toView:container];
        cell.imgV.hidden = YES;
        fromVC.imgV.hidden = YES;
        snapView.hidden = NO;
        [container insertSubview:toVC.view atIndex:0];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            snapView.frame = [cell.imgV convertRect:cell.imgV.frame toView:container];
            fromVC.view.alpha = 0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {
                snapView.hidden = YES;
                fromVC.imgV.hidden = NO;
            } else {
                cell.imgV.hidden = NO;
                [snapView removeFromSuperview];
            }
        }];
    } else if (self.source == PushSourceList) {
        FoodandBedPageVC *toVC = (FoodandBedPageVC *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        FoodCollectionVC *vc = (FoodCollectionVC *)toVC.childViewControllers.firstObject;
        FoodAndHotelCell *cell = (FoodAndHotelCell *)[vc.collectionView cellForItemAtIndexPath:vc.currentIndex];
        UIView *snapView = container.subviews.lastObject;
        //UIImageView *snapView = [[UIImageView alloc] initWithImage:fromVC.imgV.image];
        //snapView.frame = [fromVC.imgV convertRect:fromVC.imgV.frame toView:container];
        cell.imgV.hidden = YES;
        fromVC.imgV.hidden = YES;
        snapView.hidden = NO;
        [container insertSubview:toVC.view atIndex:0];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            snapView.frame = [cell.imgV convertRect:cell.imgV.frame toView:container];
            fromVC.view.alpha = 0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {
                snapView.hidden = YES;
                fromVC.imgV.hidden = NO;
            } else {
                cell.imgV.hidden = NO;
                [snapView removeFromSuperview];
            }
        }];
    }
}

+ (instancetype)TransitionWithTransitionType:(TransitionType)type pushsource:(PushSource)source{
    return [[Transition_Minsu alloc] initWithTransitionType:type pushsource:source];
}

- (instancetype)initWithTransitionType:(TransitionType)type pushsource:(PushSource)source{
    Transition_Minsu *scen = [super init];
    self.type = type;
    self.source = source;
    return scen;
}

@end
