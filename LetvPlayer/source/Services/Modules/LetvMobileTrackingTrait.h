//
//  LetvMobileTrackingTrait.h
//  LetvMobilePlayerSDK
//
//  Created by Zhang Qigang on 2018/12/29.
//  Copyright © 2018 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol LetvMobileTrackingTrait <NSObject>
@property (nonatomic, copy, readonly) NSString* pcode;
@property (nonatomic, copy, readonly) NSString* p1;
@property (nonatomic, copy, readonly) NSString* p2;
@property (nonatomic, copy, readonly) NSString* p3;
@property (nonatomic, copy, readonly) NSString* appName;
@property (nonatomic, copy, readonly) NSString* appVersion;
@property (nonatomic, copy, readonly) NSString* uuid;
@end
NS_ASSUME_NONNULL_END
