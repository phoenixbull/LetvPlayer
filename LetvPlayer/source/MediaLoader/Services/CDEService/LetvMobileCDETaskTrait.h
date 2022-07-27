//
// Created by Kerberos Zhang on 2018/11/30.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LetvPlayer/LetvMobileCore.h>

NS_ASSUME_NONNULL_BEGIN
@protocol LetvMobileCDETaskTrait <NSObject>
@property (nonatomic, readonly, copy, nullable) NSString* hostedURLString;
- (id<LetvMobileCancelTrait>) pause;
- (id<LetvMobileCancelTrait>) resume;
- (id<LetvMobileCancelTrait>) stop;
@end
NS_ASSUME_NONNULL_END
