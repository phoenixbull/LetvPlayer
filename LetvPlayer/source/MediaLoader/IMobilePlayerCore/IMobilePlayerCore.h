//
// Created by Kerberos Zhang on 2018/11/17.
// Copyright (c) 2018 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, MobilePlayerLoadingState) {
    MobilePlayerLoadingStateUnknown = -1
};

typedef NS_ENUM(NSInteger, MobilePlayerPlaybackState) {
    MobilePlayerPlaybackStateUnknown = -1
};

typedef NS_ENUM(NSInteger, MobilePlayerExitReason) {
    MobilePlayerExitReasonUnknown = -1
};

@protocol IMobilePlayerCore;

@protocol IMobilePlayerDelegate <NSObject>
@optional
- (void) player: (id<IMobilePlayerCore>) player loadingStateChanged: (MobilePlayerLoadingState) state;
- (void) player: (id<IMobilePlayerCore>) player naturalSizeAvailable: (CGSize) size;
- (void) playerDidFirstFrameDecoded: (id<IMobilePlayerCore>) player;
- (void) playerDidFirstFrameRendered: (id<IMobilePlayerCore>) player;
- (void) playerIsReadyToPlay: (id<IMobilePlayerCore>) player;
- (void) player: (id<IMobilePlayerCore>) player playbackStateChanged: (MobilePlayerPlaybackState) state;
- (void) player: (id<IMobilePlayerCore>) player playbacktimeChanged: (NSTimeInterval) playback;
- (void) player: (id<IMobilePlayerCore>) player playableDurationChanged: (NSTimeInterval) duration;
- (void) playerWillStartSeeking: (id<IMobilePlayerCore>) player;
- (void) playerDidEndSeeking: (id<IMobilePlayerCore>) player;
- (void) player: (id<IMobilePlayerCore>) player didFinishWithReason: (MobilePlayerExitReason) reason;
@end

@protocol IMobilePlayerCore <NSObject>
@property (nonatomic, weak) id<IMobilePlayerDelegate> delegate;
@property (nonatomic, strong, readonly) UIView* displayView;
@property (nonatomic, assign) float duration;
@property (nonatomic, assign) float playableDuration;
@property (nonatomic, assign) float currentPlaybacktime;
@property (nonatomic, assign) float playbackRate;
@property (nonatomic, assign) bool isPreparedToPlay;
@property (nonatomic, assign) float naturalWidth;
@property (nonatomic, assign) float naturalHeight;
@property (nonatomic, assign) int scalingMode;
@property (nonatomic, assign) int playbackState;
@property (nonatomic, assign) int loadingState;
@end

@protocol IMobilePlayerCoreFactory <NSObject>
@property (nonatomic, copy, readonly) NSString* identifier;
- (id<IMobilePlayerCore>) createPlayerWithURL: (NSString*) url;
@end
