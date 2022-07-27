//
// Created by Kerberos Zhang on 2018/11/29.
// Copyright (c) 2018 Letv. All rights reserved.
//

//#import <LetvCDE/LetvCDE.h>
#import "LetvCDE.h"
#import <LetvPlayer/LetvMobileServices.h>
#import <LetvPlayer/LetvMobileNetworking.h>
#import "LetvMobileCDEGlue.h"

@interface LetvMobileCDEGlue ()
@property (nonatomic, copy, readwrite) NSString* cachePath;
@property (nonatomic, copy, readwrite) NSString* logPath;
@property (nonatomic, copy, readwrite) NSString* offlineAdvertisePath;
@property (nonatomic, copy, readwrite) NSString* versionString;
@property (nonatomic, copy, readwrite) NSString* appId;
@property (nonatomic, assign, readwrite) NSInteger servicePort;
@property (nonatomic, assign, readwrite) NSInteger offlineAdvertiseCacheSize;
@property (nonatomic, assign, readwrite) BOOL offlineAdvertiseEnabled;

@property (nonatomic, weak) id<LetvMobileAppScheduleServiceTrait> appScheduleService;
@property (nonatomic, strong) NSString* letvPath;
@property (nonatomic, strong) CdeService* cdeService;
@property (nonatomic, strong) RACMulticastConnection* sharedConnection;
@property (nonatomic, strong) id<LetvMobileHTTPClientTrait> httpClient;
@end

@implementation LetvMobileCDEGlue
LETV_SINGLETON_IMPL(sharedGlue)

#pragma mark -
#pragma mark initialize & finalize
- (instancetype) init
{
    self = [super init];
    if (self) {
        NSString* libPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
        NSString* letvPath = [libPath stringByAppendingPathComponent: @"libLetvProtected"];
        _letvPath = letvPath;

        _cdeService = nil;
        _cachePath = letvPath;
        _logPath = [letvPath stringByAppendingPathComponent: @"cde.log"];
        _offlineAdvertisePath = [letvPath stringByAppendingPathComponent: @"cde-dcaches"];
        _offlineAdvertiseEnabled = YES;
        _offlineAdvertiseCacheSize = 50;
        _servicePort = 6991;
        _appId = @"4002";
    }
    return self;
}

#pragma mark -
#pragma mark Public API

- (RACSignal<NSString*>*) ltrx_playURLForURLString: (NSString*) urlString
{
    RACSignal* signal = [[self.sharedConnection autoconnect] take: 1];
    signal = [signal map: ^id(CdeService* service) {
        NSString* url = [service playUrl: urlString];
#ifdef DEBUG
        NSLog(@"cde palyUrl is: %@",url);
#endif
        return url;
    }];

    return signal;
}

- (RACSignal<NSString*>*) ltrx_pauseOperationURLForURLString: (NSString*) urlString
{
    RACSignal* signal = [[self.sharedConnection autoconnect] take: 1];
    signal = [signal map: ^id(CdeService* service) {
        NSString* url = [service pauseUrl: urlString];
        return url;
    }];

    return signal;
}

- (RACSignal<NSString*>*) ltrx_resumeOperationURLForURLString: (NSString*) urlString
{
    RACSignal* signal = [[self.sharedConnection autoconnect] take: 1];
    signal = [signal map: ^id(CdeService* service) {
        NSString* url = [service resumeUrl: urlString];
        return url;
    }];

    return signal;
}

- (RACSignal<NSString*>*) ltrx_stopOperationURLForURLString: (NSString*) urlString
{
    RACSignal* signal = [[self.sharedConnection autoconnect] take: 1];
    signal = [signal map: ^id(CdeService* service) {
        NSString* url = [service stopUrl: urlString];
        return url;
    }];

    return signal;
}

- (RACSignal<NSString*>*) ltrx_hostHLSURLString: (NSString*) urlString
{
    @weakify(self);
    RACSignal* signal = [[self.sharedConnection autoconnect] take: 1];
    signal = [signal
              flattenMap: ^(CdeService* service) {
                  @strongify(self);
                  return [[self.httpClient rx_GET: urlString parameters: nil]
                          map: ^(NSData* contentData) {
                              NSString* content = [[NSString alloc] initWithData: contentData encoding: NSUTF8StringEncoding];
                              NSString* url = [service cacheUrlWithData: content ext: @"m3u8" g3url: urlString other: @""];
#ifdef DEBUG
                      NSLog(@"cacheUrl request url is %@, content is %@ ,cacheUrl is %@",urlString,content,url);
#endif
                              return url;
                          }];
              }];
    
    return signal;
}

- (void) seekToDuration: (NSTimeInterval) seekPosition forURLString: (NSString*) urlString
{
    RACSignal* signal = [[self.sharedConnection autoconnect] take: 1];
    [signal subscribeNext:^(CdeService* service) {
        [service setChannelSeekPosition: urlString pos: seekPosition];
    }];
}

- (BOOL)available
{
    return [self.cdeService ready];
}

- (NSString*)versionString
{
    return [self.cdeService versionString];
}

#pragma mark -
#pragma mark Private API
- (RACSignal<CdeService*>*) ltrx_setup
{
    @weakify(self);
    RACSignal* signal = [RACSignal createSignal:^RACDisposable*(id <RACSubscriber> subscriber) {
        @strongify(self);
        NSFileManager* fm = [NSFileManager defaultManager];
        if (![fm fileExistsAtPath: self.letvPath]) {
            [fm createDirectoryAtPath: self.letvPath withIntermediateDirectories: YES attributes: nil error: nil];
        }

        NSString* cdeStartupParams = [NSString stringWithFormat: @"channel_default_multi=0&channel_max_count=1&port=%zd&app_id=%@&auto_active=0&dcache_enabled=%d"
                                                                 "&dcache_capacity=%zd&data_dir=%@&log_type=4&log_file=%@",
                self.servicePort, self.appId, self.offlineAdvertiseEnabled, self.offlineAdvertiseCacheSize, self.cachePath, self.logPath ];
        CdeService* service = [[CdeService alloc] initWithParams: cdeStartupParams];
        [subscriber sendNext: service];
        [subscriber sendCompleted];
        return nil;
    }];

    signal =  [signal doNext:^(CdeService* service) {
        @strongify(self);
        self.cdeService = service;
        [[[self.appScheduleService ltrx_state]
                filter:^BOOL(NSNumber*state) {
                    return state.integerValue == LetvMobileAppStateActive;
                }]
                subscribeNext:^(NSNumber* _) {
                    [self.cdeService activate];
                }];
    }];

    return signal;
}

#pragma mark -
#pragma mark getter & setter
- (RACMulticastConnection*)sharedConnection
{
    @synchronized (self) {
        if (!_sharedConnection) {
            RACSubject* replaySubject = [RACReplaySubject replaySubjectWithCapacity: 1];
            RACSignal* signal = [self ltrx_setup];
            RACMulticastConnection* connection = [signal multicast: replaySubject];
            _sharedConnection = connection;
        }
    }

    return _sharedConnection;
}

- (id<LetvMobileAppScheduleServiceTrait>) appScheduleService
{
    return [LetvMobileServicesFactory.defaultFactory createAppScheduleService];
}

- (id<LetvMobileHTTPClientTrait>) httpClient {
    if (!_httpClient) {
        _httpClient = [LetvMobileNetworkingFactory.defaultFactory createHTTPClientWithAcceptableContentTypes: @[@"application/x-mpegurl"]];
        
    }
    return _httpClient;
}
@end
