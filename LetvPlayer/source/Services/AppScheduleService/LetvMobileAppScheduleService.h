//
//  LetvMobileAppScheduleService.h
//  LetvMobileServices
//
//  Created by Kerberos Zhang on 2018/11/24.
//  Copyright © 2018年 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <LetvPlayer/LetvMobileCore.h>
#import "LetvMobileStartupTrait.h"
#import "LetvMobileAppScheduleServiceTrait.h"


NS_ASSUME_NONNULL_BEGIN
@interface LetvMobileAppScheduleService : NSObject<LetvMobileStartupTrait, LetvMobileAppScheduleServiceTrait>
LETV_SINGLETON_DECLARE(sharedService)

- (RACSignal<NSNumber*>*) ltrx_state;
@end
NS_ASSUME_NONNULL_END
