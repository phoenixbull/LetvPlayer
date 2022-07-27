//
// Created by Kerberos Zhang on 2018/11/28.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <LetvPlayer/LetvMobileCore.h>
#import <LetvPlayer/LetvMobileServices.h>
#import "LetvMobileLinkShellModuleTrait.h"


NS_ASSUME_NONNULL_BEGIN
@interface LetvMobileLinkShellService : NSObject <LetvMobileStartupTrait, LetvMobileLinkShellModuleTrait>
LETV_SINGLETON_DECLARE(sharedService)
- (RACSignal<NSString*>*) ltrx_decryptURLString: (NSString* _Nonnull) urlString;
@end
NS_ASSUME_NONNULL_END
