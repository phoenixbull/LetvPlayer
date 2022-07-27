//
// Created by Kerberos Zhang on 2018/11/7.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LetvPlayer/LetvMobileCore.h>
#import "LetvMobileHTTPClientTrait.h"
@class LetvTimestampClient;
@class LetvHttpSessionManager;

NS_ASSUME_NONNULL_BEGIN
@interface LetvMobileServicesGlue : NSObject
LETV_SINGLETON_DECLARE(defaultFactory)

- (id<LetvMobileHTTPClientTrait>) createTimestampHttpClient;
@end
NS_ASSUME_NONNULL_END
