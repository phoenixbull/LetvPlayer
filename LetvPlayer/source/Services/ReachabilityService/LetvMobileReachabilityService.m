//
// Created by Kerberos Zhang on 2018/11/22.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import <ReactiveObjC/ReactiveObjC.h>
#import "LetvMobileReachabilityService.h"
#import "LetvMobileReachability.h"


static NSString* LetvMobileReachabilityHostname = @"www.letv.com";


@interface LetvMobileReachabilityService ()
@property (nonatomic, strong) LetvMobileReachability* reachability;
@property (nonatomic, strong) RACSubject* sharedSubject;
@end


@implementation LetvMobileReachabilityService
LETV_SINGLETON_IMPL(sharedService)

#pragma mark -
#pragma mark initialize & finalize

- (instancetype) init
{
    self = [super init];
    if (self) {
        // 缓存当前状态
        _sharedSubject = [RACReplaySubject replaySubjectWithCapacity: 1];
    }
    
    return self;
}

- (void) dealloc {
    [self.sharedSubject sendCompleted];
};

#pragma mark -
#pragma mark Public API

- (void) startup
{
    switch (self.reachability.currentReachabilityStatus) {
        case ReachableViaWiFi:
            [self.sharedSubject sendNext: @(LetvMobileNetworkStateWifi)];
            break;
        case ReachableViaWWAN:
            [self.sharedSubject sendNext: @(LetvMobileNetworkStateWWAN)];
            break;
        case NotReachable:
            [self.sharedSubject sendNext: @(LetvMobileNetworkStateNone)];
        default:
            break;
    }

    [self.reachability startNotifier];
}

- (RACSignal<NSNumber*>*)ltrx_state
{
    return [self.sharedSubject distinctUntilChanged];
}

#pragma mark -
#pragma mark getter
- (LetvMobileReachability*) reachability
{
    @synchronized(self) {
        if (!_reachability) {
            @weakify(self);
            LetvMobileReachability* reachability = [LetvMobileReachability reachabilityWithHostName: LetvMobileReachabilityHostname];
            reachability.reachableBlock = ^(LetvMobileReachability* r) {
                @strongify(self);
                if (r.isReachableViaWiFi) {
                    [self.sharedSubject sendNext: @(LetvMobileNetworkStateWifi)];
                } else {
                    [self.sharedSubject sendNext: @(LetvMobileNetworkStateWWAN)];
                }
            };

            reachability.unreachableBlock = ^(LetvMobileReachability* r) {
                @strongify(self);
                [self.sharedSubject sendNext: @(LetvMobileNetworkStateNone)];
            };

            _reachability = reachability;
        }
    }
    return _reachability;
}
@end
