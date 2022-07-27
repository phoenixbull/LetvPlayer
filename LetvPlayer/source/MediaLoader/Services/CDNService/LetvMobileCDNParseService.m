//
//  LetvMobileCDNParseService.m
//  LetvMobilePlayerSDK
//
//  Created by letv_lzb on 2020/4/10.
//  Copyright © 2020 Letv. All rights reserved.
//

#import "LetvMobileCDNParseService.h"
#import "LetvMobileCDNGlue.h"

@interface LetvMobileCDNParseService ()
@property (nonatomic, strong) RACMulticastConnection* sharedStartupConnection;
@property (nonatomic, strong) LetvMobileCDNGlue* client;
@end

@implementation LetvMobileCDNParseService
//LETV_SINGLETON_IMPL(sharedService)

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
        LetvMobileCDNGlue* client = [[LetvMobileCDNGlue alloc] init];
        _client = client;
    }

    return self;
}

#pragma mark -
#pragma mark Public API

- (RACSignal<NSString*>*) ltrx_parseURLString: (NSString*) urlString
{
    @weakify(self);
    RACSignal* signal = [self.ltrx_startup flattenMap: ^RACSignal* (id _) {
        @strongify(self);
        return [self.client ltrx_parseURLString: urlString];
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
