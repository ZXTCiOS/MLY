//
//  ScenicCell.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/12.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol mycellticketVdelegate <NSObject>
-(void)myTabVClickticket:(UITableViewCell *)cell;//收藏

@end

@interface ScenicCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *detail;


@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UIImageView *shoucangImg;

@property (nonatomic, assign) BOOL isLike;


@property(assign,nonatomic)id<mycellticketVdelegate>delegate;




@end
