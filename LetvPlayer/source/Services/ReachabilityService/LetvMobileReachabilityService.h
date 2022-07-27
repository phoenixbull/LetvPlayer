//
// Created by Kerberos Zhang on 2018/11/22.
// Copyright (c) 2018 Letv. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <LetvPlayer/LetvSingleton.h>
#import <LetvPlayer/LetvMobileCore.h>
#import "LetvMobileReachabilityServiceTrait.h"
#import "LetvMobileStartupTrait.h"


NS_ASSUME_NONNULL_BEGIN
@interface LetvMobileReachabilityService : NSObject <LetvMobileStartupTrait, LetvMobileReachabilityServiceTrait>
LETV_SINGLETON_DECLARE(sharedService)

- (void) startup;
- (RACSignal<NSNumber*>*) ltrx_state;
@end
NS_ASSUME_NONNULL_END
