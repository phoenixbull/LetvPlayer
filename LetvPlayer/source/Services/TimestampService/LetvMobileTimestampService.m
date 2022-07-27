//
// Created by Kerberos Zhang on 2018/11/22.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import "LetvCPUTickCountHelper.h"
#import "LetvTimestampModel.h"
#import "LetvTimestampClient.h"
#import "LetvMobileTimestampService.h"


// 服务器的允许误差为 300s.
static const NSTimeInterval LetvServerTimeExpiredInterval = 300.0f;


// 使用单独结构, 加强原子性. 避免一致性问题.
@interface LetvMobileTimestampServiceState : NSObject
@property (nonatomic, assign) NSTimeInterval baseServerTimestamp;
@property (nonatomic, assign) NSTimeInterval baseCPUTimestamp;
@property (nonatomic, assign) NSTimeInterval baseTimeDiffCompareWithCurrentTime;
@end

@implementation LetvMobileTimestampServiceState
@end


@interface LetvMobileTimestampService ()
@property (nonatomic, strong) LetvTimestampClient* client;
@property (nonatomic, strong) RACSubject* sharedConnectionSubject;
@property (nonatomic, strong) LetvMobileTimestampServiceState* state;

- (RACSignal*) ltrx_sharedRequestTimestamp;
@end


@implementation LetvMobileTimestampService
#pragma mark -
#pragma mark initialize & finalize
LETV_SINGLETON_IMPL(sharedService)

- (instancetype) init
{
    self = [super init];
    if (self) {
    }

    return self;
}

#pragma mark -
#pragma mark Public API
- (void) startup
{
    // 启动即开始同步时间戳
    [[self ltrx_requestTimestamp]
            subscribeCompleted:^{
            }];
}

- (RACSignal<NSNumber*>*) ltrx_requestTimestamp
{

    @weakify(self);
    RACSignal<NSNumber*>* signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self);
        NSTimeInterval timestamp = 0.0f;
        LetvMobileTimestampServiceState* state = self.state;
        timestamp = state.baseServerTimestamp - state.baseCPUTimestamp + [LetvCPUTickCountHelper.defaultHelper currentCPUTickCount];
        [subscriber sendNext: @(timestamp)];
        [subscriber sendCompleted];
        return nil;
    }];

    signal = [signal flattenMap: ^(NSNumber* timestamp){
        @strongify(self);
        LetvMobileTimestampServiceState* state = self.state;
        NSTimeInterval timediff = CGFLOAT_MAX;
        timediff = timestamp.doubleValue - [[NSDate date] timeIntervalSince1970];
        if (fabs(timediff - state.baseTimeDiffCompareWithCurrentTime) < LetvServerTimeExpiredInterval / 2) {
            return [RACSignal return: timestamp];
        } else {
            return [self ltrx_sharedRequestTimestamp];
        }
    }];
    return signal;
}

#pragma mark -
#pragma mark Private API

- (RACSignal*) ltrx_sharedRequestTimestamp
{
    @weakify(self);
    RACSignal* signal = [[self.client ltrx_requestTimestamp]
            map:^id _Nullable(LetvTimestampModel * _Nullable model) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSTimeInterval timestamp = [[formatter dateFromString: model.dateString] timeIntervalSince1970];
                return @(floor(timestamp));
            }];
                         
    signal = [signal doNext:^(NSNumber* timestamp) {
                @strongify(self);
                LetvMobileTimestampServiceState* state = [[LetvMobileTimestampServiceState alloc] init];
                state.baseServerTimestamp = [timestamp doubleValue];
                state.baseCPUTimestamp = [LetvCPUTickCountHelper.defaultHelper currentCPUTickCount];
                state.baseTimeDiffCompareWithCurrentTime = [timestamp doubleValue] - [[NSDate date] timeIntervalSince1970];

                self.state = state;
            }];
    
    return [[signal multicast: self.sharedConnectionSubject] autoconnect];
}

#pragma mark -
#pragma mark getter

- (LetvTimestampClient*) client
{
    @synchronized(self) {
        if (!_client) {
            LetvTimestampClient* client = [LetvTimestampClient client];
            _client = client;
        }
    }
    return _client;
}

- (RACSubject*) sharedConnectionSubject
{
    @synchronized(self) {
        if (!_sharedConnectionSubject) {
            RACSubject* subject = [RACSubject subject];
            _sharedConnectionSubject = subject;
        }
    }
    
    return _sharedConnectionSubject;
}
@end
