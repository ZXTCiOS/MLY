//
//  BedDetailCell.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/17.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BedDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgV;


@property (weak, nonatomic) IBOutlet UILabel *name;


@property (weak, nonatomic) IBOutlet UILabel *detailL;


@property (weak, nonatomic) IBOutlet UILabel *priceL;


@property (weak, nonatomic) IBOutlet UILabel *otherL;


@property (weak, nonatomic) IBOutlet UIButton *kefuBtn;

@property (weak, nonatomic) IBOutlet UIButton *buyBtn;

@property (weak, nonatomic) IBOutlet UIButton *shouqiBtn;




@property (nonatomic, strong) void(^kefu)();

@property (nonatomic, strong) void(^buynow)();

@property (nonatomic, strong) void(^shouqizhankai)(UIButton *sender);


@end
