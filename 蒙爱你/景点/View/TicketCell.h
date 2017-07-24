//
//  TicketCell.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/12.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TicketCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *ticketName;

@property (weak, nonatomic) IBOutlet UIButton *goumaixuzhi;

@property (weak, nonatomic) IBOutlet UIButton *buyBtn;


@property (weak, nonatomic) IBOutlet UILabel *priceL;


@end
