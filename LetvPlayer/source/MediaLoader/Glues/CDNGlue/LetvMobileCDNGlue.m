//
//  LetvMobileCDNGlue.m
//  LetvMobilePlayerSDK
//
//  Created by letv_lzb on 2020/4/10.
//  Copyright © 2020 Letv. All rights reserved.
//

#import "LetvMobileCDNGlue.h"
#import <LetvPlayer/LetvSingleton.h>
#import <LetvPlayer/LetvMobileServices.h>
#import <LetvPlayer/LetvMobileNetworking.h>
#import "NSError+Letv.h"
#import "LetvMobileModels.h"

@interface LetvMobileCDNGlue ()
@property (nonatomic, strong) id<LetvMobileHTTPClientTrait> httpClient;
@end

@implementation LetvMobileCDNGlue

- (RACSignal<NSNumber*>*) ltrx_setup
{
    RACSignal* signal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        dispatch_async(
                dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),
                ^{
//                    initLinkShell();
                    [subscriber sendNext: @(YES)];
                    [subscriber sendCompleted];
                });
        return nil;
    }];

    return signal;
}

- (nonnull RACSignal<NSString *> *)ltrx_parseURLString:(nonnull NSString *)urlString {
    RACSignal* signal = [self videoDispatchLocationModelOfG3UrlString:urlString];

    signal = [signal flattenMap:^(id<LeMPDispatchModel> model) {
        return [RACSignal return: model.mainUrlString];
    }];
    return signal;
}



- (RACSignal*) videoDispatchLocationModelOfG3UrlString: (NSString*) g3UrlString
{
    RACSignal* signal = [RACSignal empty];
    // 原来这个接口没有使用缺省的 Http 系统, 使用的 NSURLConnection
    signal = [self.httpClient rx_GET:g3UrlString parameters:nil];
    signal = [signal flattenMap: ^(NSData *response) {
        NSError *error = nil;
        LTGSLBModel* model = [[LTGSLBModel alloc] initWithData:response error:&error];
        id<LeMPDispatchModel> m = model;
        return [RACSignal return: m];
    }];
    return signal;
}


- (id<LetvMobileHTTPClientTrait>) httpClient {
    if (!_httpClient) {
        _httpClient = [LetvMobileNetworkingFactory.defaultFactory createHTTPClientWithAcceptableContentTypes: @[@"text/html",
        @"application/json",
        @"javascript/json"]];

    }
    return _httpClient;
}

@end
