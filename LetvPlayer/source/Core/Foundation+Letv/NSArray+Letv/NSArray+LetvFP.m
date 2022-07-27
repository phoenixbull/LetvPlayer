//
// Created by Kerberos Zhang on 2018/11/22.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import "NSArray+LetvFP.h"


@implementation NSArray (LetvFP)
- (NSArray*) letv_mapObjectsUsingBlock: (id (^)(id obj, NSUInteger index)) block
{
    NSMutableArray* result = [NSMutableArray arrayWithCapacity: self.count];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [result addObject: block(obj, idx)];
    }];

    return result;
}

- (NSArray*) letv_filterObjectsUsingBlock: (BOOL (^)(id obj, NSUInteger index)) block
{
    NSMutableArray* result = [NSMutableArray arrayWithCapacity: self.count];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (block(obj, idx)) {
            [result addObject: obj];
        }
    }];

    return result;
}
@end