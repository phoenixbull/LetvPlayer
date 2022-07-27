//
//  AFHTTPSessionManager+Letv.h
//  LetvMobileNetworking
//
//  Created by Kerberos Zhang on 2018/11/22.
//  Copyright © 2018年 Letv. All rights reserved.
//


#import <AFNetworking/AFNetworking.h>


@interface AFHTTPSessionManager (Letv)
- (instancetype) letv_initWithBaseURLString:(NSString*) urlString sessionConfiguration:(NSURLSessionConfiguration *)configuration;
- (instancetype) letv_initWithBaseURLString:(NSString*) urlString;
@end
