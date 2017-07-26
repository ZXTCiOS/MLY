//
//  myorderCell.h
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/26.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class myOrderModel;

//创建一个代理
@protocol mycellVdelegate <NSObject>
-(void)myTabVClick1:(UITableViewCell *)cell;
-(void)myTabVClick2:(UITableViewCell *)cell;
@end
@interface myorderCell : UITableViewCell
@property(assign,nonatomic)id<mycellVdelegate>delegate;
@end
