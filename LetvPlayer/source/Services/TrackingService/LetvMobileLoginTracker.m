//
//  LetvMobileLoginTracker.m
//  LetvMobilePlayerSDK
//
//  Created by Zhang Qigang on 2018/12/28.
//  Copyright © 2018 Letv. All rights reserved.
//

#import "LetvMobileTrackingService.h"
#import "LetvMobileLoginTracker.h"


@interface LetvMobileLoginTracker ()
@property (nonatomic, strong) LetvMobileTrackingService* service;
@end

@implementation LetvMobileLoginTracker
- (instancetype) init NS_UNAVAILABLE
{
    return nil;
}

- (instancetype) initWithUdid: (NSString*) udid
{
    self = [super init];
    if (self) {
        NSInteger tm = (NSInteger)[[NSDate date] timeIntervalSince1970];
        NSString* sessionId = [NSString stringWithFormat: @"%@_%zd", udid, tm];
        _sessionId = sessionId;
    }
    
    return self;
}

- (void) trackLogin {
    // TODO: track login
    [self.service loginWithSessionId: self.sessionId];
}

#pragma mark -
#pragma mark getter

- (LetvMobileTrackingService*) service {
    if (!_service) {
        _service = [LetvMobileTrackingService sharedService];
    }
    return _service;
}
@end
