//
//  BedDetailTVC.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/17.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transition_Minsu.h"

@interface BedDetailTVC : UITableViewController



@property (nonatomic, assign) NSInteger minsu_id;



@property (nonatomic, copy) NSString *img_url;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;



@property (nonatomic, assign) PushSource source;



@end
