//
// Created by Kerberos Zhang on 2018/11/18.
// Copyright (c) 2018 Letv. All rights reserved.
//


#import <LetvPlayer/RxAFNetworking.h>
#import "LetvHttpRequestSerializer.h"
#import "LetvHttpSessionManager.h"


@implementation LetvHttpSessionManager
+ (instancetype) manager {
    return [[self alloc] initWithBaseURL: nil];
}

- (instancetype) initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration
{
    self = [super initWithBaseURL: url sessionConfiguration: configuration];
    if (self) {
        self.requestSerializer = [LetvHttpRequestSerializer serializer];
    }
    
    return self;
}
@end
