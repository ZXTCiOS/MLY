//
//  UIScrollView+Refresh.m
//  TRProject
//
//  Created by tarena on 16/7/13.
//  Copyright © 2016年 yingxin. All rights reserved.
//

#import "UIScrollView+Refresh.h"

@implementation UIScrollView (Refresh)
- (void)addHeaderRefresh:(void(^)())block{
    //self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:block];
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:block];
    UIImage *img1 = [UIImage imageNamed:@"21"];
    UIImage *img2 = [UIImage imageNamed:@"222"];
    UIImage *img3 = [UIImage imageNamed:@"23"];
    [header setImages:@[img1] forState:MJRefreshStatePulling];
    [header setImages:@[img3] forState:MJRefreshStateIdle];
    [header setImages:@[img1, img2, img3] duration:0.5 forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.mj_header = header;
    
}
- (void)addFooterRefresh:(void(^)())block{
    //self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:block];
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:block];
    UIImage *img1 = [UIImage imageNamed:@"21"];
    UIImage *img2 = [UIImage imageNamed:@"222"];
    UIImage *img3 = [UIImage imageNamed:@"23"];
    [footer setImages:@[img1] forState:MJRefreshStatePulling];
    [footer setImages:@[img3] forState:MJRefreshStateIdle];
    [footer setImages:@[img1, img2, img3] duration:0.5 forState:MJRefreshStateRefreshing];
    footer.stateLabel.hidden = YES;
    self.mj_footer = footer;
}
- (void)beginHeaderRefresh{
    [self.mj_header beginRefreshing];
}
- (void)endHeaderRefresh{
    [self.mj_header endRefreshing];
}

- (void)endFooterRefresh{
    [self.mj_footer endRefreshing];
}
@end








