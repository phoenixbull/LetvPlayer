//
// Created by Kerberos Zhang on 2018/11/29.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <LetvPlayer/LetvSingleton.h>

NS_ASSUME_NONNULL_BEGIN
@interface LetvMobileCDEGlue : NSObject
@property (nonatomic, copy, readonly) NSString* cachePath;
@property (nonatomic, copy, readonly) NSString* logPath;
@property (nonatomic, copy, readonly) NSString* offlineAdvertisePath;
@property (nonatomic, copy, readonly) NSString* versionString;
@property (nonatomic, copy, readonly) NSString* appId;
@property (nonatomic, assign, readonly) NSInteger servicePort;
@property (nonatomic, assign, readonly) NSInteger offlineAdvertiseCacheSize;
@property (nonatomic, assign, readonly) BOOL offlineAdvertiseEnabled;
@property (nonatomic, assign, readonly) BOOL available;

LETV_SINGLETON_DECLARE(sharedGlue)
- (RACSignal<NSString*>*) ltrx_playURLForURLString: (NSString*) urlString;
- (RACSignal<NSString*>*) ltrx_pauseOperationURLForURLString: (NSString*) urlString;
- (RACSignal<NSString*>*) ltrx_resumeOperationURLForURLString: (NSString*) urlString;
- (RACSignal<NSString*>*) ltrx_stopOperationURLForURLString: (NSString*) urlString;
- (RACSignal<NSString*>*) ltrx_hostHLSURLString: (NSString*) urlString;
- (void) seekToDuration: (NSTimeInterval) seekPosition forURLString: (NSString*) urlString;
@end
NS_ASSUME_NONNULL_END
