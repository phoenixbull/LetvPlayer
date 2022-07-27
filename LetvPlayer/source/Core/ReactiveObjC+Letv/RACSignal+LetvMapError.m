//
// Created by Kerberos Zhang on 2018/11/24.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import "RACSignal+LetvMapError.h"


@implementation RACSignal (LetvMapError)
- (RACSignal*) ltrx_mapError: (nonnull NSError* _Nonnull (^)(NSError* _Nonnull error)) block
{
    if (!block) {
        return self;
    }

    return [self catch: ^RACSignal * (NSError * _Nonnull error) {
        NSError* e = block(error);
        return [RACSignal error: e];
    }];
}
@end