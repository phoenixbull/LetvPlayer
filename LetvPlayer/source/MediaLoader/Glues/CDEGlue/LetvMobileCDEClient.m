//
// Created by Kerberos Zhang on 2018/11/28.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "RxAFNetworking.h"
#import "LetvMobileNetworkingFactory.h"
#import "LetvMobileHTTPClientTrait.h"
#import "LetvMobileCDEGlue.h"
#import "LetvMobileCDEClient.h"


@interface LetvMobileCDEClient ()
@property (nonatomic, strong) LetvMobileCDEGlue* glue;
@property (nonatomic, strong) id<LetvMobileHTTPClientTrait> httpClient;
@end

@implementation LetvMobileCDEClient


#pragma mark -
#pragma mark Public API

- (RACSignal<NSString*>*) ltrx_startTaskWithURLString: (NSString*) taskURLString
{
    @weakify(self);
    RACSignal* signal = [self.glue ltrx_playURLForURLString: taskURLString];
    // Play URL don't request!
//    signal = [signal flattenMap:^RACSignal*(NSString* requestURLString) {
//        @strongify(self);
//        return [self.httpClient rx_GET: requestURLString parameters: nil];
//    }];
    signal = [signal flattenMap: ^(NSString* url) {
        @strongify(self);
        return [self.glue ltrx_hostHLSURLString: url];
    }];

#ifdef DEBUG
    signal = [signal logAll];
#endif
    return signal;
}

- (RACSignal<NSString*>*) ltrx_stopTaskWithURLString: (NSString*) taskURLString
{
    @weakify(self);
    RACSignal* signal = [self.glue ltrx_stopOperationURLForURLString: taskURLString];
    signal = [signal flattenMap:^RACSignal*(NSString* requestURLString) {
        @strongify(self);
        return [self.httpClient rx_GET: requestURLString parameters: nil];
    }];

#ifdef DEBUG
    signal = [signal logAll];
#endif
    return signal;
}

- (RACSignal<NSString*>*) ltrx_pauseTaskWithURLString: (NSString*) taskURLString
{
    @weakify(self);
    RACSignal* signal = [self.glue ltrx_pauseOperationURLForURLString: taskURLString];
    signal = [signal flattenMap:^RACSignal*(NSString* requestURLString) {
        @strongify(self);
        return [self.httpClient rx_GET: requestURLString parameters: nil];
    }];

#ifdef DEBUG
    signal = [signal logAll];
#endif
    return signal;
}

- (RACSignal<NSString*>*) ltrx_resumeTaskWithURLString: (NSString*) taskURLString
{
    @weakify(self);
    RACSignal* signal = [self.glue ltrx_resumeOperationURLForURLString: taskURLString];
    signal = [signal flattenMap:^RACSignal*(NSString* requestURLString) {
        @strongify(self);
        return [self.httpClient rx_GET: requestURLString parameters: nil];
    }];

#ifdef DEBUG
    signal = [signal logAll];
#endif
    return signal;
}

- (RACSignal*) ltrx_seekTaskWithURLString: (NSString*) taskURLString duration: (NSTimeInterval) duration
{
    [self.glue seekToDuration: duration forURLString: taskURLString];
    return [RACSignal return: @(duration)];
}

#pragma mark -
#pragma mark - getter

- (id<LetvMobileHTTPClientTrait>)httpClient
{
    @synchronized (self) {
        if (!_httpClient) {
            id<LetvMobileHTTPClientTrait> client = [LetvMobileNetworkingFactory.defaultFactory createHTTPClient];
            _httpClient = client;
        }
    }
    return _httpClient;
}

- (LetvMobileCDEGlue*) glue
{
    return [LetvMobileCDEGlue sharedGlue];
}
@end
