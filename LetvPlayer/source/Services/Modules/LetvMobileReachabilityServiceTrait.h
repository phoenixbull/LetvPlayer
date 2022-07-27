//
// Created by Kerberos Zhang on 2018/11/30.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>


typedef NS_ENUM(NSInteger, LetvMobileNetworkState) {
    LetvMobileNetworkStateNone,
    LetvMobileNetworkStateWWAN,
    LetvMobileNetworkStateWifi,
};


NS_ASSUME_NONNULL_BEGIN
@protocol LetvMobileReachabilityServiceTrait <NSObject>
- (RACSignal<NSNumber*>*) ltrx_state;
@end
NS_ASSUME_NONNULL_END