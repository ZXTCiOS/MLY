//
//  Transition_Scenic.m
//  蒙爱你
//
//  Created by mahaibo on 17/8/1.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "Transition_Scenic.h"
#import "HomePageTVC.h"
#import "ScenicVC.h"
#import "ScenicTVC.h"
#import "ScenicCell.h"

@interface Transition_Scenic ()

@property (nonatomic, assign) TransitionType type;
@property (nonatomic, assign) PushSource source;

@end

@implementation Transition_Scenic


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
    
    ScenicVC *toVC = (ScenicVC *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    if (self.source == PushSourceHome) {
        HomePageTVC *fromVC = (HomePageTVC *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        HomeTableCell *Tcell = [fromVC.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        ScenicSpotAdviseCell *Ccell = (ScenicSpotAdviseCell *)[Tcell.collectV cellForItemAtIndexPath:[NSIndexPath indexPathForRow:fromVC.currentIndex.row inSection:0]];
        
        UIImageView *snapShotView = [[UIImageView alloc] initWithImage:Ccell.imgV.image];
        snapShotView.frame = [Ccell.imgV convertRect:Ccell.imgV.frame toView:container];
        Ccell.imgV.hidden = YES;
        
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
    } else {
        ScenicTVC *fromVC = (ScenicTVC *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        ScenicCell *cell = [fromVC.tableView cellForRowAtIndexPath:fromVC.currentIndex];
        UIImageView *animateView = [[UIImageView alloc] initWithImage:cell.imageV.image];
        animateView.frame = [cell.imageV convertRect:cell.imageV.frame toView:container];
        cell.imageV.hidden = YES;
        toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
        toVC.view.alpha = 0;
        toVC.imageV.hidden = YES;
        [container addSubview:toVC.view];
        [container addSubview:animateView];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            animateView.frame = CGRectMake(0, 0, kScreenW, kScreenW);
            toVC.view.alpha = 1;
        } completion:^(BOOL finished) {
            animateView.hidden = YES;
            toVC.imageV.hidden = NO;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
    
}


- (void)PopAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    ScenicVC *fromVC = (ScenicVC *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *container = [transitionContext containerView];
    if (self.source == PushSourceHome) {
        HomePageTVC *toVC = (HomePageTVC *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        HomeTableCell *Tcell = [toVC.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        ScenicSpotAdviseCell *cell = (ScenicSpotAdviseCell *)[Tcell.collectV cellForItemAtIndexPath:[NSIndexPath indexPathForRow:toVC.currentIndex.row inSection:0]];
        UIView *snapView = container.subviews.lastObject;
        //UIImageView *snapView = [[UIImageView alloc] initWithImage:fromVC.imageV.image];
        //snapView.frame = [fromVC.imageV convertRect:fromVC.imageV.frame toView:container];
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
    } else {
        ScenicTVC *toVC = (ScenicTVC *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        ScenicCell *cell = [toVC.tableView cellForRowAtIndexPath:toVC.currentIndex];
        
        //UIView *snapView = container.subviews.lastObject;
        UIImageView *snapView = [[UIImageView alloc] initWithImage:fromVC.imageV.image];
        snapView.frame = [fromVC.imageV convertRect:fromVC.imageV.frame toView:container];
        cell.imageV.hidden = YES;
        fromVC.imageV.hidden = YES;
        snapView.hidden = NO;
        [container insertSubview:toVC.view atIndex:0];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            snapView.frame = [cell.imageV convertRect:cell.imageV.frame toView:container];
            fromVC.view.alpha = 0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {
                snapView.hidden = YES;
                fromVC.imageV.hidden = NO;
            } else {
                cell.imageV.hidden = NO;
                [snapView removeFromSuperview];
            }
        }];
    }
    
}

+ (instancetype)TransitionWithTransitionType:(TransitionType)type pushsource:(PushSource)source{
    return [[Transition_Scenic alloc] initWithTransitionType:type pushsource:source];
}

- (instancetype)initWithTransitionType:(TransitionType)type pushsource:(PushSource)source{
    Transition_Scenic *scen = [super init];
    self.type = type;
    self.source = source;
    return scen;
}




@end
