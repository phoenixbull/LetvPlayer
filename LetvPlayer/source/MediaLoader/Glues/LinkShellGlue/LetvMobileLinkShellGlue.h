//
// Created by Kerberos Zhang on 2018/11/28.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "LetvMobileLinkShellModuleTrait.h"


NS_ASSUME_NONNULL_BEGIN
@interface LetvMobileLinkShellGlue : NSObject <LetvMobileLinkShellModuleTrait>
- (RACSignal<NSNumber*>*) ltrx_setup;
- (RACSignal<NSString*>*) ltrx_decryptURLString: (NSString* _Nonnull) urlString;
@end
NS_ASSUME_NONNULL_END