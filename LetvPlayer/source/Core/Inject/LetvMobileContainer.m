//
// Created by Kerberos Zhang on 2018/11/25.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import "LetvMobileContainer.h"


@interface LetvMobileContainer ()
@property (nonatomic, strong) NSMutableDictionary* injections;
@end


@implementation LetvMobileContainer
LETV_SINGLETON_IMPL(defaultContainer)

- (instancetype) init
{
    self = [super init];
    if (self) {
        NSMutableDictionary* injections = [NSMutableDictionary dictionaryWithCapacity: 4];
        _injections = injections;
    }

    return self;
}

- (BOOL) injectProtocol: (Protocol*)protokol useBlock:(id (^)(void))block
{
    return [self injectProtocol: protokol useBlock: block forceOverwrite: NO];
}

- (BOOL) injectProtocol: (Protocol*)protokol useBlock:(id (^)(void))block forceOverwrite: (BOOL) force
{
    BOOL ret = NO;
    @synchronized (self) {
        NSString* key = NSStringFromProtocol(protokol);
        if (force) {
            self.injections[key] = block;
            ret = YES;
        } else {
            if (!self.injections[key]) {
                self.injections[key] = block;
                ret = YES;
            }
        }
    }
    return ret;
}

- (id) resolveProtocol: (Protocol*)protokol
{
    id ret = nil;
    @synchronized (self) {
        NSString* key = NSStringFromProtocol(protokol);
        id (^block)(void) = self.injections[key];
        if (block) {
            ret = block();
        }
    }
    return ret;
}
@end
