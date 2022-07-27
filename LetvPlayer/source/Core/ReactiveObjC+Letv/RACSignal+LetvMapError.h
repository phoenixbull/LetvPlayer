//
// Created by Kerberos Zhang on 2018/11/24.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface RACSignal<__covariant ValueType> (LetvMapError)
- (RACSignal<ValueType>*) ltrx_mapError: (NSError* (^)(NSError* error)) block;
@end
