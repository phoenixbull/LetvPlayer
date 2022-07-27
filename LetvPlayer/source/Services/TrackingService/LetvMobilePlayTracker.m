//
//  LetvMobilePlayTracker.m
//  LetvMobilePlayerSDK
//
//  Created by Zhang Qigang on 2019/1/3.
//  Copyright © 2019 Letv. All rights reserved.
//

#import "LetvMobileTrackingService.h"
#import "LetvMobileLoginTracker.h"
#import "LetvMobilePlayTracker.h"

@interface LetvMobilePlayTracker ()
@property (nonatomic, copy) NSString* vid;
@property (nonatomic, assign) NSString* videoType;
@property (nonatomic, assign) NSString* videoDuration;
@property (nonatomic, assign) NSString* currentPlayback;

@property (nonatomic, copy) NSString* sessionId;

@property (nonatomic, strong) LetvMobileLoginTracker* loginTracker;
@property (nonatomic, strong) LetvMobileTrackingService* service;
@end

@implementation LetvMobilePlayTracker
- (instancetype) initWithUdid: (NSString*) udid loginTrackTrait: (id<LetvMobileLoginTrackingTrait>) loginTrackTrait
{
    self = [super init];
    if (self) {
        LetvMobileLoginTracker* loginTracker = (LetvMobileLoginTracker*) loginTrackTrait;
        _loginTracker = loginTracker;
        NSInteger tm = (NSInteger)[[NSDate date] timeIntervalSince1970];
        NSString* sessionId = [NSString stringWithFormat: @"%@_%zd", udid, tm];
        _sessionId = sessionId;
    }
    
    return self;
}

- (void) trackInitWithVid: (NSString*) vid
                       vt: (NSInteger) vt
{
    self.vid = vid;
    self.videoType = [NSString stringWithFormat: @"%zd", vt];
    
    [self.service play_initWithLoginSessionId: self.loginTracker.sessionId
                                playSessionId: self.sessionId
                                          vid: self.vid
                                           vt: self.videoType];
}

- (void) trackPlayWithVLen: (NSInteger) vlen
{
    self.videoDuration = [NSString stringWithFormat: @"%zd", vlen];
    
    [self.service play_playWithLoginSessionId: self.loginTracker.sessionId
                                playSessionId: self.sessionId
                                          vid: self.videoType
                                           vt: self.videoType
                                         vlen: self.videoDuration];
}

- (void) trackFinishWithPlayback: (NSInteger) playback
{
    self.currentPlayback = [NSString stringWithFormat: @"%zd", playback];
    
    [self.service play_finishWithLoginSessionId: self.loginTracker.sessionId
                                  playSessionId: self.sessionId
                                            vid: self.vid
                                             vt: self.videoType
                                           vlen: self.videoDuration
                                             pt: self.currentPlayback];
}

- (void) trackEndWithPlayback: (NSInteger) playback
{
    self.currentPlayback = [NSString stringWithFormat: @"%zd", playback];
    [self.service play_endWithLoginSessionId: self.loginTracker.sessionId
                               playSessionId: self.sessionId
                                         vid: self.vid
                                          vt: self.videoType
                                        vlen: self.videoDuration
                                          pt: self.currentPlayback];
}

#pragma mark -
#pragma mark getter

- (LetvMobileTrackingService*) service {
    if (!_service) {
        _service = [LetvMobileTrackingService sharedService];
    }
    return _service;
}
@end
