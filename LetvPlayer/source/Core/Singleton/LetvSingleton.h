//
//  LetvSingleton.h
//  LetvMobilePlayerKit
//
//  Created by Kerberos Zhang on 2018/11/22.
//  Copyright © 2018年 Letv. All rights reserved.
//


#import <Foundation/Foundation.h>


#define LETV_SINGLETON_DECLARE(name) \
+ (nonnull instancetype) name;

#define LETV_SINGLETON_IMPL(name) \
+ (nonnull instancetype) name \
{ \
    static dispatch_once_t onceToken = 0; \
    static id name = nil; \
    dispatch_once(&onceToken, ^{ \
        name = [[self alloc] init]; \
    }); \
    return name; \
}
