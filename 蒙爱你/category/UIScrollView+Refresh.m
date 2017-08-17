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
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:block];
    /*
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:block];
    //header setImages:<#(NSArray *)#> duration:<#(NSTimeInterval)#> forState:<#(MJRefreshState)#>
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.mj_header = header;
    */
}
- (void)addFooterRefresh:(void(^)())block{
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:block];
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








