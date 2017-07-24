//
//  ChoosePicture.h
//  zhongxunLive
//
//  Created by mahaibo on 17/6/26.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ChoosePicType) {
    ChoosePicTypeFromPhoto,
    ChoosePicTypeFromCamera,
};


@interface ChoosePicture : NSObject




+ (void)choosePictureFrom:(ChoosePicType) type;




@end
