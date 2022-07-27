//
// Created by Kerberos Zhang on 2018/11/18.
// Copyright (c) 2018 Letv. All rights reserved.
//


#import "LetvHttpServerUniversalParametersHelper.h"
#import "LetvHttpServerAPISignatureHelper.h"
#import "LetvHttpRequestSerializer.h"


@implementation LetvHttpRequestSerializer
+ (instancetype) serializer {
    return [[self alloc] init];
}

- (instancetype) init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSURLRequest*) requestBySerializingRequest: (NSURLRequest*) request
                                      withParameters: (nullable id) parameters
                                               error: (NSError *_Nullable __autoreleasing*) error
{
    id newParameters = [self parametersByAppendingParameters: parameters
            error: error];
    if (*error) {
        return nil;
    }

    NSURLRequest* newRequest = [super requestBySerializingRequest: request
                                                   withParameters: newParameters
                                                            error: error];

    if (newRequest != nil && (*error) == nil) {
        return [self requestBySigningRequest: newRequest error: error];
    } else {
        return nil;
    }
}

- (nullable id) parametersByAppendingParameters: (id) parameters error: (NSError* _Nullable __autoreleasing*) error
{
    if (self.parametersRewriteBlock) {
        return self.parametersRewriteBlock(parameters, error);
    } else {
        return parameters;
    }
}

- (NSURLRequest*) requestBySigningRequest: (NSURLRequest*) request error: (NSError* _Nullable __autoreleasing*) error
{
    if (self.requestRewriteBlock) {
        return self.requestRewriteBlock(request, error);
    } else {
        return request;
    }
}
@end
