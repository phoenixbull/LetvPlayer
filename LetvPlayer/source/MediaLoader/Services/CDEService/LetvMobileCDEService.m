//
// Created by Kerberos Zhang on 2018/11/28.
// Copyright (c) 2018 Letv. All rights reserved.
//
#import "LetvMobileCDEModuleTrait.h"
#import "LetvMobileCDEClient.h"
#import "LetvMobileCDETaskTrait.h"
#import "LetvMobileCDEOperation.h"
#import "LetvMobileCDEService.h"


@protocol LetvMobileCDEHostable <NSObject>
- (NSString*) hostingURLString;
@end


@interface LetvMobileCDETask : NSObject <LetvMobileCDETaskTrait, LetvMobileCDEHostable>
@property (nonatomic, copy) NSString* hostingURLString;
@property (nonatomic, copy) NSString* hostedURLString;
@end

@implementation LetvMobileCDETask
- (id<LetvMobileCancelTrait>) pause
{
    return [LetvMobileCDEService.sharedService pauseTask: self];
}

- (id<LetvMobileCancelTrait>) resume
{
    return [LetvMobileCDEService.sharedService resumeTask: self];
}

- (id<LetvMobileCancelTrait>) stop
{
    return [LetvMobileCDEService.sharedService stopTask: self];
}

- (NSString*) url
{
    return self.hostingURLString;
}

- (void) dealloc
{
    [LetvMobileCDEService.sharedService stopTask: self];
}
@end


@interface LetvMobileCDEService ()
@property (nonatomic, strong) id<LetvMobileCDEModuleTrait> client;

- (RACSignal<id<LetvMobileCDETaskTrait>>*) startTaskWithURLString: (NSString*) URLString
                   skipPrerollAdvertiseWithDuration: (NSTimeInterval) advertiseDuration
                              startAtPositiveOffset: (NSTimeInterval) positiveOffset
                                  playAtVideoOffset: (NSTimeInterval) videoOffset;

@end


@implementation LetvMobileCDEService
LETV_SINGLETON_IMPL(sharedService)

#pragma mark -
#pragma mark initialize & finalize

- (instancetype) init
{
    self = [super init];
    if (self) {

    }
    return self;
}

#pragma mark -
#pragma mark Public API
- (RACSignal<id<LetvMobileCDETaskTrait>>*) startTaskWithURLString: (NSString*) URLString
{
    RACSignal* signal = [[self.client ltrx_startTaskWithURLString: URLString]
            map:^id(NSString* hostedURLString) {
                LetvMobileCDETask* task = [[LetvMobileCDETask alloc] init];
                task.hostingURLString = URLString;
                task.hostedURLString = hostedURLString;
                return task;
            }];
    return signal;
}

- (RACSignal<id<LetvMobileCDETaskTrait>>*) startTaskWithURLString: (NSString*) URLString
                   skipPrerollAdvertiseWithDuration: (NSTimeInterval) advertiseDuration
                              startAtPositiveOffset: (NSTimeInterval) positiveOffset
{
    RACSignal* signal = [[self.client ltrx_startTaskWithURLString: URLString]
            map:^id(NSString* hostedURLString) {
                LetvMobileCDETask* task = [[LetvMobileCDETask alloc] init];
                NSString* newHostedURLString =  [hostedURLString stringByAppendingFormat: @"&skipduration=%0.f&skippos=%0.f",
                                                                  advertiseDuration, positiveOffset];
                task.hostedURLString = newHostedURLString;
                task.hostingURLString = URLString;

                return task;
            }];
    return signal;
}

- (RACSignal<id<LetvMobileCDETaskTrait>>*) startTaskWithURLString: (NSString*) URLString
                                  playAtVideoOffset: (NSTimeInterval) videoOffset
{
    RACSignal* signal = [[self.client ltrx_startTaskWithURLString: URLString]
            map:^id(NSString* hostedURLString) {
                LetvMobileCDETask* task = [[LetvMobileCDETask alloc] init];
                task.hostingURLString = URLString;

                NSString* newHostedURLString = [hostedURLString stringByAppendingFormat: @"&playpos=%0.f", videoOffset];
                task.hostedURLString = newHostedURLString;
                return task;
            }];

    return signal;

}

- (RACSignal<id<LetvMobileCDETaskTrait>>*) startTaskWithURLString: (NSString*) URLString
                    skipPrerollAdvertiseWithDuration: (NSTimeInterval) advertiseDuration
                               startAtPositiveOffset: (NSTimeInterval) positiveOffset
                                   playAtVideoOffset: (NSTimeInterval) videoOffset
{
    RACSignal* signal = [[self.client ltrx_startTaskWithURLString: URLString]
            map:^id(NSString* hostedURLString) {
                LetvMobileCDETask* task = [[LetvMobileCDETask alloc] init];
                task.hostingURLString = URLString;

                task.hostedURLString = [hostedURLString stringByAppendingFormat: @"&skipduration=%0.f&skippos=%0.f&playpos=%0.f",
                                                                  advertiseDuration, positiveOffset, videoOffset];
                return task;
            }];
    return signal;
}

- (id<LetvMobileCancelTrait>) pauseTask: (id<LetvMobileCDETaskTrait>) task
{
    if ([task conformsToProtocol: @protocol(LetvMobileCDEHostable)]) {
        id<LetvMobileCDEHostable> t = (id<LetvMobileCDEHostable>)task;
        RACDisposable* dispose = [[self.client ltrx_pauseTaskWithURLString: t.hostingURLString]
                subscribeCompleted: ^{}];
        return [[LetvMobileCDEOperation alloc]
                initWithDispose: dispose];
    }
    return nil;
}

- (id<LetvMobileCancelTrait>) resumeTask: (id<LetvMobileCDETaskTrait>) task
{
    if ([task conformsToProtocol: @protocol(LetvMobileCDEHostable)]) {
        id<LetvMobileCDEHostable> t = (id<LetvMobileCDEHostable>)task;
        RACDisposable* dispose = [[self.client ltrx_resumeTaskWithURLString: t.hostingURLString]
                subscribeCompleted: ^{}];

        return [[LetvMobileCDEOperation alloc]
                initWithDispose: dispose];
    }
    return nil;
}

- (id<LetvMobileCancelTrait>) stopTask: (id<LetvMobileCDETaskTrait>) task
{
    if ([task conformsToProtocol: @protocol(LetvMobileCDEHostable)]) {
        id<LetvMobileCDEHostable> t = (id<LetvMobileCDEHostable>)task;
        RACDisposable* dispose = [[self.client ltrx_stopTaskWithURLString: t.hostingURLString]
                subscribeCompleted: ^{}];

        return [[LetvMobileCDEOperation alloc]
                initWithDispose: dispose];
    }

    return nil;
}

- (id<LetvMobileCancelTrait>) seekTask: (id<LetvMobileCDETaskTrait>) task toDuration: (NSTimeInterval) seekDuration
{
    if ([task conformsToProtocol: @protocol(LetvMobileCDEHostable)]) {
        id<LetvMobileCDEHostable> t = (id<LetvMobileCDEHostable>)task;
        RACDisposable* dispose = [[self.client ltrx_seekTaskWithURLString: t.hostingURLString duration: seekDuration]
                subscribeCompleted: ^{}];
        return [[LetvMobileCDEOperation alloc]
                initWithDispose: dispose];
    }

    return nil;
}

#pragma mark -
#pragma mark getter

- (id<LetvMobileCDEModuleTrait>) client
{
    if (!_client) {
        _client = [LetvMobileCDEClient new];
    }
    return _client;
}
@end
