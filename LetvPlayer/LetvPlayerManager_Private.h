//
//  LetvPlayerManager_Private.h
//  LetvMobilePlayerSDK
//
//  Created by letv_lzb on 2022/7/14.
//  Copyright © 2022 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LetvPlayer/LetvPlayerHeader.h>


NS_ASSUME_NONNULL_BEGIN
@interface LetvPlayerManager : NSObject
LETV_SINGLETON_DECLARE(sharedSDK)
@property(nonatomic, copy) NSString* _uuid;

@property(nonatomic, strong) id<LetvMobileLoginTrackingTrait> loginTrackingTrait;

- (instancetype) init NS_UNAVAILABLE;
@end

@interface LetvPlayerManager (MediaLoader) <LetvMobileMediaLoaderDefaultParametersTrait>
@property(nonatomic, copy, readonly) NSString* version;
@property(nonatomic, copy, readonly) NSString* pcode;
@end

@interface LetvPlayerManager (Tracking) <LetvMobileTrackingTrait>
@property(nonatomic, copy, readonly) NSString* pcode;
@property(nonatomic, copy, readonly) NSString* p1;
@property(nonatomic, copy, readonly) NSString* p2;
@property(nonatomic, copy, readonly) NSString* p3;
@property(nonatomic, copy, readonly) NSString* appName;
@property(nonatomic, copy, readonly) NSString* appVersion;
@property(nonatomic, copy, readonly) NSString* uuid;
@end
NS_ASSUME_NONNULL_END
