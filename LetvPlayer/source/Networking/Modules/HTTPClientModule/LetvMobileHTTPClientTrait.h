//
// Created by Kerberos Zhang on 2018/11/7.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN
@protocol LetvMobileHTTPClientTrait <NSObject>
- (RACSignal*) rx_GET: (NSString*) path parameters: (id _Nullable) parameters;
- (RACSignal*) rx_POST: (NSString*) path parameters: (id _Nullable) parameters;
@end
NS_ASSUME_NONNULL_END