//
//  SearchViewController.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/24.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, SearchType) {
    SearchTypeHome,         // 首页搜索
    SearchTypeScenic,
    SearchTypeChuxing,
    SearchTypeMinsu,
    SearchTypeFood      = 6,
    
};


@interface SearchViewController : UIViewController







- (instancetype)initWithSearchType:(SearchType) type;


@end
