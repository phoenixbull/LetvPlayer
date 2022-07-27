//
// Created by Kerberos Zhang on 2018/11/18.
// Copyright (c) 2018 Letv. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>


NS_ASSUME_NONNULL_BEGIN
@interface LetvHttpRequestSerializer : AFHTTPRequestSerializer
@property (nonatomic, copy) id (^parametersRewriteBlock)(_Nullable id parameters, NSError* _Nullable __autoreleasing* error);
@property (nonatomic, copy) NSURLRequest* (^requestRewriteBlock)(NSURLRequest* request, NSError* _Nullable __autoreleasing* error);

+ (instancetype) serializer;

- (nullable id) parametersByAppendingParameters: (id) parameters error: (NSError* _Nullable __autoreleasing*) error;
- (NSURLRequest*) requestBySigningRequest: (NSURLRequest*) request error: (NSError* _Nullable __autoreleasing*) error;
@end
NS_ASSUME_NONNULL_END
