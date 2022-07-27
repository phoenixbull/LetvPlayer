//
//  LetvMobileMediaLoaderDefaultParametersTrait.h
//  LetvMobilePlayerSDK
//
//  Created by Zhang Qigang on 2018/12/26.
//  Copyright © 2018 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LetvMobileMediaLoaderDefaultParametersTrait <NSObject>
@property(nonatomic, copy, readonly) NSString* version;
@property(nonatomic, copy, readonly) NSString* pcode;
@end

NS_ASSUME_NONNULL_END
