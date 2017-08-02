//
//  ZXTC_Transition.m
//  蒙爱你
//
//  Created by mahaibo on 17/8/1.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "ZXTC_Transition.h"
#import "HomePageTVC.h"
#import "ScenicVC.h"
#import "HomeTravelVC.h"
#import "BedDetailTVC.h"

@interface ZXTC_Transition ()

@property (nonatomic, assign) TransitionType type;

@end

@implementation ZXTC_Transition


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
    
    
    HomePageTVC *fromVC = (HomePageTVC *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *container = [transitionContext containerView];
    switch (fromVC.currentIndex.section) {
        case 0:{
            HomeTableCell *Tcell = [fromVC.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            ScenicSpotAdviseCell *Ccell = (ScenicSpotAdviseCell *)[Tcell.collectV cellForItemAtIndexPath:[NSIndexPath indexPathForRow:fromVC.currentIndex.row inSection:0]];
            /*
            UIView *snapShotView = [Ccell.imgV snapshotViewAfterScreenUpdates:NO];
            snapShotView.frame = [container convertRect:Ccell.imgV.frame toView:container];*/
            UIImageView *snapShotView = [[UIImageView alloc] initWithImage:Ccell.imgV.image];
            snapShotView.frame = [Ccell.imgV convertRect:Ccell.imgV.frame toView:container];
            Ccell.imgV.hidden = YES;
            ScenicVC *toVC = (ScenicVC *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
            toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
            toVC.view.alpha = 0;
            toVC.imageV.hidden = YES;
            [container addSubview:toVC.view];
            [container addSubview:snapShotView];
            [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                toVC.view.alpha = 1;
                snapShotView.frame = CGRectMake(0, 0, kScreenW, kScreenW); //[container convertRect:toVC.imageV.frame fromView:toVC.view];
            } completion:^(BOOL finished) {
                snapShotView.hidden = YES;
                toVC.imageV.hidden = NO;
                [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
            }];
            
        }
            break;
        case 1:{
            HomeTableCell *Tcell = [fromVC.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
            TravelAdviseCell *cell = (TravelAdviseCell *)[Tcell.collectV cellForItemAtIndexPath:[NSIndexPath indexPathForRow:fromVC.currentIndex.row inSection:0]];
            //UIView *snapShotView = [cell.imageV snapshotViewAfterScreenUpdates:NO];
            //snapShotView.frame = [container convertRect:cell.imageV.frame toView:container];
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
                snapShotView.frame = [toVC.imageV_car convertRect:toVC.imageV_car.frame fromView:toVC.view];
                toVC.view.alpha = 1;
            } completion:^(BOOL finished) {
                snapShotView.hidden = YES;
                toVC.imageV_car.hidden = NO;
                [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
            }];
            
        }
            break;
        case 2:{
            HomeTableCell *Tcell = [fromVC.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
            FoodAndHotelCell *cell = (FoodAndHotelCell *)[Tcell.collectV cellForItemAtIndexPath:[NSIndexPath indexPathForRow:fromVC.currentIndex.row inSection:0]];
            //UIView *snapShotView = [cell.imgV snapshotViewAfterScreenUpdates:NO];
            //snapShotView.frame = [container convertRect:cell.imgV.frame toView:container];
            UIImageView *snapShotView = [[UIImageView alloc] initWithImage:cell.imgV.image];
            snapShotView.frame = [cell.imgV convertRect:cell.imgV.frame toView:container];
            cell.imgV.hidden = YES;
            BedDetailTVC *toVC = (BedDetailTVC *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
            toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
            toVC.view.alpha = 0;
            toVC.imgV.hidden = YES;
            [container addSubview:toVC.view];
            [container addSubview: snapShotView];
            [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                snapShotView.frame = [toVC.imgV convertRect:toVC.imgV.frame fromView:toVC.view];
                toVC.view.alpha = 1;
            } completion:^(BOOL finished) {
                snapShotView.hidden = YES;
                toVC.imgV.hidden = NO;
                [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
            }];
        }
            break;
        default:
            break;
    }
    
}


- (void)PopAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    HomePageTVC *toVC = (HomePageTVC *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    switch (self.vctype) {
        case UIViewControllerTypeScenic:
        {
            ScenicVC *fromVC = (ScenicVC *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
            HomeTableCell *Tcell = [toVC.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            ScenicSpotAdviseCell *cell = (ScenicSpotAdviseCell *)[Tcell.collectV cellForItemAtIndexPath:[NSIndexPath indexPathForRow:toVC.currentIndex.row inSection:0]];
            UIView *snapView = container.subviews.lastObject;
            cell.imgV.hidden = YES;
            fromVC.imageV.hidden = YES;
            snapView.hidden = NO;
            [container insertSubview:toVC.view atIndex:0];
            [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                snapView.frame = [cell.imgV convertRect:cell.imgV.frame toView:container];
                fromVC.view.alpha = 0;
            } completion:^(BOOL finished) {
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                if ([transitionContext transitionWasCancelled]) {
                    snapView.hidden = YES;
                    fromVC.imageV.hidden = NO;
                } else {
                    cell.imgV.hidden = NO;
                    [snapView removeFromSuperview];
                }
            }];
            
        }
            break;
        case UIViewControllerTypeTravel:
        {
            HomeTravelVC *fromVC = (HomeTravelVC *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
            HomeTableCell *Tcell = [toVC.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
            TravelAdviseCell *cell = (TravelAdviseCell *)[Tcell.collectV cellForItemAtIndexPath:[NSIndexPath indexPathForRow:toVC.currentIndex.row inSection:0]];
            UIView *snapView = container.subviews.lastObject;
            cell.imageV.hidden = YES;
            fromVC.imageV_car.hidden = YES;
            snapView.hidden = NO;
            [container insertSubview:toVC.view atIndex:0];
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
            break;
        case UIViewControllerTypeMinsu:
        {
            BedDetailTVC *fromVC = (BedDetailTVC *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
            HomeTableCell *Tcell = [toVC.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
            FoodAndHotelCell *cell = (FoodAndHotelCell *)[Tcell.collectV cellForItemAtIndexPath:[NSIndexPath indexPathForRow:toVC.currentIndex.row inSection:0]];
            UIView *snapView = container.subviews.lastObject;
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
            break;
        default:
            break;
    }
    
    
    
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
