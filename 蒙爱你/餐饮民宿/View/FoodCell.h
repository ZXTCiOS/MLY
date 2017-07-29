//
//  FoodCell.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/28.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *nameL;

@property (weak, nonatomic) IBOutlet UILabel *priceL;

@end
