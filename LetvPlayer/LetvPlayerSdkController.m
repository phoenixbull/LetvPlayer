//
//  LetvPlayerSdkController.m
//  LetvMobilePlayerSDK
//
//  Created by letv_lzb on 2022/7/14.
//  Copyright © 2022 Letv. All rights reserved.
//

#import "LetvPlayerSdkController.h"
#import <LetvPlayer/LetvPlayer.h>
#import "LetvPlayerManager_Private.h"

@interface LetvPlayerSdkController ()

@property(nonatomic, copy) NSString* vid;
@property(nonatomic, assign) BOOL useP2p;
@property(nonatomic, assign) LetvMobilePlayerStreamCode streamCode;
//@property(nonatomic, strong) LetvMobilePlayerDisplayView* displayView;

@property(nonatomic, strong) RACDisposable* disposable;

@property(nonatomic, strong) id<LetvMobilePlayTrackingTrait> playTracker;
@property(nonatomic, strong) id<LetvMobileAppScheduleServiceTrait> appScheduler;
@property(nonatomic, strong) id<LetvMobileTimestampServiceTrait> timestampService;
@property(nonatomic, strong, readwrite) LetvMobileMediaLoader* loader;

@end

@implementation LetvPlayerSdkController

- (instancetype) initWithVid: (NSString*) vid p2p:(BOOL)useP2p
                  streamCode: (LetvMobilePlayerStreamCode) streamCode {
    self = [super init];
    if (self) {
        self.vid = vid;
        self.useP2p = useP2p;
        self.streamCode = streamCode;
        [self setupRx];
    }
    return self;
}


- (void) setupRx {
    // TODO: 虽然有规范, 但是不全.! 心跳如何处理? 返回前台如何处理?
    /*
    @weakify(self);
    [[self.appScheduler.ltrx_state
     takeUntil: self.rac_willDeallocSignal]
     subscribeNext:^(NSNumber * _Nullable x) {
         @strongify(self);
         if (x.integerValue == LetvMobileAppStateBackground) {
             [self.playTracker trackEnd];
         } else if (x.integerValue == LetvMobileAppStateActive) {
             [self.playTracker trackPlay];
         } else if (x.integerValue == LetvMobileAppStateInactive) {
             [self.playTracker trackEnd];
         }
     }];
     */
}


- (void)startProcess {
    LetvPlayerManager* sdk = [LetvPlayerManager sharedSDK];
    if (sdk._uuid == nil || sdk._uuid.length <= 0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(LetvMobilePlayerControllerFailed:useP2p:)]) {

            [self.delegate LetvMobilePlayerControllerFailed:LETV_ERROR(LetvErrorCodeIllegalData, @"SDK未初始化或者uuid为空") useP2p:self.useP2p];
        }
        return;
    }
    if (self.vid == nil || self.vid.length <= 0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(LetvMobilePlayerControllerFailed:useP2p:)]) {

            [self.delegate LetvMobilePlayerControllerFailed:LETV_ERROR(LetvErrorCodeIllegalData, @"视频id为空") useP2p:self.useP2p];
        }
        return;
    }
    [self loadMediaWithVid:self.vid streamCode:self.streamCode p2p:self.useP2p];
}


- (void) loadMediaWithVid: (NSString*) vid streamCode: (LetvMobilePlayerStreamCode) streamCode p2p:(BOOL)useP2p {

    NSString* streamId = ^{
        switch (streamCode) {
            case LetvMobilePlayerStreamCodeLD:
                return @"mp4_180";
            case LetvMobilePlayerStreamCodeMD:
                return @"mp4_350";
            case LetvMobilePlayerStreamCodeSD:
                return @"mp4_800";
            case LetvMobilePlayerStreamCodeHD:
                return @"mp4_720p";
            case LetvMobilePlayerStreamCodeTD:
                return @"mp4_1300";
            default:
                return @"mp4_350";
        }
    }();

    /*
     58 mp4_180
     21 mp4_350
     13 mp4_800
     22 mp4_1300
     51 mp4_720p
     */

    NSInteger videoType = ^{
        switch (streamCode) {
            case LetvMobilePlayerStreamCodeLD:
                return 58;
            case LetvMobilePlayerStreamCodeMD:
                return 21;
            case LetvMobilePlayerStreamCodeSD:
                return 13;
            case LetvMobilePlayerStreamCodeHD:
                return 51;
            case LetvMobilePlayerStreamCodeTD:
                return 22;
            default:
                return 21;
        }
    }();
    [self.playTracker trackInitWithVid: vid
                                    vt: videoType];
    @weakify(self);
    RACSignal<NSDictionary*>* loadSignal = [self.loader ltrx_loadWithVid: vid streamId: streamId uid:@"" p2p:useP2p];
    RACSignal* appSignal = [[[self.appScheduler ltrx_state]
                             filter:^BOOL(NSNumber * _Nullable state) {
                                 return state.integerValue == LetvMobileAppStateActive;
                             }]
                            take: 1];

    RACSignal* signal = [RACSignal zip: @[loadSignal, appSignal] reduce:^(NSDictionary* url, NSNumber* state){
        return url;
    }];

    // TODO: takeUntile or dispose ?

    RACDisposable* dispose = [[signal
     deliverOn: RACScheduler.mainThreadScheduler]
     subscribeNext:^(NSDictionary * _Nullable url) {
         @strongify(self);
         // TODO: 前台.
        NSString *p2p = [url objectForKey:@"p2p"];
        NSString *moveUrl = nil;
        BOOL isUseP2p = [p2p intValue] == 1;
        if (isUseP2p) {
            moveUrl = [url objectForKey:@"cdeurl"];
        }else {
            moveUrl = [url objectForKey:@"cdnurl"];
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(LetvMobilePlayerControllerSuccess:useP2p:metadata:)]) {
            [self.delegate LetvMobilePlayerControllerSuccess:moveUrl useP2p:isUseP2p metadata:url];
        }
     }
     error:^(NSError * _Nullable error) {
         @strongify(self);
        if (error.code == LetvErrorCodeEmpty) {
            id info = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
            if (info && [info isKindOfClass:[NSArray class]]) {
                NSArray *supportList = (NSArray *)info;
                NSString *nextStreamid = [self getNextStreamid:streamId supportStreamList:supportList];
                self.streamCode = [self getStreamCodeWithStreamId:nextStreamid];
                if (self.streamCode != LetvMobilePlayerStreamCodeUnknown) {
                    [self loadMediaWithVid:self.vid streamCode:self.streamCode p2p:self.useP2p];
                    return;
                }
            }
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(LetvMobilePlayerControllerFailed:useP2p:)]) {
            [self.delegate LetvMobilePlayerControllerFailed:error useP2p:useP2p];
        }
     }];

    [self.disposable dispose];
    self.disposable = dispose;
}


- (NSString *)getNextStreamid:(NSString *)streamId supportStreamList:(NSArray *)supportStream {
    if (streamId == nil || streamId <= 0
        || nil == supportStream
        || supportStream.count <= 0) {
        return nil;
    }
    NSString *nextStreamId = nil;
    if ([streamId isEqualToString:@"mp4_180"]) {
        nextStreamId = @"mp4_350";
    }else if([streamId isEqualToString:@"mp4_350"]) {
        nextStreamId = @"mp4_800";
    }else if([streamId isEqualToString:@"mp4_800"]) {
        nextStreamId = @"mp4_720p";
    }else if([streamId isEqualToString:@"mp4_720p"]) {
        nextStreamId = @"mp4_1300";
    }else {
        nextStreamId = @"mp4_350";
    }
    if (![supportStream containsObject:nextStreamId]) {
        nextStreamId = [supportStream firstObject];
    }
    return nextStreamId;
}


- (LetvMobilePlayerStreamCode)getStreamCodeWithStreamId:(NSString *)streamId {
    if ([streamId isEqualToString:@"mp4_180"]) {
        return LetvMobilePlayerStreamCodeLD;
    }else if([streamId isEqualToString:@"mp4_350"]) {
        return LetvMobilePlayerStreamCodeMD;
    }else if([streamId isEqualToString:@"mp4_800"]) {
        return LetvMobilePlayerStreamCodeSD;
    }else if([streamId isEqualToString:@"mp4_720p"]) {
        return LetvMobilePlayerStreamCodeHD;
    }else if([streamId isEqualToString:@"mp4_1300"]){
        return LetvMobilePlayerStreamCodeTD;
    }else {
        return LetvMobilePlayerStreamCodeUnknown;
    }
}


- (id<LetvMobilePlayTrackingTrait>) playTracker {
    if (!_playTracker) {
        LetvPlayerManager* sdk = [LetvPlayerManager sharedSDK];
        _playTracker = [LetvMobileServicesFactory.defaultFactory createPlayTrackerWithLoginTracker: sdk.loginTrackingTrait];
    }
    return _playTracker;
}

- (id<LetvMobileTimestampServiceTrait>) timestampService {
    if (!_timestampService) {
        _timestampService = [LetvMobileServicesFactory.defaultFactory createTimestampService];
    }
    return _timestampService;
}

- (LetvMobileMediaLoader*) loader {
    if (!_loader) {
        _loader = [[LetvMobileMediaLoader alloc] init];
    }
    return _loader;
}

- (id<LetvMobileAppScheduleServiceTrait>) appScheduler {
    if (!_appScheduler) {
        _appScheduler = [LetvMobileServicesFactory.defaultFactory createAppScheduleService];
    }
    return _appScheduler;
}


@end
