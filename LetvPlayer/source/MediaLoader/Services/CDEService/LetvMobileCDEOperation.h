//
// Created by Kerberos Zhang on 2018/11/30.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LetvPlayer/LetvMobileCore.h>


NS_ASSUME_NONNULL_BEGIN
@interface LetvMobileCDEOperation : NSObject <LetvMobileCancelTrait>
- (instancetype) initWithDispose: (RACDisposable*) dispose;
- (void) cancel;
@end
NS_ASSUME_NONNULL_END
