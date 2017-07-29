//
//  GouWCCell.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/29.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GouWCCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *isselected;

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UILabel *count;

@property (nonatomic, assign) BOOL isSel;

@end
