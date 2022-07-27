//
// Created by Kerberos Zhang on 2018/11/18.
// Copyright (c) 2018 Letv. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <LetvPlayer/LetvMobileHTTPClientTrait.h>

@interface LetvHttpSessionManager : AFHTTPSessionManager <LetvMobileHTTPClientTrait>
+ (instancetype) manager;
@end
