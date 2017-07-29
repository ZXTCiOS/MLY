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
-(void)myTabVClick1:(UITableViewCell *)cell;//取消
-(void)myTabVClick2:(UITableViewCell *)cell;//支付
-(void)myTabVClick3:(UITableViewCell *)cell;//退款
-(void)myTabVClick4:(UITableViewCell *)cell;//修改
-(void)myTabVClick5:(UITableViewCell *)cell;//物流
-(void)myTabVClick6:(UITableViewCell *)cell;//评价
-(void)myTabVClick7:(UITableViewCell *)cell;//退款原因展示
@end
@interface myorderCell : UITableViewCell
@property(assign,nonatomic)id<mycellVdelegate>delegate;
-(void)setdata:(myOrderModel *)model;
@end
