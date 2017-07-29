//
//  hotelCell.h
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/27.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class shoucanghomeModel;
//创建一个代理
@protocol mycellVdelegate <NSObject>
-(void)myTabVClick1:(UICollectionViewCell *)cell;

@end
@interface hotelCell : UICollectionViewCell

-(void)setdata:(shoucanghomeModel *)model;
@property(assign,nonatomic)id<mycellVdelegate>delegate;
@end
