//
//  commodityCell.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/10.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopGoodsModel;
@protocol mycellVdelegate <NSObject>
-(void)myTabVClick1:(UITableViewCell *)cell;//收藏

@end

@interface commodityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *nameL;

@property (weak, nonatomic) IBOutlet UILabel *detailL;

@property (weak, nonatomic) IBOutlet UILabel *describeL;

@property (weak, nonatomic) IBOutlet UILabel *priceL;

@property (nonatomic, assign) BOOL isStored;

@property (weak, nonatomic) IBOutlet UILabel *discountL;
-(void)setData:(ShopGoodsModel *)model;
@property(assign,nonatomic)id<mycellVdelegate>delegate;
@end
