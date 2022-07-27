//
// Created by Kerberos Zhang on 2018/11/7.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "LetvMobileNetworkingFactory.h"
#import "LetvHttpSessionManager.h"
#import "LetvMobileHTTPClientTrait.h"
#import "AFHTTPSessionManager+Letv.h"
#import "LetvMobileServicesGlue.h"

@interface AFHTTPSessionManager()<LetvMobileHTTPClientTrait>
@end

@implementation LetvMobileServicesGlue
LETV_SINGLETON_IMPL(defaultFactory)
- (id<LetvMobileHTTPClientTrait>) createTimestampHttpClient
{
    NSURLSessionConfiguration* configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = 30;

    AFHTTPSessionManager* manager = [[AFHTTPSessionManager alloc] letv_initWithBaseURLString: @"http://dynamic.app.m.letv.com"
                                                                        sessionConfiguration: configuration];
    AFJSONResponseSerializer* serializer = [AFJSONResponseSerializer serializer];
    serializer.acceptableContentTypes = [NSSet setWithArray: @[
            @"text/json",
            @"text/javascript",
            @"application/javascript",
            @"application/json",
            @"text/html",
    ]];
    manager.responseSerializer = serializer;
    return manager;
}
@end
