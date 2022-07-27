//
// Created by Kerberos Zhang on 2018/11/28.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <LetvPlayer/LetvSingleton.h>
#import "LetvMobileCDETaskTrait.h"


NS_ASSUME_NONNULL_BEGIN
@interface LetvMobileCDEService : NSObject
LETV_SINGLETON_DECLARE(sharedService)

- (RACSignal<id<LetvMobileCDETaskTrait>>*) startTaskWithURLString: (NSString*) URLString;
- (RACSignal<id<LetvMobileCDETaskTrait>>*) startTaskWithURLString: (NSString*) URLString
                   skipPrerollAdvertiseWithDuration: (NSTimeInterval) advertiseDuration
                              startAtPositiveOffset: (NSTimeInterval) positiveOffset;
- (RACSignal<id<LetvMobileCDETaskTrait>>*) startTaskWithURLString: (NSString*) URLString
                                  playAtVideoOffset: (NSTimeInterval) videoOffset;

- (id<LetvMobileCancelTrait>) pauseTask: (id<LetvMobileCDETaskTrait>) task;
- (id<LetvMobileCancelTrait>) resumeTask: (id<LetvMobileCDETaskTrait>) task;
- (id<LetvMobileCancelTrait>) stopTask: (id<LetvMobileCDETaskTrait>) task;
- (id<LetvMobileCancelTrait>) seekTask: (id<LetvMobileCDETaskTrait>) task toDuration: (NSTimeInterval) seekDuration;
@end
NS_ASSUME_NONNULL_END
