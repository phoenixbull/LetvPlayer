//
//  LetvCPUTickCountHelper.m
//  LetvMobileServices
//
//  Created by Kerberos Zhang on 2018/11/24.
//  Copyright © 2018年 Letv. All rights reserved.
//


#include <mach/mach.h>
#include <mach/mach_time.h>

#import "LetvCPUTickCountHelper.h"

@implementation LetvCPUTickCountHelper
LETV_SINGLETON_IMPL(defaultHelper)

- (NSTimeInterval) currentCPUTickCount
{
    uint64_t cpuTicks = mach_absolute_time();
    static const uint64_t NANOS_PER_USEC = 1000ULL;
    static const uint64_t NANOS_PER_MILLISEC = 1000ULL * NANOS_PER_USEC;
    static const uint64_t NANOS_PER_SEC = 1000ULL * NANOS_PER_MILLISEC;
    
    mach_timebase_info_data_t timebase;
    mach_timebase_info(&timebase);
    return (double)cpuTicks * (double)timebase.numer / (double)timebase.denom / NANOS_PER_SEC;
}
@end
