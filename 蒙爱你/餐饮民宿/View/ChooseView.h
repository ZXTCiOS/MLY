//
//  ChooseView.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/14.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarBtn.h"


@interface ChooseView : UIView


@property (weak, nonatomic) IBOutlet UILabel *topPrice;


@property (weak, nonatomic) IBOutlet UISlider *slider;


@property (weak, nonatomic) IBOutlet UIButton *quedignBtn;


@property (nonatomic, strong) StarBtn *star1;
@property (nonatomic, strong) StarBtn *star2;
@property (nonatomic, strong) StarBtn *star3;
@property (nonatomic, strong) StarBtn *star4;
@property (nonatomic, strong) StarBtn *star5;


@property (nonatomic, strong) void(^queding)();



@end
