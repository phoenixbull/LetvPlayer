//
//  LetvTimestampClient.h
//  LetvMobileNetworking
//
//  Created by Kerberos Zhang on 2018/11/22.
//  Copyright © 2018年 Letv. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <LetvPlayer/LetvMobileCore.h>


@class LetvTimestampModel;

NS_ASSUME_NONNULL_BEGIN
@interface LetvTimestampClient : NSObject
+ (instancetype) client;

- (RACSignal<LetvTimestampModel*>*) ltrx_requestTimestamp;
@end
NS_ASSUME_NONNULL_END
