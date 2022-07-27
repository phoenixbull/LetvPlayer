//
// Created by Kerberos Zhang on 2018/11/28.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "LetvMobileAdvertiseModuleTrait.h"


NS_ASSUME_NONNULL_BEGIN
@interface LetvMobileAdvertiseGlue : NSObject <LetvMobileAdvertiseModuleTrait>
- (RACSignal*) ltrx_requestAdvertise: (id<LetvMobileAdvertiseRequestTrait>) parameters;
@end
NS_ASSUME_NONNULL_END