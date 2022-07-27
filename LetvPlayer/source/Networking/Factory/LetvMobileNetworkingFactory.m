//
// Created by Kerberos Zhang on 2018/11/7.
// Copyright (c) 2018 Letv. All rights reserved.
//


#import <AFNetworking/AFNetworking.h>
#import <LetvPlayer/RxAFNetworking.h>
#import "LetvHttpServerAPISignatureHelper.h"
#import "LetvHttpServerUniversalParametersHelper.h"
#import "LetvMobileNetworkingContainer.h"
#import "LetvHttpSessionManager.h"
#import "LetvHttpRequestSerializer.h"
#import "AFHTTPSessionManager+Letv.h"
#import "LetvHttpRequestSerializer.h"
#import "LetvMobileNetworkingFactory.h"

/*
 * RxAFNetworking 中已经实现了 LetvMobileHTTPClientTrait 的接口, 这里只是标记一下.
 */
@interface AFHTTPSessionManager ()<LetvMobileHTTPClientTrait>
@end

@interface LetvMobileNetworkingFactory ()
- (LetvHttpRequestSerializer*) createRequestSerializerWithDefaultGETParameters: (id<LetvMobileHTTPDefaultGETParametersTrait>) parametersTrait
                                                                  useSignature: (BOOL) useSignature;
@end


@implementation LetvMobileNetworkingFactory
LETV_SINGLETON_IMPL(defaultFactory)

- (instancetype) init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (id<LetvMobileHTTPClientTrait>) createAFHTTPSessionManager
{
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    return manager;
}

- (id<LetvMobileHTTPClientTrait>) createAFHTTPSessionManagerWithAcceptableContentTypes: (NSArray<NSString*>*) acceptableContentTypes
{
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    AFHTTPResponseSerializer* serializer = [AFHTTPResponseSerializer serializer];
    serializer.acceptableContentTypes = [NSSet setWithArray: acceptableContentTypes];
    manager.responseSerializer = serializer;
    return manager;
    
}

- (id<LetvMobileHTTPClientTrait>) createAFHTTPSessionManagerWithBaseURLString: (NSString*) URLString
{
    AFHTTPSessionManager* manager = [[AFHTTPSessionManager alloc] letv_initWithBaseURLString: URLString];
    return manager;
}

- (id<LetvMobileHTTPClientTrait>) createAFHTTPSessionManagerWithBaseURLString: (NSString*) URLString
                                                       acceptableContentTypes: (NSArray<NSString*>*) acceptableContentTypes
{
    AFHTTPSessionManager* manager = [[AFHTTPSessionManager alloc] letv_initWithBaseURLString: URLString];
    AFHTTPResponseSerializer* serializer = [AFHTTPResponseSerializer serializer];
    serializer.acceptableContentTypes = [NSSet setWithArray: acceptableContentTypes];
    manager.responseSerializer = serializer;
    return manager;
}

- (id<LetvMobileHTTPClientTrait>) createAFHTTPSessionManagerWithBaseURLString: (NSString*) URLString
                                                         sessionConfiguration: (NSURLSessionConfiguration*) configuration
{
    AFHTTPSessionManager* manager = [[AFHTTPSessionManager alloc] letv_initWithBaseURLString: URLString
                                                                        sessionConfiguration: configuration];
    return manager;
}

- (LetvHttpRequestSerializer*) createRequestSerializerWithDefaultGETParameters: (id<LetvMobileHTTPDefaultGETParametersTrait>) parametersTrait
                                                                  useSignature: (BOOL) useSignature
{
    LetvHttpRequestSerializer* serializer = [LetvHttpRequestSerializer serializer];

    serializer.parametersRewriteBlock = ^(_Nullable id parameters, NSError* _Nullable __autoreleasing* error) {
        LetvHttpServerUniversalParametersHelper* helper = [[LetvHttpServerUniversalParametersHelper alloc] init];
        helper.letv_container = [LetvMobileNetworkingContainer new];
        [helper.letv_container injectProtocol: @protocol(LetvMobileHTTPDefaultGETParametersTrait)
                                     useBlock: ^{
                                         return parametersTrait;
                                     }];
        return [helper parametersByParameters: parameters error: error];
    };

    if (useSignature) {
        serializer.requestRewriteBlock = ^(NSURLRequest* request, NSError* _Nullable __autoreleasing* error) {
            return [[LetvHttpServerAPISignatureHelper defaultHelper] requestBySigningRequest: request error:  error];
        };
    }

    return serializer;
}


- (id<LetvMobileHTTPClientTrait>) createHTTPClient
{
    return [self createHTTPClientWithBaseURLString: nil
                                  secondsOfTimeout: 30
                            acceptableContentTypes: nil
                              defaultGETParameters: nil
                                      useSignature: NO];
}

- (id<LetvMobileHTTPClientTrait>) createHTTPClientWithAcceptableContentTypes: (NSArray<NSString*>* _Nullable) acceptableContentTypes
{
    return [self createHTTPClientWithBaseURLString: nil
                                  secondsOfTimeout: 30
                            acceptableContentTypes: acceptableContentTypes
                              defaultGETParameters: nil
                                      useSignature: NO];
}

- (id<LetvMobileHTTPClientTrait>) createHTTPClientWithBaseURLString: (NSString* _Nullable) urlString
                                             acceptableContentTypes: (NSArray<NSString*>* _Nullable) acceptableContentTypes
{
    return [self createHTTPClientWithBaseURLString: urlString
                                  secondsOfTimeout: 30
                            acceptableContentTypes: acceptableContentTypes
                              defaultGETParameters: nil
                                      useSignature: NO];
}

- (id<LetvMobileHTTPClientTrait>) createHTTPClientWithBaseURLString: (NSString*) urlString
                                                   secondsOfTimeout: (NSInteger) timeout
                                             acceptableContentTypes: (NSArray<NSString*>*) acceptableContentTypes
                                               defaultGETParameters: (id<LetvMobileHTTPDefaultGETParametersTrait>) defaultParameters
                                                       useSignature: (BOOL) useSignature
{
    AFHTTPSessionManager* manager = [[AFHTTPSessionManager alloc] letv_initWithBaseURLString: urlString];
    AFHTTPResponseSerializer* serializer = [AFHTTPResponseSerializer serializer];
    if (acceptableContentTypes) {
        serializer.acceptableContentTypes = [NSSet setWithArray: acceptableContentTypes];
    } else {
        serializer.acceptableContentTypes = [NSSet setWithArray: @[@"*/*"]];
    }
    manager.responseSerializer = serializer;
    
    manager.requestSerializer = [self createRequestSerializerWithDefaultGETParameters: defaultParameters useSignature: useSignature];
    
    return manager;
}

- (id<LetvMobileHTTPClientTrait>) createJSONClientWithBaseURLString: (NSString*) urlString
                                                   secondsOfTimeout: (NSInteger) timeout
                                             acceptableContentTypes: (NSArray<NSString*>*) acceptableContentTypes
                                               defaultGETParameters: (id<LetvMobileHTTPDefaultGETParametersTrait>) defaultParameters
                                                       useSignature: (BOOL) useSignature
{
    AFHTTPSessionManager* manager = [[AFHTTPSessionManager alloc] letv_initWithBaseURLString: urlString];
    AFHTTPResponseSerializer* serializer = [AFJSONResponseSerializer serializer];
    if (acceptableContentTypes) {
        serializer.acceptableContentTypes = [NSSet setWithArray: acceptableContentTypes];
    }
    manager.responseSerializer = serializer;
    
    manager.requestSerializer = [self createRequestSerializerWithDefaultGETParameters: defaultParameters useSignature: useSignature];
    
    return manager;
}
@end
