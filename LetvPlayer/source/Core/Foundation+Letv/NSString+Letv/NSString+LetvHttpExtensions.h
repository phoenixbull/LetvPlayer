//
//  NSString+LetvHttpExtensions.h
//  LetvMobilePlayerSDK
//
//  Created by letv_lzb on 2020/4/13.
//  Copyright © 2020 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LetvHttpExtensions)

+ (NSString *)letv_replaceString:(NSString *)originURL keyword:(NSString *)keyword toValue:(NSString *)toValue;
+ (BOOL)letv_empty:(NSObject *)o;

+ (BOOL)letv_isBlankString:(NSString *)string;

+ (NSString*)letv_safeString:(NSString*)srcStr;
@end

NS_ASSUME_NONNULL_END
