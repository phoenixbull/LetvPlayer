//
// Created by Kerberos Zhang on 2018/11/25.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import <objc/runtime.h>
#import "NSObject+LetvContainer.h"


static const char* LetvMobileInjectorKey = NULL;

@implementation NSObject (LetvInjector)
- (LetvMobileContainer*) letv_container
{
    return objc_getAssociatedObject(self, &LetvMobileInjectorKey);
}

- (void) setLetv_container:(LetvMobileContainer *)letv_container
{
    objc_setAssociatedObject(self, &LetvMobileInjectorKey, letv_container, OBJC_ASSOCIATION_RETAIN);
}
@end
