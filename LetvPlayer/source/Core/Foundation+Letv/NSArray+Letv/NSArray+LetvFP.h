//
// Created by Kerberos Zhang on 2018/11/22.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSArray (LetvFP)
- (NSArray*) letv_mapObjectsUsingBlock: (id (^)(id obj, NSUInteger index)) block;
- (NSArray*) letv_filterObjectsUsingBlock: (BOOL (^)(id obj, NSUInteger index)) block;
@end
