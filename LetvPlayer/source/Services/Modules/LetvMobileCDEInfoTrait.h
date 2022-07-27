//
//  LetvMobileCDEInfoTrait.h
//  LetvMobilePlayerSDK
//
//  Created by Zhang Qigang on 2019/1/3.
//  Copyright © 2019 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol LetvMobileCDEInfoTrait <NSObject>
@property (nonatomic, copy, readonly) NSString* appIdentifier;
@property (nonatomic, copy, readonly) NSString* versionString;
@end
NS_ASSUME_NONNULL_END
