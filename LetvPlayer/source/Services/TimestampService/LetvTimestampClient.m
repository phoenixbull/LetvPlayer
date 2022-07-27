//
//  LetvTimestampClient.m
//  LetvMobileNetworking
//
//  Created by Kerberos Zhang on 2018/11/22.
//  Copyright © 2018年 Letv. All rights reserved.
//


#import <AFNetworking/AFNetworking.h>
#import <JSONModel/JSONModel.h>
#import <LetvPlayer/LetvMobileCore.h>
#import <LetvPlayer/LetvMobileNetworking.h>
#import "RxAFNetworking.h"
#import "LetvMobileModels.h"

#import "LetvMobileServicesGlue.h"
#import "LetvTimestampModel.h"
#import "LetvTimestampClient.h"


@interface LetvTimestampClient ()
@property (nonatomic, strong) id<LetvMobileHTTPClientTrait> httpManager;
@end


@implementation LetvTimestampClient
#pragma mark -
#pragma mark initialize
+ (instancetype) client
{
    return [[self alloc] init];
}

- (instancetype) init
{
    self = [super init];
    if (self) {
    }
    
    return self;
}

#pragma mark -
#pragma mark API

- (RACSignal<LetvTimestampModel*>*) ltrx_requestTimestamp
{
    return [[self.httpManager rx_GET: @"/android/dynamic.php"
                          parameters: @{
                                        @"mod": @"mob",
                                        @"ctl": @"booklive",
                                        @"act": @"getDate",
                                        }]
            ltrx_mapModel: [LetvTimestampModel class]];
}

#pragma mark -
#pragma mark getter

- (id<LetvMobileHTTPClientTrait>) httpManager
{
    @synchronized(self) {
        if (!_httpManager) {
            id<LetvMobileHTTPClientTrait> manager = [[LetvMobileServicesGlue defaultFactory] createTimestampHttpClient];
            _httpManager = manager;
        }
    }
    return _httpManager;
}
@end
