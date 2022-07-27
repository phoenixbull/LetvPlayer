//
//  LetvMobileTrackingService.h
//  LetvMobilePlayerSDK
//
//  Created by Zhang Qigang on 2018/12/26.
//  Copyright © 2018 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <LetvPlayer/LetvMobileCore.h>
#import "LetvMobileStartupTrait.h"
#import "LetvMobileTrackingServiceTrait.h"

NS_ASSUME_NONNULL_BEGIN

@interface LetvMobileTrackingService : NSObject<LetvMobileStartupTrait, LetvMobileTrackingServiceTrait>
LETV_SINGLETON_DECLARE(sharedService)
- (void) startup;
- (void) loginWithSessionId: (NSString*) sessionId;

- (void) play_initWithLoginSessionId: (NSString*) loginSessionId
                       playSessionId: (NSString*) playSessionId
                                 vid: (NSString*) vid
                                  vt: (NSString*) vt;

- (void) play_playWithLoginSessionId: (NSString*) loginSessionId
                       playSessionId: (NSString*) playSessionId
                                 vid: (NSString*) vid
                                  vt: (NSString*) vt
                                vlen: (NSString*) vlen;

- (void) play_finishWithLoginSessionId: (NSString*) loginSessionId
                         playSessionId: (NSString*) playSessionId
                                   vid: (NSString*) vid
                                    vt: (NSString*) vt
                                  vlen: (NSString*) vlen
                                    pt: (NSString*) pt;

- (void) play_endWithLoginSessionId: (NSString*) loginSessionId
                      playSessionId: (NSString*) playSessionId
                               vid : (NSString*) vid
                                 vt: (NSString*) vt
                               vlen: (NSString*) vlen
                                 pt: (NSString*) pt;
@end

NS_ASSUME_NONNULL_END
