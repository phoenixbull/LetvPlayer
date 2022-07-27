//
//  LetvMobileServicesFactory.m
//  LetvMobilePlayerSDK
//
//  Created by Zhang Qigang on 2018/12/25.
//  Copyright © 2018 Letv. All rights reserved.
//

#import "LetvMobileTrackingTrait.h"
#import "LetvMobileServicesContainer.h"
#import "LetvMobileTimestampService.h"
#import "LetvMobileAppScheduleService.h"
#import "LetvMobileReachabilityService.h"
#import "LetvMobileTrackingService.h"
#import "LetvMobileLoginTracker.h"
#import "LetvMobilePlayTracker.h"

#import "LetvMobileServicesFactory.h"

@implementation LetvMobileServicesFactory
LETV_SINGLETON_IMPL(defaultFactory)

- (id<LetvMobileTimestampServiceTrait>) createTimestampService {
    return [LetvMobileTimestampService sharedService];
}

- (id<LetvMobileAppScheduleServiceTrait>) createAppScheduleService {
    return [LetvMobileAppScheduleService sharedService];
}

- (id<LetvMobileReachabilityServiceTrait>) createReachabilityService {
    return [LetvMobileReachabilityService sharedService];
}

- (id<LetvMobileTrackingServiceTrait>) createTrackingService {
    return [LetvMobileTrackingService sharedService];
}

- (id<LetvMobileLoginTrackingTrait>) createLoginTracker
{
    LetvMobileServicesContainer* container = [LetvMobileServicesContainer defaultContainer];
    id<LetvMobileTrackingTrait> trait = [container resolveProtocol: @protocol(LetvMobileTrackingTrait)];
    NSString* uuid = trait.uuid;
    return [[LetvMobileLoginTracker alloc] initWithUdid: uuid];
}

- (id<LetvMobilePlayTrackingTrait>) createPlayTrackerWithLoginTracker: (id<LetvMobileLoginTrackingTrait>) loginTracker
{
    LetvMobileServicesContainer* container = [LetvMobileServicesContainer defaultContainer];
    id<LetvMobileTrackingTrait> trait = [container resolveProtocol: @protocol(LetvMobileTrackingTrait)];
    NSString* uuid = trait.uuid;
    return [[LetvMobilePlayTracker alloc] initWithUdid: uuid loginTrackTrait: loginTracker];
}
@end
