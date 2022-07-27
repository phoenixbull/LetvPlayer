//
//  AFHTTPSessionManager+Letv.m
//  LetvMobileNetworking
//
//  Created by Kerberos Zhang on 2018/11/22.
//  Copyright © 2018年 Letv. All rights reserved.
//


#import "AFHTTPSessionManager+Letv.h"


@implementation AFHTTPSessionManager (Letv)
- (instancetype) letv_initWithBaseURLString:(NSString*) urlString sessionConfiguration:(NSURLSessionConfiguration *)configuration
{
    NSURL* url = [NSURL URLWithString: urlString];

    return [self initWithBaseURL: url sessionConfiguration: configuration];
}

- (instancetype) letv_initWithBaseURLString:(NSString*) urlString
{
    return [self letv_initWithBaseURLString: urlString sessionConfiguration: nil];
}
@end
