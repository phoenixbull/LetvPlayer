//
// Created by Kerberos Zhang on 2018/11/30.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>


NS_ASSUME_NONNULL_BEGIN
@protocol LetvMobileLinkShellModuleTrait <NSObject>
- (RACSignal<NSString*>*) ltrx_decryptURLString: (NSString* _Nonnull) urlString;
@end
NS_ASSUME_NONNULL_END