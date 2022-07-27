//
//  LetvMobileLoginTracker.h
//  LetvMobilePlayerSDK
//
//  Created by Zhang Qigang on 2018/12/28.
//  Copyright © 2018 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LetvMobileLoginTrackingTrait.h"

NS_ASSUME_NONNULL_BEGIN

@interface LetvMobileLoginTracker : NSObject<LetvMobileLoginTrackingTrait>
@property (nonatomic, copy) NSString* sessionId;
- (instancetype) init NS_UNAVAILABLE;
- (instancetype) initWithUdid: (NSString*) udid;

- (void) trackLogin;
@end

NS_ASSUME_NONNULL_END
