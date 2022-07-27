//
//  LetvCPUTickCountHelper.h
//  LetvMobileServices
//
//  Created by Kerberos Zhang on 2018/11/24.
//  Copyright © 2018年 Letv. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "LetvMobileCore.h"

@interface LetvCPUTickCountHelper : NSObject
LETV_SINGLETON_DECLARE(defaultHelper)

- (NSTimeInterval) currentCPUTickCount;
@end
