//
//  LetvPlayerManager.m
//  LetvMobilePlayerSDK
//
//  Created by letv_lzb on 2022/7/14.
//  Copyright © 2022 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LetvPlayer/LetvPlayerHeader.h>
#import "LetvPlayerManager.h"
#import "LetvPlayerManager_Private.h"

@implementation LetvPlayerManager
LETV_SINGLETON_IMPL(sharedSDK)

- (NSString*) pcode {
    return @"010224023";
}
@end

@implementation LetvPlayerManager(MediaLoader)
- (NSString*) version {
    return @"1.0.1";
}
@end

@implementation LetvPlayerManager(Tracking)
- (NSString*) p1 {
    return @"-";
}

- (NSString*) p2 {
    return @"-";
}

- (NSString*) p3 {
    return @"-";
}

- (NSString*) appName {
    return @"iOSPhoneSDK";
}

- (NSString*) appVersion {
    return @"1.0.1";
}

- (NSString*) uuid {
    if (self._uuid.length) {
        return self._uuid;
    } else {
        return @"-";
    }
}
@end

void LetvPlayerManager_Initialize(NSString * _Nonnull  uuid) {
    LetvMobileMediaLoader_Initialize();

    LetvPlayerManager* sdk = [LetvPlayerManager sharedSDK];
    sdk._uuid = uuid;

    id<LetvMobileTrackingTrait> trackingProvider = sdk;

    [LetvMobileServicesContainer.defaultContainer injectProtocol: @protocol(LetvMobileTrackingTrait) useBlock: ^{
        return trackingProvider;
    }];

    id<LetvMobileMediaLoaderDefaultParametersTrait> parametersProvider = sdk;
    [LetvMobileMediaLoaderContainer.defaultContainer injectProtocol: @protocol(LetvMobileMediaLoaderDefaultParametersTrait) useBlock:^id{
        return parametersProvider;
    }];

    // 上报 login
    id<LetvMobileLoginTrackingTrait> loginTracker = [LetvMobileServicesFactory.defaultFactory createLoginTracker];
    [loginTracker trackLogin];
    sdk.loginTrackingTrait = loginTracker;
}
