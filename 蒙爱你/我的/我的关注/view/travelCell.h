//
//  travelCell.h
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/27.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class travelModel;
//创建一个代理
@protocol mycellVdelegate <NSObject>
-(void)myTabVClick1:(UICollectionViewCell *)cell;

@end
@interface travelCell : UICollectionViewCell
-(void)setdata:(travelModel *)model;
@property(assign,nonatomic)id<mycellVdelegate>delegate;
@end
