//
// Created by Kerberos Zhang on 2018/11/18.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import "AFHTTPSessionManager+Rx.h"


@implementation AFHTTPSessionManager (Rx)
- (RACSignal*) rx_GET: (NSString*) path
            parameters: (nullable id) parameters
{
    return [RACSignal createSignal: ^RACDisposable* (id <RACSubscriber> subscriber) {
        NSURLSessionTask* dataTask = [self GET:path parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [subscriber sendNext: responseObject];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendError: error];
        }];
        return [RACDisposable disposableWithBlock: ^{
            [dataTask cancel];
        }];
    }];
}

- (RACSignal*) rx_POST: (NSString*) path
             parameters: (nullable id) parameters
{
    return [RACSignal createSignal: ^RACDisposable* (id <RACSubscriber> subscriber) {
        NSURLSessionTask* dataTask = [self POST: path
                                     parameters: parameters
                                        headers:nil
                                       progress: nil
                                        success: ^(NSURLSessionDataTask *task, id responseObject) {
                                            [subscriber sendNext: responseObject];
                                            [subscriber sendCompleted];
                                        }
                                        failure: ^(NSURLSessionDataTask *task, NSError *error) {
                                            [subscriber sendError: error];
                                        }];
        return [RACDisposable disposableWithBlock: ^{
            [dataTask cancel];
        }];
    }];
}

- (RACSignal*) rx_PUT: (NSString*) path
            parameters: (nullable id) parameters
{
    return [RACSignal createSignal: ^RACDisposable* (id <RACSubscriber> subscriber) {
        NSURLSessionTask* dataTask = [self PUT: path
                                     parameters: parameters
                                       headers:nil
                                        success: ^(NSURLSessionDataTask *task, id responseObject) {
                                            [subscriber sendNext: responseObject];
                                            [subscriber sendCompleted];
                                        }
                                        failure: ^(NSURLSessionDataTask *task, NSError *error) {
                                            [subscriber sendError: error];
                                        }];
        return [RACDisposable disposableWithBlock: ^{
            [dataTask cancel];
        }];
    }];
}

- (RACSignal*) rx_DELETE: (NSString*) path
               parameters: (nullable id) parameters
{
    return [RACSignal createSignal: ^RACDisposable* (id <RACSubscriber> subscriber) {
        NSURLSessionTask* dataTask = [self DELETE: path
                                    parameters: parameters
                                          headers:nil
                                       success: ^(NSURLSessionDataTask *task, id responseObject) {
                                           [subscriber sendNext: responseObject];
                                           [subscriber sendCompleted];
                                       }
                                       failure: ^(NSURLSessionDataTask *task, NSError *error) {
                                           [subscriber sendError: error];
                                       }];
        return [RACDisposable disposableWithBlock: ^{
            [dataTask cancel];
        }];
    }];
}

- (RACSignal*) rx_PATCH: (NSString*) path
              parameters: (nullable id) parameters
{
    return [RACSignal createSignal: ^RACDisposable* (id <RACSubscriber> subscriber) {
        NSURLSessionTask* dataTask = [self PATCH: path
                                       parameters: parameters
                                         headers:nil
                                          success: ^(NSURLSessionDataTask *task, id responseObject) {
                                              [subscriber sendNext: responseObject];
                                              [subscriber sendCompleted];
                                          }
                                          failure: ^(NSURLSessionDataTask *task, NSError *error) {
                                              [subscriber sendError: error];
                                          }];
        return [RACDisposable disposableWithBlock: ^{
            [dataTask cancel];
        }];
    }];
}
@end
