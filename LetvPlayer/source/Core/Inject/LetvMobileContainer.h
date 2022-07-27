//
// Created by Kerberos Zhang on 2018/11/25.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LetvPlayer/LetvSingleton.h>


NS_ASSUME_NONNULL_BEGIN
@interface LetvMobileContainer : NSObject
LETV_SINGLETON_DECLARE(defaultContainer)
- (BOOL) injectProtocol: (Protocol*) protokol useBlock: (id _Nonnull (^)(void)) block;
- (BOOL) injectProtocol: (Protocol*) protokol useBlock: (id _Nonnull (^)(void)) block forceOverwrite: (BOOL) force;
- (_Nullable id) resolveProtocol: (Protocol*) protokol;
@end
NS_ASSUME_NONNULL_END
