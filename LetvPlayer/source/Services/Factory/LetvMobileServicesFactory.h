//
//  LetvMobileServicesFactory.h
//  LetvMobilePlayerSDK
//
//  Created by Zhang Qigang on 2018/12/25.
//  Copyright © 2018 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LetvPlayer/LetvMobileCore.h>
#import <LetvPlayer/LetvMobileStartupTrait.h>
#import <LetvPlayer/LetvMobileTrackingServiceTrait.h>
#import <LetvPlayer/LetvMobileTimestampServiceTrait.h>
#import <LetvPlayer/LetvMobileAppScheduleServiceTrait.h>
#import <LetvPlayer/LetvMobileReachabilityServiceTrait.h>
#import <LetvPlayer/LetvMobileLoginTrackingTrait.h>
#import <LetvPlayer/LetvMobilePlayTrackingTrait.h>
#import <LetvPlayer/LetvMobileCDEInfoTrait.h>

NS_ASSUME_NONNULL_BEGIN

@interface LetvMobileServicesFactory : NSObject
LETV_SINGLETON_DECLARE(defaultFactory)
- (id<LetvMobileTimestampServiceTrait>) createTimestampService;
- (id<LetvMobileAppScheduleServiceTrait>) createAppScheduleService;
- (id<LetvMobileReachabilityServiceTrait>) createReachabilityService;
- (id<LetvMobileTrackingServiceTrait>) createTrackingService;
- (id<LetvMobileLoginTrackingTrait>) createLoginTracker;
- (id<LetvMobilePlayTrackingTrait>) createPlayTrackerWithLoginTracker: (id<LetvMobileLoginTrackingTrait>) loginTracker;
@end

NS_ASSUME_NONNULL_END
