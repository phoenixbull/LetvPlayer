//
// Created by Kerberos Zhang on 2018/11/28.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import "LetvCDE.h"
//#import <LetvCDE/LetvCDE.h>
#import "LetvMobileLinkShellGlue.h"
#import "LetvMobileLinkShellService.h"


@interface LetvMobileLinkShellService ()
@property (nonatomic, strong) RACMulticastConnection* sharedStartupConnection;
@property (nonatomic, strong) LetvMobileLinkShellGlue* client;
@end

@implementation LetvMobileLinkShellService
LETV_SINGLETON_IMPL(sharedService)

- (void) startup
{
    [[self ltrx_startup]
            subscribeCompleted: ^{}];
}

#pragma mark -
#pragma mark initilize & finalize

- (instancetype) init
{
    self = [super init];
    if (self) {
        LetvMobileLinkShellGlue* client = [[LetvMobileLinkShellGlue alloc] init];
        _client = client;
    }

    return self;
}

#pragma mark -
#pragma mark Public API
- (RACSignal<NSString*>*) ltrx_decryptURLString: (NSString*) urlString
{
    @weakify(self);
    RACSignal* signal = [self.ltrx_startup flattenMap: ^RACSignal* (id _) {
        @strongify(self);
        return [self.client ltrx_decryptURLString: urlString];
    }];

    return signal;
}

#pragma mark -
#pragma mark Private API

- (RACSignal*) ltrx_startup
{
    return [self.sharedStartupConnection autoconnect];
}

#pragma mark -
#pragma mark getter

- (RACMulticastConnection*)sharedStartupConnection
{
    @synchronized (self) {
        if (!_sharedStartupConnection) {
            RACSignal* signal = [self.client ltrx_setup];
            // 设置, 无需多次. 故缓存 1.
            RACMulticastConnection* connection = [signal multicast: [RACReplaySubject replaySubjectWithCapacity:1]];
            _sharedStartupConnection = connection;
        }
    }
    return _sharedStartupConnection;
}
@end
