//
//  ShouHuoDiZhiCell.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/7.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol mycellVdelegate <NSObject>
-(void)myTabVClick1:(UITableViewCell *)cell;//选择按钮

@end

@class addressModel;

@interface ShouHuoDiZhiCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *nameL;

@property (weak, nonatomic) IBOutlet UILabel *tele;


@property (weak, nonatomic) IBOutlet UIButton *isDefault;


@property (weak, nonatomic) IBOutlet UILabel *addressL;

@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@property (nonatomic, strong) void(^edit)();

@property(assign,nonatomic)id<mycellVdelegate>delegate;
-(void)setdata:(addressModel *)model;

@end
