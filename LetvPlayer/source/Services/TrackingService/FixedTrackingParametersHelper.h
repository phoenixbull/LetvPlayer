//
//  FixedTrackingParametersHelper.h
//  LetvMobilePlayerSDK
//
//  Created by Zhang Qigang on 2019/1/2.
//  Copyright © 2019 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LetvPlayer/LetvMobileCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface FixedTrackingParametersHelper : NSObject
LETV_SINGLETON_DECLARE(defaultHelper)
@property (nonatomic, copy, readonly) NSString* udid;

@property (nonatomic, copy, readonly) NSString* networkType;
@property (nonatomic, copy, readonly) NSString* osName;
@property (nonatomic, copy, readonly) NSString* vendor;
@property (nonatomic, copy, readonly) NSString* model;
@property (nonatomic, copy, readonly) NSString* idfa;

@property (nonatomic, copy, readonly) NSString* randomSeed;
@end

NS_ASSUME_NONNULL_END
