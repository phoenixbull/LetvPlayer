//
//  FixedTrackingParametersHelper.m
//  LetvMobilePlayerSDK
//
//  Created by Zhang Qigang on 2019/1/2.
//  Copyright © 2019 Letv. All rights reserved.
//

#import <stdlib.h>
#import <sys/utsname.h>
#import <AdSupport/ASIdentifierManager.h>
#import "LetvMobileTrackingTrait.h"
#import "LetvMobileServicesContainer.h"

#import "LetvMobileReachability.h"
#import "FixedTrackingParametersHelper.h"

static NSString* LetvMobileReachabilityHostname = @"www.letv.com";

@interface FixedTrackingParametersHelper ()
@property (nonatomic, copy, readwrite) NSString* udid;
@property (nonatomic, copy, readwrite) NSString* appVersion;
@property (nonatomic, copy, readwrite) NSString* appName;
@property (nonatomic, copy, readwrite) NSString* networkType;
@property (nonatomic, copy, readwrite) NSString* osName;
@property (nonatomic, copy, readwrite) NSString* vendor;
@property (nonatomic, copy, readwrite) NSString* model;
@property (nonatomic, copy, readwrite) NSString* idfa;

@property (nonatomic, strong) LetvMobileReachability* reachability;
@end

@implementation FixedTrackingParametersHelper
LETV_SINGLETON_IMPL(defaultHelper)

#pragma mark -
#pragma mark getter

- (NSString*) appVersion {
    return @"0.9.0";
}

- (NSString*) appName {
    return @"iOSPhoneMGSDK";
}

- (NSString*) idfa {
    if (!_idfa) {
        NSString* idfa = [[ASIdentifierManager.sharedManager advertisingIdentifier] UUIDString];
        _idfa = idfa;
    }
    if (_idfa.length > 0) {
        return _idfa;
    } else {
        return @"-";
    }
}

- (NSString*) networkType {
    NSString* nt = ^{
    switch ([self.reachability currentReachabilityStatus]) {
        case NotReachable:
            return @"nont";
        case ReachableViaWiFi:
            return @"wifi";
        case ReachableViaWWAN:
            return @"4g";
        default:
            return @"-";
    }}();
    return nt;
}

- (NSString*) osName {
    return @"iOS";
}

- (NSString*) vendor {
    return @"Apple";
}

- (NSString*) model {
    if (!_model) {
        struct utsname systemInfo;
        uname(&systemInfo);
        NSString* code = [NSString stringWithCString:systemInfo.machine
                                            encoding:NSUTF8StringEncoding];
        
        if (code.length == 0) {
            _model = @"unknown";
        } else {
            _model = code;
        }
    }
    
    return _model;
}

- (NSString*) auid {
    return self.udid;
}

- (NSString*) udid {
    if (!_udid.length) {
        id<LetvMobileTrackingTrait> trait = [LetvMobileServicesContainer.defaultContainer resolveProtocol: @protocol(LetvMobileTrackingTrait)];
        _udid = trait.uuid;
    }
    
    return _udid;
}

- (LetvMobileReachability*) reachability {
    if (!_reachability) {
        _reachability = [LetvMobileReachability reachabilityWithHostName: LetvMobileReachabilityHostname];
    }
    return _reachability;
}

- (NSString*) randomSeed {
    /* TODO: max to 999999999999 */
    unsigned long long bw = (unsigned long long) arc4random_uniform(999999999);
    unsigned long long lw = (unsigned long long) arc4random_uniform(999999999);
    unsigned long long seed = bw * 1000 + lw;
    return [NSString stringWithFormat: @"%012lld", seed];
}
@end
