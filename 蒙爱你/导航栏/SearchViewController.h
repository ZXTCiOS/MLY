//
//  SearchViewController.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/24.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, SearchType) {
    SearchTypeScenic,
    SearchTypeMinsu,
    SearchTypeShunFC,
    SearchTypeFood,
    
};


@interface SearchViewController : UISearchController







- (instancetype)initWithSearchType:(SearchType) type;


@end
