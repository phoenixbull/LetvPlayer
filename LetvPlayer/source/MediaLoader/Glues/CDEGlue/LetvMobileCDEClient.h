//
// Created by Kerberos Zhang on 2018/11/28.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "LetvMobileCDEModuleTrait.h"


NS_ASSUME_NONNULL_BEGIN
@interface LetvMobileCDEClient : NSObject <LetvMobileCDEModuleTrait>
- (RACSignal<NSString*>*) ltrx_startTaskWithURLString: (NSString*) taskURLString;
- (RACSignal*) ltrx_stopTaskWithURLString: (NSString*) taskURLString;
- (RACSignal*) ltrx_pauseTaskWithURLString: (NSString*) taskURLString;
- (RACSignal*) ltrx_resumeTaskWithURLString: (NSString*) taskURLString;
- (RACSignal*) ltrx_seekTaskWithURLString: (NSString*) taskURLString duration: (NSTimeInterval) duration;
@end
NS_ASSUME_NONNULL_END