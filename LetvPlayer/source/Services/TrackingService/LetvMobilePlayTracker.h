//
//  LetvMobilePlayTracker.h
//  LetvMobilePlayerSDK
//
//  Created by Zhang Qigang on 2019/1/3.
//  Copyright © 2019 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LetvMobileLoginTrackingTrait.h"
#import <LetvPlayer/LetvMobilePlayTrackingTrait.h>

NS_ASSUME_NONNULL_BEGIN

@interface LetvMobilePlayTracker : NSObject <LetvMobilePlayTrackingTrait>
- (instancetype) init NS_UNAVAILABLE;
- (instancetype) initWithUdid: (NSString*) udid loginTrackTrait: (id<LetvMobileLoginTrackingTrait>) loginTrackTrait;

- (void) trackInitWithVid: (NSString*) vid
                       vt: (NSInteger) vt;
- (void) trackPlayWithVLen: (NSInteger) vlen;
- (void) trackFinishWithPlayback: (NSInteger) playback;
- (void) trackEndWithPlayback: (NSInteger) playback;
@end

NS_ASSUME_NONNULL_END
