//
// Created by Kerberos Zhang on 2018/11/22.
// Copyright (c) 2018 Letv. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <LetvPlayer/LetvMobileCore.h>
#import <LetvPlayer/LetvMobileServices.h>


NS_ASSUME_NONNULL_BEGIN
@interface LetvMobileTimestampService : NSObject <LetvMobileStartupTrait, LetvMobileTimestampServiceTrait>
LETV_SINGLETON_DECLARE(sharedService)

- (RACSignal<NSNumber*>*) ltrx_requestTimestamp;
@end
NS_ASSUME_NONNULL_END
