//
//  LetvMobileAppScheduleService.m
//  LetvMobileServices
//
//  Created by Kerberos Zhang on 2018/11/24.
//  Copyright © 2018年 Letv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "LetvMobileAppScheduleService.h"


@interface LetvMobileAppScheduleService ()
@property (nonatomic, strong) RACMulticastConnection* sharedConnection;
@end

@implementation LetvMobileAppScheduleService
LETV_SINGLETON_IMPL(sharedService)

- (void) startup
{
    [self.ltrx_state
            subscribeCompleted: ^{}];
}

#pragma mark -
#pragma mark Public API

- (RACSignal<NSNumber*>*)ltrx_state
{
    return [self.sharedConnection autoconnect];
}

#pragma mark -
#pragma mark getter

- (RACMulticastConnection*)sharedConnection
{
    @synchronized (self) {
        if (!_sharedConnection) {
            NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
            RACSignal* s1 = [[[nc rac_addObserverForName: UIApplicationDidBecomeActiveNotification object: nil]
                    takeUntil: self.rac_willDeallocSignal]
                    map:^id(NSNotification* _) {
                        return @(LetvMobileAppStateActive);
                    }];

            RACSignal* s2 = [[[nc rac_addObserverForName: UIApplicationWillResignActiveNotification object: nil]
                    takeUntil: self.rac_willDeallocSignal]
                    map:^id(NSNotification* _) {
                        return @(LetvMobileAppStateInactive);
                    }];

            RACSignal* s3 = [[[nc rac_addObserverForName: UIApplicationDidEnterBackgroundNotification object: nil]
                    takeUntil: self.rac_willDeallocSignal]
                    map:^id(NSNotification* _) {
                        return @(LetvMobileAppStateBackground);
                    }];

            LetvMobileAppState initialState = LetvMobileAppStateActive;
            switch ([UIApplication.sharedApplication applicationState]) {
                case UIApplicationStateActive:
                    initialState = LetvMobileAppStateActive;
                    break;
                case UIApplicationStateInactive:
                    initialState = LetvMobileAppStateInactive;
                    break;
                case UIApplicationStateBackground:
                    initialState = LetvMobileAppStateBackground;
                    break;
            }

            RACSignal* signal = [[[RACSignal merge:@[s1, s2, s3]] startWith:@(initialState)] distinctUntilChanged];
            // 缓存当前的 App 状态.
            RACMulticastConnection* connection = [signal multicast: [RACReplaySubject replaySubjectWithCapacity: 1]];
            _sharedConnection = connection;
        }
    }
    return _sharedConnection;
}
@end
