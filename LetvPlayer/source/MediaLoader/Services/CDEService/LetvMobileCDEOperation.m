//
// Created by Kerberos Zhang on 2018/11/30.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import <ReactiveObjC/ReactiveObjC.h>
#import "LetvMobileCDEOperation.h"


@interface LetvMobileCDEOperation ()
@property (nonatomic, strong) RACDisposable* dispose;
@end

@implementation LetvMobileCDEOperation
- (instancetype) initWithDispose: (RACDisposable*) dispose
{
    self = [super init];
    if (self) {
        _dispose = dispose;
    }
    return self;
}

- (void)cancel
{
    [self.dispose dispose];
    self.dispose = nil;
}
@end