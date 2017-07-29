//
//  ShouHuoDiZhiCell.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/7.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class addressModel;

@interface ShouHuoDiZhiCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *nameL;

@property (weak, nonatomic) IBOutlet UILabel *tele;


@property (weak, nonatomic) IBOutlet UIButton *isDefault;


@property (weak, nonatomic) IBOutlet UILabel *addressL;

@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@property (nonatomic, strong) void(^edit)();


-(void)setdata:(addressModel *)model;

@end
