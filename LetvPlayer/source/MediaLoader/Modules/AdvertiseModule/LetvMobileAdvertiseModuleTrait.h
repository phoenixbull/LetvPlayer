//
// Created by Kerberos Zhang on 2018/11/30.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LetvMobileAdvertiseRequestTrait <NSObject>
@end

NS_ASSUME_NONNULL_BEGIN
@protocol LetvMobileAdvertiseModuleTrait <NSObject>
- (RACSignal*) ltrx_requestAdvertise: (id<LetvMobileAdvertiseRequestTrait>) parameters;
@end
NS_ASSUME_NONNULL_END