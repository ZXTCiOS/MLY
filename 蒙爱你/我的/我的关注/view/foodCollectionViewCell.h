//
//  foodCollectionViewCell.h
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/29.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class shoucangfoodModel;
//创建一个代理
@protocol mycellVdelegate <NSObject>
-(void)myTabVClick1:(UICollectionViewCell *)cell;

@end
@interface foodCollectionViewCell : UICollectionViewCell

-(void)setdata:(shoucangfoodModel *)model;
@property(assign,nonatomic)id<mycellVdelegate>delegate;
@end
