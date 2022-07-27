//
// Created by Kerberos Zhang on 2018/11/11.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import "LetvMobileLoginTracker.h"
#import "LetvMobilePlayTracker.h"
#import "LetvMobilePlayerKitFactory.h"


@implementation LetvMobilePlayerKitFactory
LETV_SINGLETON_IMPL(defaultFactory)
- (id<LetvMobileLoginTrackingTrait>) createLoginTracker
{
    return [LetvMobileLoginTracker new];
}
@end
