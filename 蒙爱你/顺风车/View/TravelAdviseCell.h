//
//  TravelAdviseCell.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/4.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol mycellVdelegate <NSObject>
-(void)myTabVClick1:(UICollectionViewCell *)cell;//收藏

@end
@interface TravelAdviseCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *shoucangImg;

@property (weak, nonatomic) IBOutlet UIImageView *imageV;


@property (weak, nonatomic) IBOutlet UILabel *nameL;


@property (weak, nonatomic) IBOutlet UILabel *addressL;




@property (nonatomic, assign) BOOL isStored;



@property(assign,nonatomic)id<mycellVdelegate>delegate;


@end
