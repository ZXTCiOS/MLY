//
//  DiscountCell.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/19.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscountCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *youhui;

@property (weak, nonatomic) IBOutlet UILabel *youhuiman;

@property (nonatomic, assign) BOOL enabled;

@end
