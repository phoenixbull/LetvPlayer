//
// Created by Kerberos Zhang on 2018/11/18.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <AFNetworking/AFNetworking.h>


NS_ASSUME_NONNULL_BEGIN
@interface AFHTTPSessionManager (Rx)
- (RACSignal*) rx_GET: (NSString*) path
            parameters: (nullable id) parameters;

- (RACSignal*) rx_POST: (NSString*) path
             parameters: (nullable id) parameters;

- (RACSignal*) rx_PUT: (NSString*) path
             parameters: (nullable id) parameters;

- (RACSignal*) rx_DELETE: (NSString*) path
            parameters: (nullable id) parameters;

- (RACSignal*) rx_PATCH: (NSString*) path
               parameters: (nullable id) parameters;
@end
NS_ASSUME_NONNULL_END