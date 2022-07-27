//
// Created by Kerberos Zhang on 2018/11/28.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "LetvMobileMediaRequestTrait.h"
#import "LetvMobileMediaPlayTrait.h"


NS_ASSUME_NONNULL_BEGIN
@protocol LetvMobileMediaLoadableState <NSObject, NSCopying>
@end


@protocol LetvMobileMediaLoadTrait <NSObject>
- (RACSignal<id<LetvMobileMediaLoadableState>>*) state;
- (RACSignal<id<LetvMobileMediaPlayTrait>>*) ltrx_loadMediaWithContext: (id<LetvMobileMediaRequestTrait> _Nullable) context;
@end
NS_ASSUME_NONNULL_END